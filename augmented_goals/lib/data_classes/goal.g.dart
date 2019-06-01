// GENERATED CODE - DO NOT MODIFY BY HAND

part of goal;

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<Goal> _$goalSerializer = new _$GoalSerializer();

class _$GoalSerializer implements StructuredSerializer<Goal> {
  @override
  final Iterable<Type> types = const [Goal, _$Goal];
  @override
  final String wireName = 'Goal';

  @override
  Iterable serialize(Serializers serializers, Goal object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'goalId',
      serializers.serialize(object.goalId,
          specifiedType: const FullType(String)),
      'title',
      serializers.serialize(object.title,
          specifiedType: const FullType(String)),
      'category',
      serializers.serialize(object.category,
          specifiedType: const FullType(GoalCategory)),
      'state',
      serializers.serialize(object.state,
          specifiedType: const FullType(GoalStatus)),
      'account',
      serializers.serialize(object.account,
          specifiedType: const FullType(Account)),
      'public',
      serializers.serialize(object.public, specifiedType: const FullType(bool)),
    ];
    if (object.description != null) {
      result
        ..add('description')
        ..add(serializers.serialize(object.description,
            specifiedType: const FullType(String)));
    }
    if (object.goalUrl != null) {
      result
        ..add('goalUrl')
        ..add(serializers.serialize(object.goalUrl,
            specifiedType: const FullType(String)));
    }
    if (object.challengeId != null) {
      result
        ..add('challengeId')
        ..add(serializers.serialize(object.challengeId,
            specifiedType: const FullType(String)));
    }
    if (object.shouldLog != null) {
      result
        ..add('shouldLog')
        ..add(serializers.serialize(object.shouldLog,
            specifiedType: const FullType(bool)));
    }
    if (object.unit != null) {
      result
        ..add('unit')
        ..add(serializers.serialize(object.unit,
            specifiedType: const FullType(String)));
    }
    if (object.active != null) {
      result
        ..add('active')
        ..add(serializers.serialize(object.active,
            specifiedType: const FullType(bool)));
    }
    if (object.likes != null) {
      result
        ..add('likes')
        ..add(serializers.serialize(object.likes,
            specifiedType: const FullType(int)));
    }
    if (object.dateCreated != null) {
      result
        ..add('dateCreated')
        ..add(serializers.serialize(object.dateCreated,
            specifiedType: const FullType(Timestamp)));
    }
    if (object.dateCompleted != null) {
      result
        ..add('dateCompleted')
        ..add(serializers.serialize(object.dateCompleted,
            specifiedType: const FullType(Timestamp)));
    }
    if (object.position != null) {
      result
        ..add('position')
        ..add(serializers.serialize(object.position,
            specifiedType: const FullType(GeoPoint)));
    }
    if (object.logOptions != null) {
      result
        ..add('logOptions')
        ..add(serializers.serialize(object.logOptions,
            specifiedType: const FullType(EnabledLogOptions)));
    }

    return result;
  }

  @override
  Goal deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GoalBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'goalId':
          result.goalId = serializers.deserialize(value,
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
        case 'state':
          result.state = serializers.deserialize(value,
              specifiedType: const FullType(GoalStatus)) as GoalStatus;
          break;
        case 'goalUrl':
          result.goalUrl = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'challengeId':
          result.challengeId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'account':
          result.account.replace(serializers.deserialize(value,
              specifiedType: const FullType(Account)) as Account);
          break;
        case 'public':
          result.public = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'shouldLog':
          result.shouldLog = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'unit':
          result.unit = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'active':
          result.active = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'likes':
          result.likes = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'dateCreated':
          result.dateCreated = serializers.deserialize(value,
              specifiedType: const FullType(Timestamp)) as Timestamp;
          break;
        case 'dateCompleted':
          result.dateCompleted = serializers.deserialize(value,
              specifiedType: const FullType(Timestamp)) as Timestamp;
          break;
        case 'position':
          result.position = serializers.deserialize(value,
              specifiedType: const FullType(GeoPoint)) as GeoPoint;
          break;
        case 'logOptions':
          result.logOptions.replace(serializers.deserialize(value,
                  specifiedType: const FullType(EnabledLogOptions))
              as EnabledLogOptions);
          break;
      }
    }

    return result.build();
  }
}

