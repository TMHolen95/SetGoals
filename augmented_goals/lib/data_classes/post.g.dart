// GENERATED CODE - DO NOT MODIFY BY HAND

part of post;

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<Post> _$postSerializer = new _$PostSerializer();

class _$PostSerializer implements StructuredSerializer<Post> {
  @override
  final Iterable<Type> types = const [Post, _$Post];
  @override
  final String wireName = 'Post';

  @override
  Iterable serialize(Serializers serializers, Post object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'postId',
      serializers.serialize(object.postId,
          specifiedType: const FullType(String)),
      'goal',
      serializers.serialize(object.goal, specifiedType: const FullType(Goal)),
      'title',
      serializers.serialize(object.title,
          specifiedType: const FullType(String)),
      'message',
      serializers.serialize(object.message,
          specifiedType: const FullType(String)),
      'timestamp',
      serializers.serialize(object.timestamp,
          specifiedType: const FullType(Timestamp)),
    ];
    if (object.fileName != null) {
      result
        ..add('fileName')
        ..add(serializers.serialize(object.fileName,
            specifiedType: const FullType(String)));
    }
    if (object.width != null) {
      result
        ..add('width')
        ..add(serializers.serialize(object.width,
            specifiedType: const FullType(int)));
    }
    if (object.height != null) {
      result
        ..add('height')
        ..add(serializers.serialize(object.height,
            specifiedType: const FullType(int)));
    }
    if (object.uids != null) {
      result
        ..add('uids')
        ..add(serializers.serialize(object.uids,
            specifiedType:
                const FullType(BuiltList, const [const FullType(String)])));
    }
    if (object.commentCount != null) {
      result
        ..add('commentCount')
        ..add(serializers.serialize(object.commentCount,
            specifiedType: const FullType(int)));
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
  Post deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new PostBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'postId':
          result.postId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'goal':
          result.goal.replace(serializers.deserialize(value,
              specifiedType: const FullType(Goal)) as Goal);
          break;
        case 'fileName':
          result.fileName = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'width':
          result.width = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'height':
          result.height = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'uids':
          result.uids.replace(serializers.deserialize(value,
                  specifiedType:
                      const FullType(BuiltList, const [const FullType(String)]))
              as BuiltList);
          break;
        case 'title':
          result.title = serializers.deserialize(value,
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
        case 'commentCount':
          result.commentCount = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
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

class _$Post extends Post {
  @override
  final String postId;
  @override
  final Goal goal;
  @override
  final String fileName;
  @override
  final int width;
  @override
  final int height;
  @override
  final BuiltList<String> uids;
  @override
  final String title;
  @override
  final String message;
  @override
  final Timestamp timestamp;
  @override
  final int commentCount;
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

  factory _$Post([void Function(PostBuilder) updates]) =>
      (new PostBuilder()..update(updates)).build();

  _$Post._(
      {this.postId,
      this.goal,
      this.fileName,
      this.width,
      this.height,
      this.uids,
      this.title,
      this.message,
      this.timestamp,
      this.commentCount,
      this.likes,
      this.timesFlagged,
      this.acceptable,
      this.handled,
      this.reference})
      : super._() {
    if (postId == null) {
      throw new BuiltValueNullFieldError('Post', 'postId');
    }
    if (goal == null) {
      throw new BuiltValueNullFieldError('Post', 'goal');
    }
    if (title == null) {
      throw new BuiltValueNullFieldError('Post', 'title');
    }
    if (message == null) {
      throw new BuiltValueNullFieldError('Post', 'message');
    }
    if (timestamp == null) {
      throw new BuiltValueNullFieldError('Post', 'timestamp');
    }
  }

  @override
  Post rebuild(void Function(PostBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  PostBuilder toBuilder() => new PostBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Post &&
        postId == other.postId &&
        goal == other.goal &&
        fileName == other.fileName &&
        width == other.width &&
        height == other.height &&
        uids == other.uids &&
        title == other.title &&
        message == other.message &&
        timestamp == other.timestamp &&
        commentCount == other.commentCount &&
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
                                    $jc(
                                        $jc(
                                            $jc(
                                                $jc(
                                                    $jc(
                                                        $jc(
                                                            $jc(
                                                                0,
                                                                postId
                                                                    .hashCode),
                                                            goal.hashCode),
                                                        fileName.hashCode),
                                                    width.hashCode),
                                                height.hashCode),
                                            uids.hashCode),
                                        title.hashCode),
                                    message.hashCode),
                                timestamp.hashCode),
                            commentCount.hashCode),
                        likes.hashCode),
                    timesFlagged.hashCode),
                acceptable.hashCode),
            handled.hashCode),
        reference.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('Post')
          ..add('postId', postId)
          ..add('goal', goal)
          ..add('fileName', fileName)
          ..add('width', width)
          ..add('height', height)
          ..add('uids', uids)
          ..add('title', title)
          ..add('message', message)
          ..add('timestamp', timestamp)
          ..add('commentCount', commentCount)
          ..add('likes', likes)
          ..add('timesFlagged', timesFlagged)
          ..add('acceptable', acceptable)
          ..add('handled', handled)
          ..add('reference', reference))
        .toString();
  }
}

class PostBuilder implements Builder<Post, PostBuilder> {
  _$Post _$v;

  String _postId;
  String get postId => _$this._postId;
  set postId(String postId) => _$this._postId = postId;

  GoalBuilder _goal;
  GoalBuilder get goal => _$this._goal ??= new GoalBuilder();
  set goal(GoalBuilder goal) => _$this._goal = goal;

  String _fileName;
  String get fileName => _$this._fileName;
  set fileName(String fileName) => _$this._fileName = fileName;

  int _width;
  int get width => _$this._width;
  set width(int width) => _$this._width = width;

  int _height;
  int get height => _$this._height;
  set height(int height) => _$this._height = height;

  ListBuilder<String> _uids;
  ListBuilder<String> get uids => _$this._uids ??= new ListBuilder<String>();
  set uids(ListBuilder<String> uids) => _$this._uids = uids;

  String _title;
  String get title => _$this._title;
  set title(String title) => _$this._title = title;

  String _message;
  String get message => _$this._message;
  set message(String message) => _$this._message = message;

  Timestamp _timestamp;
  Timestamp get timestamp => _$this._timestamp;
  set timestamp(Timestamp timestamp) => _$this._timestamp = timestamp;

  int _commentCount;
  int get commentCount => _$this._commentCount;
  set commentCount(int commentCount) => _$this._commentCount = commentCount;

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

  PostBuilder();

  PostBuilder get _$this {
    if (_$v != null) {
      _postId = _$v.postId;
      _goal = _$v.goal?.toBuilder();
      _fileName = _$v.fileName;
      _width = _$v.width;
      _height = _$v.height;
      _uids = _$v.uids?.toBuilder();
      _title = _$v.title;
      _message = _$v.message;
      _timestamp = _$v.timestamp;
      _commentCount = _$v.commentCount;
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
  void replace(Post other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$Post;
  }

  @override
  void update(void Function(PostBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$Post build() {
    _$Post _$result;
    try {
      _$result = _$v ??
          new _$Post._(
              postId: postId,
              goal: goal.build(),
              fileName: fileName,
              width: width,
              height: height,
              uids: _uids?.build(),
              title: title,
              message: message,
              timestamp: timestamp,
              commentCount: commentCount,
              likes: likes,
              timesFlagged: timesFlagged,
              acceptable: acceptable,
              handled: handled,
              reference: reference);
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'goal';
        goal.build();

        _$failedField = 'uids';
        _uids?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'Post', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
