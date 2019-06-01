library quiz;

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'quiz.g.dart';

/// TODO Remember to add this to serializers.dart
abstract class Quiz implements Built<Quiz, QuizBuilder> {
  static Serializer<Quiz> get serializer => _$quizSerializer;

  String get quizId;
  String get title;
  String get description;
  String get tag;

  Quiz._();

  factory Quiz([updates(QuizBuilder b)]) = _$Quiz;
}