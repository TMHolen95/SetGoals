// GENERATED CODE - DO NOT MODIFY BY HAND

part of undertaking;

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<Challenge> _$challengeSerializer = new _$ChallengeSerializer();

class _$ChallengeSerializer implements StructuredSerializer<Challenge> {
  @override
  final Iterable<Type> types = const [Challenge, _$Challenge];
  @override
  final String wireName = 'Challenge';

  @override
  Iterable serialize(Serializers serializers, Challenge object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'creatorId',
      serializers.serialize(object.creatorId,
          specifiedType: const FullType(String)),
      'challengeId',
      serializers.serialize(object.challengeId,
          specifiedType: const FullType(String)),
      'title',
      serializers.serialize(object.title,
          specifiedType: const FullType(String)),
      'description',
      serializers.serialize(object.description,
          specifiedType: const FullType(String)),
      'category',
      serializers.serialize(object.category,
          specifiedType: const FullType(GoalCategory)),
      'position',
      serializers.serialize(object.position,
          specifiedType: const FullType(GeoPoint)),
    ];
    if (object.timesTaken != null) {
      result
        ..add('timesTaken')
        ..add(serializers.serialize(object.timesTaken,
            specifiedType: const FullType(int)));
    }
    if (object.timesCompleted != null) {
      result
        ..add('timesCompleted')
        ..add(serializers.serialize(object.timesCompleted,
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
    if (object.headerUrl != null) {
      result
        ..add('headerUrl')
        ..add(serializers.serialize(object.headerUrl,
            specifiedType: const FullType(String)));
    }

    return result;
  }

  @override
  Challenge deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new ChallengeBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'creatorId':
          result.creatorId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'challengeId':
          result.challengeId = serializers.deserialize(value,
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
        case 'category':
          result.category = serializers.deserialize(value,
              specifiedType: const FullType(GoalCategory)) as GoalCategory;
          break;
        case 'position':
          result.position = serializers.deserialize(value,
              specifiedType: const FullType(GeoPoint)) as GeoPoint;
          break;
        case 'timesTaken':
          result.timesTaken = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'timesCompleted':
          result.timesCompleted = serializers.deserialize(value,
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
        case 'headerUrl':
          result.headerUrl = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
      }
    }

    return result.build();
  }
}

class _$Challenge extends Challenge {
  @override
  final String creatorId;
  @override
  final String challengeId;
  @override
  final String title;
  @override
  final String description;
  @override
  final GoalCategory category;
  @override
  final GeoPoint position;
  @override
  final int timesTaken;
  @override
  final int timesCompleted;
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
  @override
  final String headerUrl;

  factory _$Challenge([void Function(ChallengeBuilder) updates]) =>
      (new ChallengeBuilder()..update(updates)).build();

  _$Challenge._(
      {this.creatorId,
      this.challengeId,
      this.title,
      this.description,
      this.category,
      this.position,
      this.timesTaken,
      this.timesCompleted,
      this.likes,
      this.timesFlagged,
      this.acceptable,
      this.handled,
      this.reference,
      this.headerUrl})
      : super._() {
    if (creatorId == null) {
      throw new BuiltValueNullFieldError('Challenge', 'creatorId');
    }
    if (challengeId == null) {
      throw new BuiltValueNullFieldError('Challenge', 'challengeId');
    }
    if (title == null) {
      throw new BuiltValueNullFieldError('Challenge', 'title');
    }
    if (description == null) {
      throw new BuiltValueNullFieldError('Challenge', 'description');
    }
    if (category == null) {
      throw new BuiltValueNullFieldError('Challenge', 'category');
    }
    if (position == null) {
      throw new BuiltValueNullFieldError('Challenge', 'position');
    }
  }

