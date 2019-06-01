// GENERATED CODE - DO NOT MODIFY BY HAND

part of friend_request;

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<FriendRequest> _$friendRequestSerializer =
    new _$FriendRequestSerializer();

class _$FriendRequestSerializer implements StructuredSerializer<FriendRequest> {
  @override
  final Iterable<Type> types = const [FriendRequest, _$FriendRequest];
  @override
  final String wireName = 'FriendRequest';

  @override
  Iterable serialize(Serializers serializers, FriendRequest object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'sender',
      serializers.serialize(object.sender,
          specifiedType: const FullType(Account)),
      'recipient',
      serializers.serialize(object.recipient,
          specifiedType: const FullType(Account)),
      'timestamp',
      serializers.serialize(object.timestamp,
          specifiedType: const FullType(Timestamp)),
    ];
    if (object.accepted != null) {
      result
        ..add('accepted')
        ..add(serializers.serialize(object.accepted,
            specifiedType: const FullType(bool)));
    }

    return result;
  }

  @override
  FriendRequest deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new FriendRequestBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'sender':
          result.sender.replace(serializers.deserialize(value,
              specifiedType: const FullType(Account)) as Account);
          break;
        case 'recipient':
          result.recipient.replace(serializers.deserialize(value,
              specifiedType: const FullType(Account)) as Account);
          break;
        case 'accepted':
          result.accepted = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'timestamp':
          result.timestamp = serializers.deserialize(value,
              specifiedType: const FullType(Timestamp)) as Timestamp;
          break;
      }
    }

    return result.build();
  }
}

class _$FriendRequest extends FriendRequest {
  @override
  final Account sender;
  @override
  final Account recipient;
  @override
  final bool accepted;
  @override
  final Timestamp timestamp;

  factory _$FriendRequest([void Function(FriendRequestBuilder) updates]) =>
      (new FriendRequestBuilder()..update(updates)).build();

  _$FriendRequest._(
      {this.sender, this.recipient, this.accepted, this.timestamp})
      : super._() {
    if (sender == null) {
      throw new BuiltValueNullFieldError('FriendRequest', 'sender');
    }
    if (recipient == null) {
      throw new BuiltValueNullFieldError('FriendRequest', 'recipient');
    }
    if (timestamp == null) {
      throw new BuiltValueNullFieldError('FriendRequest', 'timestamp');
    }
  }

  @override
  FriendRequest rebuild(void Function(FriendRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  FriendRequestBuilder toBuilder() => new FriendRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is FriendRequest &&
        sender == other.sender &&
        recipient == other.recipient &&
        accepted == other.accepted &&
        timestamp == other.timestamp;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc($jc($jc(0, sender.hashCode), recipient.hashCode),
            accepted.hashCode),
        timestamp.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('FriendRequest')
          ..add('sender', sender)
          ..add('recipient', recipient)
          ..add('accepted', accepted)
          ..add('timestamp', timestamp))
        .toString();
  }
}

class FriendRequestBuilder
    implements Builder<FriendRequest, FriendRequestBuilder> {
  _$FriendRequest _$v;

  AccountBuilder _sender;
  AccountBuilder get sender => _$this._sender ??= new AccountBuilder();
  set sender(AccountBuilder sender) => _$this._sender = sender;

  AccountBuilder _recipient;
  AccountBuilder get recipient => _$this._recipient ??= new AccountBuilder();
  set recipient(AccountBuilder recipient) => _$this._recipient = recipient;

  bool _accepted;
  bool get accepted => _$this._accepted;
  set accepted(bool accepted) => _$this._accepted = accepted;

  Timestamp _timestamp;
  Timestamp get timestamp => _$this._timestamp;
  set timestamp(Timestamp timestamp) => _$this._timestamp = timestamp;

  FriendRequestBuilder();

  FriendRequestBuilder get _$this {
    if (_$v != null) {
      _sender = _$v.sender?.toBuilder();
      _recipient = _$v.recipient?.toBuilder();
      _accepted = _$v.accepted;
      _timestamp = _$v.timestamp;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(FriendRequest other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$FriendRequest;
  }

  @override
  void update(void Function(FriendRequestBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$FriendRequest build() {
    _$FriendRequest _$result;
    try {
      _$result = _$v ??
          new _$FriendRequest._(
              sender: sender.build(),
              recipient: recipient.build(),
              accepted: accepted,
              timestamp: timestamp);
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'sender';
        sender.build();
        _$failedField = 'recipient';
        recipient.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'FriendRequest', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
