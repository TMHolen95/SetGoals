import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class FirestoreCacheManager extends BaseCacheManager {
  static const key = "customCache";

  static FirestoreCacheManager _instance;

  factory FirestoreCacheManager() {
    if (_instance == null) {
      _instance = new FirestoreCacheManager._();
    }
    return _instance;
  }

  FirestoreCacheManager._() : super(key,
      maxAgeCacheObject: Duration(days: 2),
      maxNrOfCacheObjects: 75,
      fileFetcher: (string, {headers}) => _firebaseStorageFetcher(string));

  Future<String> getFilePath() async {
    var directory = await getTemporaryDirectory();
    return join(directory.path, key);
  }


  static Future<FileFetcherResponse> _firebaseStorageFetcher(String path) async {
    print(path);
    FirebaseStorage storage = FirebaseStorage.instance;
    StorageReference ref = storage.ref().child(path);
    int statusCode;
    Uint8List data = await ref.getData(0x3FFFFFFF);
    print("Image data is: ${data?.length ?? null}");
    (data == null) ? statusCode = 404 : statusCode =  200;

    return FirebaseStorageFetcher(data, statusCode);
  }

}

class FirebaseStorageFetcher implements FileFetcherResponse{
  Uint8List _imgData;
  int _statusCode;
  FirebaseStorageFetcher(this._imgData, this._statusCode);

  @override
  // TODO: implement bodyBytes
  Uint8List get bodyBytes => _imgData;

  @override
  bool hasHeader(String name) {
    return false;
  }

  @override
  String header(String name) {
    return null;
  }

  @override
  // TODO: implement statusCode
  get statusCode => _statusCode;

}