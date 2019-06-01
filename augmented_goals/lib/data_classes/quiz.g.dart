// GENERATED CODE - DO NOT MODIFY BY HAND

part of quiz;

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<Quiz> _$quizSerializer = new _$QuizSerializer();

class _$QuizSerializer implements StructuredSerializer<Quiz> {
  @override
  final Iterable<Type> types = const [Quiz, _$Quiz];
  @override
  final String wireName = 'Quiz';

  @override
  Iterable serialize(Serializers serializers, Quiz object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'quizId',
      serializers.serialize(object.quizId,
          specifiedType: const FullType(String)),
      'title',
      serializers.serialize(object.title,
          specifiedType: const FullType(String)),
      'description',
      serializers.serialize(object.description,
          specifiedType: const FullType(String)),
      'tag',
      serializers.serialize(object.tag, specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  Quiz deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new QuizBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'quizId':
          result.quizId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'title':
          result.title = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'description':
          result.description = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'tag':
          result.tag = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
      }
    }

    return result.build();
  }
}

class _$Quiz extends Quiz {
  @override
  final String quizId;
  @override
  final String title;
  @override
  final String description;
  @override
  final String tag;

  factory _$Quiz([void Function(QuizBuilder) updates]) =>
      (new QuizBuilder()..update(updates)).build();

  _$Quiz._({this.quizId, this.title, this.description, this.tag}) : super._() {
    if (quizId == null) {
      throw new BuiltValueNullFieldError('Quiz', 'quizId');
    }
    if (title == null) {
      throw new BuiltValueNullFieldError('Quiz', 'title');
    }
    if (description == null) {
      throw new BuiltValueNullFieldError('Quiz', 'description');
    }
    if (tag == null) {
      throw new BuiltValueNullFieldError('Quiz', 'tag');
    }
  }

  @override
  Quiz rebuild(void Function(QuizBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  QuizBuilder toBuilder() => new QuizBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Quiz &&
        quizId == other.quizId &&
        title == other.title &&
        description == other.description &&
        tag == other.tag;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc($jc($jc(0, quizId.hashCode), title.hashCode), description.hashCode),
        tag.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('Quiz')
          ..add('quizId', quizId)
          ..add('title', title)
          ..add('description', description)
          ..add('tag', tag))
        .toString();
  }
}

class QuizBuilder implements Builder<Quiz, QuizBuilder> {
  _$Quiz _$v;

  String _quizId;
  String get quizId => _$this._quizId;
  set quizId(String quizId) => _$this._quizId = quizId;

  String _title;
  String get title => _$this._title;
  set title(String title) => _$this._title = title;

  String _description;
  String get description => _$this._description;
  set description(String description) => _$this._description = description;

  String _tag;
  String get tag => _$this._tag;
  set tag(String tag) => _$this._tag = tag;

  QuizBuilder();

  QuizBuilder get _$this {
    if (_$v != null) {
      _quizId = _$v.quizId;
      _title = _$v.title;
      _description = _$v.description;
      _tag = _$v.tag;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Quiz other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$Quiz;
  }

  @override
  void update(void Function(QuizBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$Quiz build() {
    final _$result = _$v ??
        new _$Quiz._(
            quizId: quizId, title: title, description: description, tag: tag);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
