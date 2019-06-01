// GENERATED CODE - DO NOT MODIFY BY HAND

part of comment;

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<Comment> _$commentSerializer = new _$CommentSerializer();

class _$CommentSerializer implements StructuredSerializer<Comment> {
  @override
  final Iterable<Type> types = const [Comment, _$Comment];
  @override
  final String wireName = 'Comment';

  @override
  Iterable serialize(Serializers serializers, Comment object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'commentId',
      serializers.serialize(object.commentId,
          specifiedType: const FullType(String)),
      'account',
      serializers.serialize(object.account,
          specifiedType: const FullType(Account)),
      'message',
      serializers.serialize(object.message,
          specifiedType: const FullType(String)),
    ];
    if (object.imageUrl != null) {
      result
        ..add('imageUrl')
        ..add(serializers.serialize(object.imageUrl,
            specifiedType: const FullType(String)));
    }
    if (object.timestamp != null) {
      result
        ..add('timestamp')
        ..add(serializers.serialize(object.timestamp,
            specifiedType: const FullType(Timestamp)));
    }
    if (object.likes != null) {
      result
        ..add('likes')
        ..add(serializers.serialize(object.likes,
            specifiedType: const FullType(int)));
    }
    if (object.timesFlagged != null) {
      result
        ..add('timesFlagged')
        ..add(serializers.serialize(object.timesFlagged,
            specifiedType: const FullType(int)));
    }
    if (object.acceptable != null) {
      result
        ..add('acceptable')
        ..add(serializers.serialize(object.acceptable,
            specifiedType: const FullType(bool)));
    }
    if (object.handled != null) {
      result
        ..add('handled')
        ..add(serializers.serialize(object.handled,
            specifiedType: const FullType(bool)));
    }
    if (object.reference != null) {
      result
        ..add('reference')
        ..add(serializers.serialize(object.reference,
            specifiedType: const FullType(DocumentReference)));
    }

    return result;
  }

  @override
  Comment deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new CommentBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'commentId':
          result.commentId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'account':
          result.account.replace(serializers.deserialize(value,
              specifiedType: const FullType(Account)) as Account);
          break;
        case 'imageUrl':
          result.imageUrl = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'message':
          result.message = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'timestamp':
          result.timestamp = serializers.deserialize(value,
              specifiedType: const FullType(Timestamp)) as Timestamp;
          break;
        case 'likes':
          result.likes = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'timesFlagged':
          result.timesFlagged = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'acceptable':
          result.acceptable = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'handled':
          result.handled = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'reference':
          result.reference = serializers.deserialize(value,
                  specifiedType: const FullType(DocumentReference))
              as DocumentReference;
          break;
      }
    }

    return result.build();
  }
}

class _$Comment extends Comment {
  @override
  final String commentId;
  @override
  final Account account;
  @override
  final String imageUrl;
  @override
  final String message;
  @override
  final Timestamp timestamp;
  @override
  final int likes;
  @override
  final int timesFlagged;
  @override
  final bool acceptable;
  @override
  final bool handled;
  @override
  final DocumentReference reference;

  factory _$Comment([void Function(CommentBuilder) updates]) =>
      (new CommentBuilder()..update(updates)).build();

  _$Comment._(
      {this.commentId,
      this.account,
      this.imageUrl,
      this.message,
      this.timestamp,
      this.likes,
      this.timesFlagged,
      this.acceptable,
      this.handled,
      this.reference})
      : super._() {
    if (commentId == null) {
      throw new BuiltValueNullFieldError('Comment', 'commentId');
    }
    if (account == null) {
      throw new BuiltValueNullFieldError('Comment', 'account');
    }
    if (message == null) {
      throw new BuiltValueNullFieldError('Comment', 'message');
    }
  }

  @override
  Comment rebuild(void Function(CommentBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  CommentBuilder toBuilder() => new CommentBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Comment &&
        commentId == other.commentId &&
        account == other.account &&
        imageUrl == other.imageUrl &&
        message == other.message &&
        timestamp == other.timestamp &&
        likes == other.likes &&
        timesFlagged == other.timesFlagged &&
        acceptable == other.acceptable &&
        handled == other.handled &&
        reference == other.reference;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc(
                    $jc(
                        $jc(
                            $jc(
                                $jc(
                                    $jc($jc(0, commentId.hashCode),
                                        account.hashCode),
                                    imageUrl.hashCode),
                                message.hashCode),
                            timestamp.hashCode),
                        likes.hashCode),
                    timesFlagged.hashCode),
                acceptable.hashCode),
            handled.hashCode),
        reference.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('Comment')
          ..add('commentId', commentId)
          ..add('account', account)
          ..add('imageUrl', imageUrl)
          ..add('message', message)
          ..add('timestamp', timestamp)
          ..add('likes', likes)
          ..add('timesFlagged', timesFlagged)
          ..add('acceptable', acceptable)
          ..add('handled', handled)
          ..add('reference', reference))
        .toString();
  }
}

class CommentBuilder implements Builder<Comment, CommentBuilder> {
  _$Comment _$v;

  String _commentId;
  String get commentId => _$this._commentId;
  set commentId(String commentId) => _$this._commentId = commentId;

  AccountBuilder _account;
  AccountBuilder get account => _$this._account ??= new AccountBuilder();
  set account(AccountBuilder account) => _$this._account = account;

  String _imageUrl;
  String get imageUrl => _$this._imageUrl;
  set imageUrl(String imageUrl) => _$this._imageUrl = imageUrl;

  String _message;
  String get message => _$this._message;
  set message(String message) => _$this._message = message;

  Timestamp _timestamp;
  Timestamp get timestamp => _$this._timestamp;
  set timestamp(Timestamp timestamp) => _$this._timestamp = timestamp;

  int _likes;
  int get likes => _$this._likes;
  set likes(int likes) => _$this._likes = likes;

  int _timesFlagged;
  int get timesFlagged => _$this._timesFlagged;
  set timesFlagged(int timesFlagged) => _$this._timesFlagged = timesFlagged;

  bool _acceptable;
  bool get acceptable => _$this._acceptable;
  set acceptable(bool acceptable) => _$this._acceptable = acceptable;

  bool _handled;
  bool get handled => _$this._handled;
  set handled(bool handled) => _$this._handled = handled;

  DocumentReference _reference;
  DocumentReference get reference => _$this._reference;
  set reference(DocumentReference reference) => _$this._reference = reference;

  CommentBuilder();

  CommentBuilder get _$this {
    if (_$v != null) {
      _commentId = _$v.commentId;
      _account = _$v.account?.toBuilder();
      _imageUrl = _$v.imageUrl;
      _message = _$v.message;
      _timestamp = _$v.timestamp;
      _likes = _$v.likes;
      _timesFlagged = _$v.timesFlagged;
      _acceptable = _$v.acceptable;
      _handled = _$v.handled;
      _reference = _$v.reference;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Comment other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$Comment;
  }

  @override
  void update(void Function(CommentBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$Comment build() {
    _$Comment _$result;
    try {
      _$result = _$v ??
          new _$Comment._(
              commentId: commentId,
              account: account.build(),
              imageUrl: imageUrl,
              message: message,
              timestamp: timestamp,
              likes: likes,
              timesFlagged: timesFlagged,
              acceptable: acceptable,
              handled: handled,
              reference: reference);
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'account';
        account.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'Comment', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
