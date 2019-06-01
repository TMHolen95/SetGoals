// GENERATED CODE - DO NOT MODIFY BY HAND

part of question;

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<Question> _$questionSerializer = new _$QuestionSerializer();

class _$QuestionSerializer implements StructuredSerializer<Question> {
  @override
  final Iterable<Type> types = const [Question, _$Question];
  @override
  final String wireName = 'Question';

  @override
  Iterable serialize(Serializers serializers, Question object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'quizId',
      serializers.serialize(object.quizId,
          specifiedType: const FullType(String)),
      'questionId',
      serializers.serialize(object.questionId,
          specifiedType: const FullType(String)),
      'likertPoints',
      serializers.serialize(object.likertPoints,
          specifiedType: const FullType(int)),
      'question',
      serializers.serialize(object.question,
          specifiedType: const FullType(String)),
      'isFreeText',
      serializers.serialize(object.isFreeText,
          specifiedType: const FullType(bool)),
      'isLikert',
      serializers.serialize(object.isLikert,
          specifiedType: const FullType(bool)),
    ];
    if (object.category != null) {
      result
        ..add('category')
        ..add(serializers.serialize(object.category,
            specifiedType: const FullType(String)));
    }
    if (object.scoringReversed != null) {
      result
        ..add('scoringReversed')
        ..add(serializers.serialize(object.scoringReversed,
            specifiedType: const FullType(bool)));
    }
    if (object.numbersVisible != null) {
      result
        ..add('numbersVisible')
        ..add(serializers.serialize(object.numbersVisible,
            specifiedType: const FullType(bool)));
    }
    if (object.labels != null) {
      result
        ..add('labels')
        ..add(serializers.serialize(object.labels,
            specifiedType:
                const FullType(BuiltList, const [const FullType(String)])));
    }
    if (object.fileName != null) {
      result
        ..add('fileName')
        ..add(serializers.serialize(object.fileName,
            specifiedType: const FullType(String)));
    }

    return result;
  }

  @override
  Question deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new QuestionBuilder();

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
        case 'questionId':
          result.questionId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'likertPoints':
          result.likertPoints = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'question':
          result.question = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'category':
          result.category = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'scoringReversed':
          result.scoringReversed = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'numbersVisible':
          result.numbersVisible = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'isFreeText':
          result.isFreeText = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'isLikert':
          result.isLikert = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'labels':
          result.labels.replace(serializers.deserialize(value,
                  specifiedType:
                      const FullType(BuiltList, const [const FullType(String)]))
              as BuiltList);
          break;
        case 'fileName':
          result.fileName = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
      }
    }

    return result.build();
  }
}

class _$Question extends Question {
  @override
  final String quizId;
  @override
  final String questionId;
  @override
  final int likertPoints;
  @override
  final String question;
  @override
  final String category;
  @override
  final bool scoringReversed;
  @override
  final bool numbersVisible;
  @override
  final bool isFreeText;
  @override
  final bool isLikert;
  @override
  final BuiltList<String> labels;
  @override
  final String fileName;

  factory _$Question([void Function(QuestionBuilder) updates]) =>
      (new QuestionBuilder()..update(updates)).build();

  _$Question._(
      {this.quizId,
      this.questionId,
      this.likertPoints,
      this.question,
      this.category,
      this.scoringReversed,
      this.numbersVisible,
      this.isFreeText,
      this.isLikert,
      this.labels,
      this.fileName})
      : super._() {
    if (quizId == null) {
      throw new BuiltValueNullFieldError('Question', 'quizId');
    }
    if (questionId == null) {
      throw new BuiltValueNullFieldError('Question', 'questionId');
    }
    if (likertPoints == null) {
      throw new BuiltValueNullFieldError('Question', 'likertPoints');
    }
    if (question == null) {
      throw new BuiltValueNullFieldError('Question', 'question');
    }
    if (isFreeText == null) {
      throw new BuiltValueNullFieldError('Question', 'isFreeText');
    }
    if (isLikert == null) {
      throw new BuiltValueNullFieldError('Question', 'isLikert');
    }
  }

