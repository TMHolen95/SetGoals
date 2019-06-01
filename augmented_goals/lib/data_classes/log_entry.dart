library log_entry;

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

part 'log_entry.g.dart';

abstract class LogEntry implements Built<LogEntry, LogEntryBuilder> {
  static Serializer<LogEntry> get serializer => _$logEntrySerializer;

  String get entryId;
  Timestamp get timestamp;

  @nullable
  bool get dailyCheckIn;

  @nullable
  Duration get duration;

  @nullable
  double get measurement;
  @nullable
  String get measurementUnit;

  @nullable
  int get performance;

  @nullable
  String get reflectiveNotes;

  LogEntry._();

  factory LogEntry([updates(LogEntryBuilder b)]) = _$LogEntry;
}