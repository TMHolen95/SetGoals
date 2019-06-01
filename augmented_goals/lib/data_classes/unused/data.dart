/*
library data;

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'data.g.dart';

/// The data object used in the message
abstract class Data implements Built<Data, DataBuilder> {
  static Serializer<Data> get serializer => _$dataSerializer;

  //Naming convention discrepancy with FCM
  String get click_action;
  String get type;

  @nullable
  String get accountId;
  @nullable
  String get documentId;

  Data._();

  factory Data([updates(DataBuilder b)]) = _$Data;
}*/