  @override
  Question rebuild(void Function(QuestionBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  QuestionBuilder toBuilder() => new QuestionBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Question &&
        quizId == other.quizId &&
        questionId == other.questionId &&
        likertPoints == other.likertPoints &&
        question == other.question &&
        category == other.category &&
        scoringReversed == other.scoringReversed &&
        numbersVisible == other.numbersVisible &&
        isFreeText == other.isFreeText &&
        isLikert == other.isLikert &&
        labels == other.labels &&
        fileName == other.fileName;
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
                                        $jc($jc(0, quizId.hashCode),
                                            questionId.hashCode),
                                        likertPoints.hashCode),
                                    question.hashCode),
                                category.hashCode),
                            scoringReversed.hashCode),
                        numbersVisible.hashCode),
                    isFreeText.hashCode),
                isLikert.hashCode),
            labels.hashCode),
        fileName.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('Question')
          ..add('quizId', quizId)
          ..add('questionId', questionId)
          ..add('likertPoints', likertPoints)
          ..add('question', question)
          ..add('category', category)
          ..add('scoringReversed', scoringReversed)
          ..add('numbersVisible', numbersVisible)
          ..add('isFreeText', isFreeText)
          ..add('isLikert', isLikert)
          ..add('labels', labels)
          ..add('fileName', fileName))
        .toString();
  }
}

class QuestionBuilder implements Builder<Question, QuestionBuilder> {
  _$Question _$v;

  String _quizId;
  String get quizId => _$this._quizId;
  set quizId(String quizId) => _$this._quizId = quizId;

  String _questionId;
  String get questionId => _$this._questionId;
  set questionId(String questionId) => _$this._questionId = questionId;

  int _likertPoints;
  int get likertPoints => _$this._likertPoints;
  set likertPoints(int likertPoints) => _$this._likertPoints = likertPoints;

  String _question;
  String get question => _$this._question;
  set question(String question) => _$this._question = question;

  String _category;
  String get category => _$this._category;
  set category(String category) => _$this._category = category;

  bool _scoringReversed;
  bool get scoringReversed => _$this._scoringReversed;
  set scoringReversed(bool scoringReversed) =>
      _$this._scoringReversed = scoringReversed;

  bool _numbersVisible;
  bool get numbersVisible => _$this._numbersVisible;
  set numbersVisible(bool numbersVisible) =>
      _$this._numbersVisible = numbersVisible;

  bool _isFreeText;
  bool get isFreeText => _$this._isFreeText;
  set isFreeText(bool isFreeText) => _$this._isFreeText = isFreeText;

  bool _isLikert;
  bool get isLikert => _$this._isLikert;
  set isLikert(bool isLikert) => _$this._isLikert = isLikert;

  ListBuilder<String> _labels;
  ListBuilder<String> get labels =>
      _$this._labels ??= new ListBuilder<String>();
  set labels(ListBuilder<String> labels) => _$this._labels = labels;

  String _fileName;
  String get fileName => _$this._fileName;
  set fileName(String fileName) => _$this._fileName = fileName;

  QuestionBuilder();

  QuestionBuilder get _$this {
    if (_$v != null) {
      _quizId = _$v.quizId;
      _questionId = _$v.questionId;
      _likertPoints = _$v.likertPoints;
      _question = _$v.question;
      _category = _$v.category;
      _scoringReversed = _$v.scoringReversed;
      _numbersVisible = _$v.numbersVisible;
      _isFreeText = _$v.isFreeText;
      _isLikert = _$v.isLikert;
      _labels = _$v.labels?.toBuilder();
      _fileName = _$v.fileName;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Question other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$Question;
  }

  @override
  void update(void Function(QuestionBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$Question build() {
    _$Question _$result;
    try {
      _$result = _$v ??
          new _$Question._(
              quizId: quizId,
              questionId: questionId,
              likertPoints: likertPoints,
              question: question,
              category: category,
              scoringReversed: scoringReversed,
              numbersVisible: numbersVisible,
              isFreeText: isFreeText,
              isLikert: isLikert,
              labels: _labels?.build(),
              fileName: fileName);
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'labels';
        _labels?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'Question', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
