import 'dart:io';

import 'package:augmented_goals/blocs/create_post.dart';
import 'package:augmented_goals/data_classes/enum/goal_status.dart';
import 'package:augmented_goals/data_classes/goal.dart';
import 'package:augmented_goals/util/firestore_api.dart';
import 'package:augmented_goals/util/strings.dart';
import 'package:augmented_goals/widgets/util/image_options.dart';
import 'package:augmented_goals/widgets/util/text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:path/path.dart';
import 'package:exif/exif.dart';

class CreatePost extends StatefulWidget {
  final Goal goal;
  final DocumentSnapshot goalReference;

  const CreatePost({Key key, this.goal, this.goalReference}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _CreatePostState();
}

class _CreatePostState extends State<CreatePost> {
  CreatePostBloc bloc;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    bloc = CreatePostBloc(widget.goal, widget.goalReference);
  }


  @override
  void dispose() {
    super.dispose();
    bloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: bloc.postState,
        initialData: bloc.initial(),
        builder: (BuildContext ctx, AsyncSnapshot<PostState> snapshot) {
          PostState state = snapshot.data;

          final Widget postTitle = TextFormField(
            decoration: InputDecoration(labelText: Strings.createPostTitle),
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter a title';
              } else {
                state.title = value;
              }
            },
          );

          final Widget postMessage = TextFormField(
            keyboardType: TextInputType.multiline,
            maxLines: 5,
            decoration: InputDecoration(labelText: Strings.createPostMessage),
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter some text';
              } else {
                state.message = value;
              }
            },
          );

          final Widget postState = Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Goal State: ",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                DropdownButton<String>(
                  items: bloc.getPostStates().map((GoalStatus value) {
                    return DropdownMenuItem<String>(
                      value: value.toString(),
                      child: Text(bloc.capitalizedGoalState(value)),
                    );
                  }).toList(),
                  hint: Text("Status"),
                  value: state.postStatus.toString(),
                  onChanged: (String status) =>
                      bloc.setGoalState(state, status),
                )
              ],
            ),
          );

          final buildBody = SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Card(
                          child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(children: <Widget>[
                          Headline("Goal: " + widget.goal.title),
                          ImageOptions(
                            file: state.file,
                            onPhotoFromCamera: () async {
                              setImage(context, ImageSource.camera, state);
                            },
                            onPhotoFromGallery: () async {
                              setImage(context, ImageSource.gallery, state);
                            },
                            errorInfo: state.error,
                          ),
                          postTitle,
                          postMessage,
                          postState
                        ]),
                      )),

                    ],
                  )),
            ),
          );

          return Scaffold(
            appBar: AppBar(
              title: Text(Strings.createPost),
              actions: <Widget>[
                Visibility(
                  visible: !state.uploading,
                  child: IconButton(
                      icon: Icon(Icons.check),
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          await bloc.uploadPost(state);
                          Navigator.pop(ctx);
                        }
                        /*if (state.file == null) {
                          bloc.noImageAttached(state);
                        }*/
                      }),
                )
              ],
            ),
            body: buildBody,
          );
        });
  }

  void printDimensions(ImageInfo info) {
    var imgW = info.image.width.toString();
    var imgH = info.image.height.toString();
    print("Image - W: $imgW, H: $imgH");
  }

  /// Flutter specific we don't want this in the bloc
  Future setImage(BuildContext context, ImageSource source, state) async {
    File file = await ImagePicker.pickImage(
        source: source, maxHeight: 2048.0, maxWidth: 2048.0);

    bloc.updateFile(state, file);

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
    bloc.updateDimensionsSilently(state: state, width: width, height: height);
    bloc.updateFile(state, compFile);

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
