// GENERATED CODE - DO NOT MODIFY BY HAND

part of reported_content;

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<ReportedContent> _$reportedContentSerializer =
    new _$ReportedContentSerializer();

class _$ReportedContentSerializer
    implements StructuredSerializer<ReportedContent> {
  @override
  final Iterable<Type> types = const [ReportedContent, _$ReportedContent];
  @override
  final String wireName = 'ReportedContent';

  @override
  Iterable serialize(Serializers serializers, ReportedContent object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'accountId',
      serializers.serialize(object.accountId,
          specifiedType: const FullType(String)),
      'reportReason',
      serializers.serialize(object.reportReason,
          specifiedType: const FullType(String)),
    ];
    if (object.otherReason != null) {
      result
        ..add('otherReason')
        ..add(serializers.serialize(object.otherReason,
            specifiedType: const FullType(String)));
    }

    return result;
  }

  @override
  ReportedContent deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new ReportedContentBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'accountId':
          result.accountId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'reportReason':
          result.reportReason = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'otherReason':
          result.otherReason = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
      }
    }

    return result.build();
  }
}

class _$ReportedContent extends ReportedContent {
  @override
  final String accountId;
  @override
  final String reportReason;
  @override
  final String otherReason;

  factory _$ReportedContent([void Function(ReportedContentBuilder) updates]) =>
      (new ReportedContentBuilder()..update(updates)).build();

  _$ReportedContent._({this.accountId, this.reportReason, this.otherReason})
      : super._() {
    if (accountId == null) {
      throw new BuiltValueNullFieldError('ReportedContent', 'accountId');
    }
    if (reportReason == null) {
      throw new BuiltValueNullFieldError('ReportedContent', 'reportReason');
    }
  }

  @override
  ReportedContent rebuild(void Function(ReportedContentBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ReportedContentBuilder toBuilder() =>
      new ReportedContentBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ReportedContent &&
        accountId == other.accountId &&
        reportReason == other.reportReason &&
        otherReason == other.otherReason;
  }

  @override
  int get hashCode {
    return $jf($jc($jc($jc(0, accountId.hashCode), reportReason.hashCode),
        otherReason.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('ReportedContent')
          ..add('accountId', accountId)
          ..add('reportReason', reportReason)
          ..add('otherReason', otherReason))
        .toString();
  }
}

class ReportedContentBuilder
    implements Builder<ReportedContent, ReportedContentBuilder> {
  _$ReportedContent _$v;

  String _accountId;
  String get accountId => _$this._accountId;
  set accountId(String accountId) => _$this._accountId = accountId;

  String _reportReason;
  String get reportReason => _$this._reportReason;
  set reportReason(String reportReason) => _$this._reportReason = reportReason;

  String _otherReason;
  String get otherReason => _$this._otherReason;
  set otherReason(String otherReason) => _$this._otherReason = otherReason;

  ReportedContentBuilder();

  ReportedContentBuilder get _$this {
    if (_$v != null) {
      _accountId = _$v.accountId;
      _reportReason = _$v.reportReason;
      _otherReason = _$v.otherReason;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ReportedContent other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$ReportedContent;
  }

  @override
  void update(void Function(ReportedContentBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$ReportedContent build() {
    final _$result = _$v ??
        new _$ReportedContent._(
            accountId: accountId,
            reportReason: reportReason,
            otherReason: otherReason);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
