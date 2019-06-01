// GENERATED CODE - DO NOT MODIFY BY HAND

part of friendlist;

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<FriendList> _$friendListSerializer = new _$FriendListSerializer();

class _$FriendListSerializer implements StructuredSerializer<FriendList> {
  @override
  final Iterable<Type> types = const [FriendList, _$FriendList];
  @override
  final String wireName = 'FriendList';

  @override
  Iterable serialize(Serializers serializers, FriendList object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'friends',
      serializers.serialize(object.friends,
          specifiedType:
              const FullType(BuiltList, const [const FullType(Account)])),
      'accountId',
      serializers.serialize(object.accountId,
          specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  FriendList deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new FriendListBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'friends':
          result.friends.replace(serializers.deserialize(value,
              specifiedType: const FullType(
                  BuiltList, const [const FullType(Account)])) as BuiltList);
          break;
        case 'accountId':
          result.accountId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
      }
    }

    return result.build();
  }
}

class _$FriendList extends FriendList {
  @override
  final BuiltList<Account> friends;
  @override
  final String accountId;

  factory _$FriendList([void Function(FriendListBuilder) updates]) =>
      (new FriendListBuilder()..update(updates)).build();

  _$FriendList._({this.friends, this.accountId}) : super._() {
    if (friends == null) {
      throw new BuiltValueNullFieldError('FriendList', 'friends');
    }
    if (accountId == null) {
      throw new BuiltValueNullFieldError('FriendList', 'accountId');
    }
  }

  @override
  FriendList rebuild(void Function(FriendListBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  FriendListBuilder toBuilder() => new FriendListBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is FriendList &&
        friends == other.friends &&
        accountId == other.accountId;
  }

  @override
  int get hashCode {
    return $jf($jc($jc(0, friends.hashCode), accountId.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('FriendList')
          ..add('friends', friends)
          ..add('accountId', accountId))
        .toString();
  }
}

class FriendListBuilder implements Builder<FriendList, FriendListBuilder> {
  _$FriendList _$v;

  ListBuilder<Account> _friends;
  ListBuilder<Account> get friends =>
      _$this._friends ??= new ListBuilder<Account>();
  set friends(ListBuilder<Account> friends) => _$this._friends = friends;

  String _accountId;
  String get accountId => _$this._accountId;
  set accountId(String accountId) => _$this._accountId = accountId;

  FriendListBuilder();

  FriendListBuilder get _$this {
    if (_$v != null) {
      _friends = _$v.friends?.toBuilder();
      _accountId = _$v.accountId;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(FriendList other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$FriendList;
  }

  @override
  void update(void Function(FriendListBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$FriendList build() {
    _$FriendList _$result;
    try {
      _$result = _$v ??
          new _$FriendList._(friends: friends.build(), accountId: accountId);
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'friends';
        friends.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'FriendList', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
