library like;

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'like.g.dart';

abstract class Like implements Built<Like, LikeBuilder> {
  static Serializer<Like> get serializer => _$likeSerializer;

  String get accountId;
  String get accountPictureUrl;
  String get accountName;

  Like._();

  factory Like([updates(LikeBuilder b)]) = _$Like;
}
