import 'dart:io';

import 'package:augmented_goals/util/cache_manager.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class FirestoreImage extends StatefulWidget {
  final StorageReference reference;

  FirestoreImage({Key key, this.reference});

  @override
  FirestoreImageState createState() => FirestoreImageState(reference);
}

class FirestoreImageState extends State<FirestoreImage> {
  File _image;
  StorageReference reference;


  @override
  void initState() {
    super.initState();
    obtainImage();
  }

  FirestoreImageState(StorageReference reference) {
    this.reference = reference;
  }

  void obtainImage(){
    FirestoreCacheManager().getSingleFile(reference.path).then((img) =>
        setState((){
          _image = img;
          //print("Obtain image done - Image is null: ${_image == null}");
        })
    );
  }

  @override
  Widget build(BuildContext context) {
    //print("Image is null: ${_image == null}");
    return _image == null
        ? Center(child: Container(
        width: 75, height: 75, child: CircularProgressIndicator()),)
        : Image.file(_image);
  }
}