class _$Goal extends Goal {
  @override
  final String goalId;
  @override
  final String title;
  @override
  final String description;
  @override
  final GoalCategory category;
  @override
  final GoalStatus state;
  @override
  final String goalUrl;
  @override
  final String challengeId;
  @override
  final Account account;
  @override
  final bool public;
  @override
  final bool shouldLog;
  @override
  final String unit;
  @override
  final bool active;
  @override
  final int likes;
  @override
  final Timestamp dateCreated;
  @override
  final Timestamp dateCompleted;
  @override
  final GeoPoint position;
  @override
  final EnabledLogOptions logOptions;

  factory _$Goal([void Function(GoalBuilder) updates]) =>
      (new GoalBuilder()..update(updates)).build();

  _$Goal._(
      {this.goalId,
      this.title,
      this.description,
      this.category,
      this.state,
      this.goalUrl,
      this.challengeId,
      this.account,
      this.public,
      this.shouldLog,
      this.unit,
      this.active,
      this.likes,
      this.dateCreated,
      this.dateCompleted,
      this.position,
      this.logOptions})
      : super._() {
    if (goalId == null) {
      throw new BuiltValueNullFieldError('Goal', 'goalId');
    }
    if (title == null) {
      throw new BuiltValueNullFieldError('Goal', 'title');
    }
    if (category == null) {
      throw new BuiltValueNullFieldError('Goal', 'category');
    }
    if (state == null) {
      throw new BuiltValueNullFieldError('Goal', 'state');
    }
    if (account == null) {
      throw new BuiltValueNullFieldError('Goal', 'account');
    }
    if (public == null) {
      throw new BuiltValueNullFieldError('Goal', 'public');
    }
  }

  @override
  Goal rebuild(void Function(GoalBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GoalBuilder toBuilder() => new GoalBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Goal &&
        goalId == other.goalId &&
        title == other.title &&
        description == other.description &&
        category == other.category &&
        state == other.state &&
        goalUrl == other.goalUrl &&
        challengeId == other.challengeId &&
        account == other.account &&
        public == other.public &&
        shouldLog == other.shouldLog &&
        unit == other.unit &&
        active == other.active &&
        likes == other.likes &&
        dateCreated == other.dateCreated &&
        dateCompleted == other.dateCompleted &&
        position == other.position &&
        logOptions == other.logOptions;
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
                                                                $jc(
                                                                    $jc(
                                                                        0,
                                                                        goalId
                                                                            .hashCode),
                                                                    title
                                                                        .hashCode),
                                                                description
                                                                    .hashCode),
                                                            category.hashCode),
                                                        state.hashCode),
                                                    goalUrl.hashCode),
                                                challengeId.hashCode),
                                            account.hashCode),
                                        public.hashCode),
                                    shouldLog.hashCode),
                                unit.hashCode),
                            active.hashCode),
                        likes.hashCode),
                    dateCreated.hashCode),
                dateCompleted.hashCode),
            position.hashCode),
        logOptions.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('Goal')
          ..add('goalId', goalId)
          ..add('title', title)
          ..add('description', description)
          ..add('category', category)
          ..add('state', state)
          ..add('goalUrl', goalUrl)
          ..add('challengeId', challengeId)
          ..add('account', account)
          ..add('public', public)
          ..add('shouldLog', shouldLog)
          ..add('unit', unit)
          ..add('active', active)
          ..add('likes', likes)
          ..add('dateCreated', dateCreated)
          ..add('dateCompleted', dateCompleted)
          ..add('position', position)
          ..add('logOptions', logOptions))
        .toString();
  }
}

