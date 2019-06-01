library question;

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'question.g.dart';

/// TODO Remember to add this to serializers.dart
abstract class Question implements Built<Question, QuestionBuilder> {
  static Serializer<Question> get serializer => _$questionSerializer;

  String get quizId;
  String get questionId;
  int get likertPoints;
  String get question;
  @nullable
  String get category;
  @nullable
  bool get scoringReversed;
  @nullable
  bool get numbersVisible;

  bool get isFreeText;
  bool get isLikert;

  @nullable
  BuiltList<String> get labels;

  // For images
  @nullable
  String get fileName;


  Question._();

  factory Question([updates(QuestionBuilder b)]) = _$Question;
}