  @override
  Challenge rebuild(void Function(ChallengeBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ChallengeBuilder toBuilder() => new ChallengeBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Challenge &&
        creatorId == other.creatorId &&
        challengeId == other.challengeId &&
        title == other.title &&
        description == other.description &&
        category == other.category &&
        position == other.position &&
        timesTaken == other.timesTaken &&
        timesCompleted == other.timesCompleted &&
        likes == other.likes &&
        timesFlagged == other.timesFlagged &&
        acceptable == other.acceptable &&
        handled == other.handled &&
        reference == other.reference &&
        headerUrl == other.headerUrl;
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
                                                        $jc(0,
                                                            creatorId.hashCode),
                                                        challengeId.hashCode),
                                                    title.hashCode),
                                                description.hashCode),
                                            category.hashCode),
                                        position.hashCode),
                                    timesTaken.hashCode),
                                timesCompleted.hashCode),
                            likes.hashCode),
                        timesFlagged.hashCode),
                    acceptable.hashCode),
                handled.hashCode),
            reference.hashCode),
        headerUrl.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('Challenge')
          ..add('creatorId', creatorId)
          ..add('challengeId', challengeId)
          ..add('title', title)
          ..add('description', description)
          ..add('category', category)
          ..add('position', position)
          ..add('timesTaken', timesTaken)
          ..add('timesCompleted', timesCompleted)
          ..add('likes', likes)
          ..add('timesFlagged', timesFlagged)
          ..add('acceptable', acceptable)
          ..add('handled', handled)
          ..add('reference', reference)
          ..add('headerUrl', headerUrl))
        .toString();
  }
}

class ChallengeBuilder implements Builder<Challenge, ChallengeBuilder> {
  _$Challenge _$v;

  String _creatorId;
  String get creatorId => _$this._creatorId;
  set creatorId(String creatorId) => _$this._creatorId = creatorId;

  String _challengeId;
  String get challengeId => _$this._challengeId;
  set challengeId(String challengeId) => _$this._challengeId = challengeId;

  String _title;
  String get title => _$this._title;
  set title(String title) => _$this._title = title;

  String _description;
  String get description => _$this._description;
  set description(String description) => _$this._description = description;

  GoalCategory _category;
  GoalCategory get category => _$this._category;
  set category(GoalCategory category) => _$this._category = category;

  GeoPoint _position;
  GeoPoint get position => _$this._position;
  set position(GeoPoint position) => _$this._position = position;

  int _timesTaken;
  int get timesTaken => _$this._timesTaken;
  set timesTaken(int timesTaken) => _$this._timesTaken = timesTaken;

  int _timesCompleted;
  int get timesCompleted => _$this._timesCompleted;
  set timesCompleted(int timesCompleted) =>
      _$this._timesCompleted = timesCompleted;

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

  String _headerUrl;
  String get headerUrl => _$this._headerUrl;
  set headerUrl(String headerUrl) => _$this._headerUrl = headerUrl;

  ChallengeBuilder();

  ChallengeBuilder get _$this {
    if (_$v != null) {
      _creatorId = _$v.creatorId;
      _challengeId = _$v.challengeId;
      _title = _$v.title;
      _description = _$v.description;
      _category = _$v.category;
      _position = _$v.position;
      _timesTaken = _$v.timesTaken;
      _timesCompleted = _$v.timesCompleted;
      _likes = _$v.likes;
      _timesFlagged = _$v.timesFlagged;
      _acceptable = _$v.acceptable;
      _handled = _$v.handled;
      _reference = _$v.reference;
      _headerUrl = _$v.headerUrl;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Challenge other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$Challenge;
  }

  @override
  void update(void Function(ChallengeBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$Challenge build() {
    final _$result = _$v ??
        new _$Challenge._(
            creatorId: creatorId,
            challengeId: challengeId,
            title: title,
            description: description,
            category: category,
            position: position,
            timesTaken: timesTaken,
            timesCompleted: timesCompleted,
            likes: likes,
            timesFlagged: timesFlagged,
            acceptable: acceptable,
            handled: handled,
            reference: reference,
            headerUrl: headerUrl);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
