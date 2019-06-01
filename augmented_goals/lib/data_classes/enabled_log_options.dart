library enabled_log_option;

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'enabled_log_options.g.dart';


abstract class EnabledLogOptions implements Built<EnabledLogOptions, EnabledLogOptionsBuilder> {
  static Serializer<EnabledLogOptions> get serializer => _$enabledLogOptionsSerializer;

  bool get dailyCheckIn;
  bool get duration;

  bool get measurement;
  @nullable
  String get measurementUnit;

  bool get performance;
  bool get reflectiveNotes;

  EnabledLogOptions._();

  factory EnabledLogOptions([updates(EnabledLogOptionsBuilder b)]) = _$EnabledLogOptions;
}