class GoalBuilder implements Builder<Goal, GoalBuilder> {
  _$Goal _$v;

  String _goalId;
  String get goalId => _$this._goalId;
  set goalId(String goalId) => _$this._goalId = goalId;

  String _title;
  String get title => _$this._title;
  set title(String title) => _$this._title = title;

  String _description;
  String get description => _$this._description;
  set description(String description) => _$this._description = description;

  GoalCategory _category;
  GoalCategory get category => _$this._category;
  set category(GoalCategory category) => _$this._category = category;

  GoalStatus _state;
  GoalStatus get state => _$this._state;
  set state(GoalStatus state) => _$this._state = state;

  String _goalUrl;
  String get goalUrl => _$this._goalUrl;
  set goalUrl(String goalUrl) => _$this._goalUrl = goalUrl;

  String _challengeId;
  String get challengeId => _$this._challengeId;
  set challengeId(String challengeId) => _$this._challengeId = challengeId;

  AccountBuilder _account;
  AccountBuilder get account => _$this._account ??= new AccountBuilder();
  set account(AccountBuilder account) => _$this._account = account;

  bool _public;
  bool get public => _$this._public;
  set public(bool public) => _$this._public = public;

  bool _shouldLog;
  bool get shouldLog => _$this._shouldLog;
  set shouldLog(bool shouldLog) => _$this._shouldLog = shouldLog;

  String _unit;
  String get unit => _$this._unit;
  set unit(String unit) => _$this._unit = unit;

  bool _active;
  bool get active => _$this._active;
  set active(bool active) => _$this._active = active;

  int _likes;
  int get likes => _$this._likes;
  set likes(int likes) => _$this._likes = likes;

  Timestamp _dateCreated;
  Timestamp get dateCreated => _$this._dateCreated;
  set dateCreated(Timestamp dateCreated) => _$this._dateCreated = dateCreated;

  Timestamp _dateCompleted;
  Timestamp get dateCompleted => _$this._dateCompleted;
  set dateCompleted(Timestamp dateCompleted) =>
      _$this._dateCompleted = dateCompleted;

  GeoPoint _position;
  GeoPoint get position => _$this._position;
  set position(GeoPoint position) => _$this._position = position;

  EnabledLogOptionsBuilder _logOptions;
  EnabledLogOptionsBuilder get logOptions =>
      _$this._logOptions ??= new EnabledLogOptionsBuilder();
  set logOptions(EnabledLogOptionsBuilder logOptions) =>
      _$this._logOptions = logOptions;

  GoalBuilder();

  GoalBuilder get _$this {
    if (_$v != null) {
      _goalId = _$v.goalId;
      _title = _$v.title;
      _description = _$v.description;
      _category = _$v.category;
      _state = _$v.state;
      _goalUrl = _$v.goalUrl;
      _challengeId = _$v.challengeId;
      _account = _$v.account?.toBuilder();
      _public = _$v.public;
      _shouldLog = _$v.shouldLog;
      _unit = _$v.unit;
      _active = _$v.active;
      _likes = _$v.likes;
      _dateCreated = _$v.dateCreated;
      _dateCompleted = _$v.dateCompleted;
      _position = _$v.position;
      _logOptions = _$v.logOptions?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Goal other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$Goal;
  }

  @override
  void update(void Function(GoalBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$Goal build() {
    _$Goal _$result;
    try {
      _$result = _$v ??
          new _$Goal._(
              goalId: goalId,
              title: title,
              description: description,
              category: category,
              state: state,
              goalUrl: goalUrl,
              challengeId: challengeId,
              account: account.build(),
              public: public,
              shouldLog: shouldLog,
              unit: unit,
              active: active,
              likes: likes,
              dateCreated: dateCreated,
              dateCompleted: dateCompleted,
              position: position,
              logOptions: _logOptions?.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'account';
        account.build();

        _$failedField = 'logOptions';
        _logOptions?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'Goal', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
