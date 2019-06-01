library reported_content;

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'reported_content.g.dart';

abstract class ReportedContent
    implements Built<ReportedContent, ReportedContentBuilder> {
  static Serializer<ReportedContent> get serializer =>
      _$reportedContentSerializer;

  String get accountId; // The reporter
  String get reportReason;

  @nullable
  String get otherReason;

  ReportedContent._();

  static build(String accountId, String reportReason, String otherReason) {
    return ReportedContent((builder) => builder
      ..accountId = accountId
      ..reportReason = reportReason
    ..otherReason = otherReason);
  }

  factory ReportedContent([updates(ReportedContentBuilder b)]) =
      _$ReportedContent;
}
