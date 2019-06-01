import 'dart:io';

import 'package:augmented_goals/util/strings.dart';
import 'package:flutter/material.dart';

class ImageOptions extends StatefulWidget {
  final File file;
  final VoidCallback onPhotoFromGallery;
  final VoidCallback onPhotoFromCamera;
  final String errorInfo;

  const ImageOptions(
      {Key key,
      this.file,
      this.onPhotoFromGallery,
      this.onPhotoFromCamera,
      this.errorInfo})
      : super(key: key);

  @override
  ImageOptionsState createState() {
    return new ImageOptionsState();
  }
}

class ImageOptionsState extends State<ImageOptions> {

  @override
  Widget build(BuildContext context) {
    final Widget imageContainer = Container(
        child: widget.file != null
            ? Image.file(widget.file, fit: BoxFit.contain)
            : Icon(Icons.image, size: 75.0, color: Colors.lightBlue),
        constraints: BoxConstraints.expand(height: 75.0, width: 75.0));

    final Widget optionButtons = Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        FlatButton.icon(
            onPressed: () {
              widget.onPhotoFromCamera();
              print("Camera should open");
            },
            icon: Icon(Icons.camera_alt),
            label: Text(Strings.createPostImageNew)),
        FlatButton.icon(
            onPressed: () {
              widget.onPhotoFromGallery();
              print("Image selection dialog should open");
            },
            icon: Icon(Icons.image),
            label: Text(Strings.createPostImageExisting)),
      ],
    );

    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[imageContainer, optionButtons],
        ),
        Visibility(
          visible: widget.errorInfo != null,
          child: widget.errorInfo != null
              ? Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    widget.errorInfo,
                    style: TextStyle(color: Colors.redAccent),
                  ),
                )
              : Container(),
        )
      ],
    );
  }
}
