import 'dart:io';
import 'dart:async';

import 'package:augmented_goals/util/firestore_api.dart';
import 'package:exif/exif.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
class UploadState {
  // For creating Post object
  String orientation;
  String fileName = "";

  int width;
  int height;

  // For widget functionality
  File file;
  bool uploading = false;
  String error;

  UploadState();
}

// TODO FINISH
class UploadBloc{

  StreamController<UploadState> uploadStateController = StreamController<UploadState>();
  Sink get updateUploadState => uploadStateController.sink;
  Stream<UploadState> get stream => uploadStateController.stream;

  UploadBloc();

  UploadState initial(){
    return UploadState();
  }

  void dispose(){
    uploadStateController.close();
  }

  void _update(UploadState state){
    updateUploadState.add(state);
  }

  void updateFile(UploadState state, File file) {
    state.file = file;
    state.error = null;
    _update(state);
  }


  void noImageAttached(UploadState state) {
    state.error = "Please attach an image!";
    _update(state);
  }

  Future<StorageTaskSnapshot> uploadFile(UploadState state) async {
    print(state.file.path);
    state.fileName = basename(state.file.path);
    _update(state);

    print(state.fileName);
    final StorageReference ref = FirestoreAPI.storage
        .ref()
        .child('user')
        .child(FirestoreAPI.account.accountId)
        .child(state.fileName);
    final StorageUploadTask uploadTask = ref.putFile(
      state.file,
      StorageMetadata(
        contentLanguage: 'en',
        customMetadata: <String, String>{
          'owner': FirestoreAPI.account.accountId
        },
      ),
    );
    return uploadTask.onComplete;
  }



  void printDimensions(ImageInfo info) {
    var imgW = info.image.width.toString();
    var imgH = info.image.height.toString();
    print("Image - W: $imgW, H: $imgH");
  }

  /// Flutter specific we don't want this in the bloc
  Future setImage(BuildContext context, ImageSource source, state) async {
    File file = await ImagePicker.pickImage(
        source: source, maxHeight: 100.0, maxWidth: 100.0);

    updateFile(state, file);

    // Ensure that the rotation is correct and obtain the dimensions from the
    // exif info before it is removed during the compression.
    List<int> whr = await getEssentialsFromExif(file);
    int width = whr[0];
    int height = whr[1];
    int rotation = whr[2];

    // Compress the file
    File compFile = await compressFile(
        file: file, minHeight: height, minWidth: width, rotation: rotation);

    // Update the state with the width and height of the image
    // (useful for aspect ratio)
    //bloc.updateDimensionsSilently(state: state, width: width, height: height);
    updateFile(state, compFile);

    print("Rotation: " + rotation.toString());
    print("Original size: " + file.lengthSync().toString());
    print("Compressed size: " + compFile.lengthSync().toString());
    print(file.absolute.path);
  }

  Future<File> compressFile(
      {File file, int minHeight, int minWidth, int rotation}) async {
    String path =
        await FirestoreAPI.getApplicationPath() + "/" + basename(file.path);
    print(path);
    var result = await FlutterImageCompress.compressAndGetFile(
      file.absolute.path,
      path,
      minHeight: minHeight,
      minWidth: minWidth,
      quality: 80,
      rotate: rotation,
    );

    print(file.lengthSync());
    print(result.lengthSync());

    return result;
  }

  /// Returns an array with width, height and rotation with indices in that order.
  Future<List<int>> getEssentialsFromExif(File file) async {
    Map<String, IfdTag> data = await readExifFromBytes(file.readAsBytesSync());

    data.keys.forEach((f) => print("exif key: " + f));
    // List for containing the values of interest
    List<int> whr = <int>[0, 0, 0];

    bool isIOS = Platform.isIOS;

    // Obtain the relevant exif values.
    whr[0] = data[isIOS ? 'EXIF ExifImageWidth' : 'Image ImageWidth'].values[0];
    whr[1] = data[isIOS ? 'EXIF ExifImageLength' : 'Image ImageLength'].values[0];
    whr[2] = data['Image Orientation'].values[0];

    print("WHR: " + whr.toString());

    void swap() {
      int t = whr[0];
      whr[0] = whr[1];
      whr[1] = t;
    }

    // Transform the orientation value into the rotation needed in degrees
    // Swap the width and height values when rotation is 90 or 270 degrees.
    switch (whr[2]) {
      case (1): // Horizontal (normal)
        whr[2] = 0;
        break;
      case (2): // Mirror horizontal
        whr[2] = 0;
        break;
      case (3): // Rotate 180
        whr[2] = 180;
        break;
      case (4): // Mirror vertical
        whr[2] = 0;
        break;
      case (5): // Mirror horizontal and rotate 270 CW
        whr[2] = 270;
        swap();
        break;
      case (6): // Rotate 90 CW
        whr[2] = 90;
        swap();
        break;
      case (7): // Mirror horizontal and rotate 90 CW
        whr[2] = 90;
        swap();
        break;
      case (8): // Rotate 270 CW
        whr[2] = 270;
        swap();
        break;
      default:
        whr[2] = 0;
        break;
    }

    print("WHR: " + whr.toString());

    return whr;
  }


}