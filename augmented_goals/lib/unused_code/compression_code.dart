/*
      // Code that compresses the image but oddly rotates the image at times.
      // TODO check if it will work in a future version of the package?
      getImageInfo(context, _chosenImage.image).then((info){
        int rotation = (info.image.width > info.image.height ? 90: 0);
        print("Rotation: " + rotation.toString());
        compressFile(_file, rotation).then((v){
          setState(() {
            _compressedFile = v;
            _chosenImage = Image.file(_compressedFile);
          });
        });
      });
    });*/
/*  Future<File> compressFile(File file, int minHeight, int minWidth, int rotation) async {
    String path =
        await FirestoreAPI.getApplicationPath() + "/" + basename(file.path);
    print(path);
    var result = await FlutterImageCompress.compressAndGetFile(
        file.absolute.path, path,
        minHeight: minHeight,
        minWidth: minWidth,
        quality: 80,
        rotate: 0,
    );

    print(file.lengthSync());
    print(result.lengthSync());

    return result;
  }*/
/*  Widget pendingImage() {
    return _chosenImage ??
        (_compressing
            ? CircularProgressIndicator(
                value: 0.0,
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(Strings.createPostImageOptional),
                  ),
                ],
              ));
  }*/