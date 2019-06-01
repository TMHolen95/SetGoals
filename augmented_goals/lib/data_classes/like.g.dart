// GENERATED CODE - DO NOT MODIFY BY HAND

part of like;

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<Like> _$likeSerializer = new _$LikeSerializer();

class _$LikeSerializer implements StructuredSerializer<Like> {
  @override
  final Iterable<Type> types = const [Like, _$Like];
  @override
  final String wireName = 'Like';

  @override
  Iterable serialize(Serializers serializers, Like object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'accountId',
      serializers.serialize(object.accountId,
          specifiedType: const FullType(String)),
      'accountPictureUrl',
      serializers.serialize(object.accountPictureUrl,
          specifiedType: const FullType(String)),
      'accountName',
      serializers.serialize(object.accountName,
          specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  Like deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new LikeBuilder();

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
        case 'accountPictureUrl':
          result.accountPictureUrl = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'accountName':
          result.accountName = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
      }
    }

    return result.build();
  }
}

class _$Like extends Like {
  @override
  final String accountId;
  @override
  final String accountPictureUrl;
  @override
  final String accountName;

  factory _$Like([void Function(LikeBuilder) updates]) =>
      (new LikeBuilder()..update(updates)).build();

  _$Like._({this.accountId, this.accountPictureUrl, this.accountName})
      : super._() {
    if (accountId == null) {
      throw new BuiltValueNullFieldError('Like', 'accountId');
    }
    if (accountPictureUrl == null) {
      throw new BuiltValueNullFieldError('Like', 'accountPictureUrl');
    }
    if (accountName == null) {
      throw new BuiltValueNullFieldError('Like', 'accountName');
    }
  }

  @override
  Like rebuild(void Function(LikeBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  LikeBuilder toBuilder() => new LikeBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Like &&
        accountId == other.accountId &&
        accountPictureUrl == other.accountPictureUrl &&
        accountName == other.accountName;
  }

  @override
  int get hashCode {
    return $jf($jc($jc($jc(0, accountId.hashCode), accountPictureUrl.hashCode),
        accountName.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('Like')
          ..add('accountId', accountId)
          ..add('accountPictureUrl', accountPictureUrl)
          ..add('accountName', accountName))
        .toString();
  }
}

class LikeBuilder implements Builder<Like, LikeBuilder> {
  _$Like _$v;

  String _accountId;
  String get accountId => _$this._accountId;
  set accountId(String accountId) => _$this._accountId = accountId;

  String _accountPictureUrl;
  String get accountPictureUrl => _$this._accountPictureUrl;
  set accountPictureUrl(String accountPictureUrl) =>
      _$this._accountPictureUrl = accountPictureUrl;

  String _accountName;
  String get accountName => _$this._accountName;
  set accountName(String accountName) => _$this._accountName = accountName;

  LikeBuilder();

  LikeBuilder get _$this {
    if (_$v != null) {
      _accountId = _$v.accountId;
      _accountPictureUrl = _$v.accountPictureUrl;
      _accountName = _$v.accountName;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Like other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$Like;
  }

  @override
  void update(void Function(LikeBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$Like build() {
    final _$result = _$v ??
        new _$Like._(
            accountId: accountId,
            accountPictureUrl: accountPictureUrl,
            accountName: accountName);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
