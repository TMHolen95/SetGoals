// GENERATED CODE - DO NOT MODIFY BY HAND

part of reminder;

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<Reminder> _$reminderSerializer = new _$ReminderSerializer();

class _$ReminderSerializer implements StructuredSerializer<Reminder> {
  @override
  final Iterable<Type> types = const [Reminder, _$Reminder];
  @override
  final String wireName = 'Reminder';

  @override
  Iterable serialize(Serializers serializers, Reminder object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(int)),
      'goalId',
      serializers.serialize(object.goalId,
          specifiedType: const FullType(String)),
      'goalCategory',
      serializers.serialize(object.goalCategory,
          specifiedType: const FullType(GoalCategory)),
      'timeCreated',
      serializers.serialize(object.timeCreated,
          specifiedType: const FullType(Timestamp)),
      'type',
      serializers.serialize(object.type, specifiedType: const FullType(String)),
    ];
    if (object.timeToRemind != null) {
      result
        ..add('timeToRemind')
        ..add(serializers.serialize(object.timeToRemind,
            specifiedType: const FullType(Timestamp)));
    }
    if (object.timeCanceled != null) {
      result
        ..add('timeCanceled')
        ..add(serializers.serialize(object.timeCanceled,
            specifiedType: const FullType(Timestamp)));
    }
    if (object.canceled != null) {
      result
        ..add('canceled')
        ..add(serializers.serialize(object.canceled,
            specifiedType: const FullType(bool)));
    }
    if (object.day != null) {
      result
        ..add('day')
        ..add(serializers.serialize(object.day,
            specifiedType: const FullType(String)));
    }

    return result;
  }

  @override
  Reminder deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new ReminderBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'goalId':
          result.goalId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'goalCategory':
          result.goalCategory = serializers.deserialize(value,
              specifiedType: const FullType(GoalCategory)) as GoalCategory;
          break;
        case 'timeCreated':
          result.timeCreated = serializers.deserialize(value,
              specifiedType: const FullType(Timestamp)) as Timestamp;
          break;
        case 'timeToRemind':
          result.timeToRemind = serializers.deserialize(value,
              specifiedType: const FullType(Timestamp)) as Timestamp;
          break;
        case 'timeCanceled':
          result.timeCanceled = serializers.deserialize(value,
              specifiedType: const FullType(Timestamp)) as Timestamp;
          break;
        case 'canceled':
          result.canceled = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'type':
          result.type = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'day':
          result.day = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
      }
    }

    return result.build();
  }
}

class _$Reminder extends Reminder {
  @override
  final int id;
  @override
  final String goalId;
  @override
  final GoalCategory goalCategory;
  @override
  final Timestamp timeCreated;
  @override
  final Timestamp timeToRemind;
  @override
  final Timestamp timeCanceled;
  @override
  final bool canceled;
  @override
  final String type;
  @override
  final String day;

  factory _$Reminder([void Function(ReminderBuilder) updates]) =>
      (new ReminderBuilder()..update(updates)).build();

  _$Reminder._(
      {this.id,
      this.goalId,
      this.goalCategory,
      this.timeCreated,
      this.timeToRemind,
      this.timeCanceled,
      this.canceled,
      this.type,
      this.day})
      : super._() {
    if (id == null) {
      throw new BuiltValueNullFieldError('Reminder', 'id');
    }
    if (goalId == null) {
      throw new BuiltValueNullFieldError('Reminder', 'goalId');
    }
    if (goalCategory == null) {
      throw new BuiltValueNullFieldError('Reminder', 'goalCategory');
    }
    if (timeCreated == null) {
      throw new BuiltValueNullFieldError('Reminder', 'timeCreated');
    }
    if (type == null) {
      throw new BuiltValueNullFieldError('Reminder', 'type');
    }
  }

  @override
  Reminder rebuild(void Function(ReminderBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ReminderBuilder toBuilder() => new ReminderBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Reminder &&
        id == other.id &&
        goalId == other.goalId &&
        goalCategory == other.goalCategory &&
        timeCreated == other.timeCreated &&
        timeToRemind == other.timeToRemind &&
        timeCanceled == other.timeCanceled &&
        canceled == other.canceled &&
        type == other.type &&
        day == other.day;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc(
                    $jc(
                        $jc(
                            $jc($jc($jc(0, id.hashCode), goalId.hashCode),
                                goalCategory.hashCode),
                            timeCreated.hashCode),
                        timeToRemind.hashCode),
                    timeCanceled.hashCode),
                canceled.hashCode),
            type.hashCode),
        day.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('Reminder')
          ..add('id', id)
          ..add('goalId', goalId)
          ..add('goalCategory', goalCategory)
          ..add('timeCreated', timeCreated)
          ..add('timeToRemind', timeToRemind)
          ..add('timeCanceled', timeCanceled)
          ..add('canceled', canceled)
          ..add('type', type)
          ..add('day', day))
        .toString();
  }
}

class ReminderBuilder implements Builder<Reminder, ReminderBuilder> {
  _$Reminder _$v;

  int _id;
  int get id => _$this._id;
  set id(int id) => _$this._id = id;

  String _goalId;
  String get goalId => _$this._goalId;
  set goalId(String goalId) => _$this._goalId = goalId;

  GoalCategory _goalCategory;
  GoalCategory get goalCategory => _$this._goalCategory;
  set goalCategory(GoalCategory goalCategory) =>
      _$this._goalCategory = goalCategory;

  Timestamp _timeCreated;
  Timestamp get timeCreated => _$this._timeCreated;
  set timeCreated(Timestamp timeCreated) => _$this._timeCreated = timeCreated;

  Timestamp _timeToRemind;
  Timestamp get timeToRemind => _$this._timeToRemind;
  set timeToRemind(Timestamp timeToRemind) =>
      _$this._timeToRemind = timeToRemind;

  Timestamp _timeCanceled;
  Timestamp get timeCanceled => _$this._timeCanceled;
  set timeCanceled(Timestamp timeCanceled) =>
      _$this._timeCanceled = timeCanceled;

  bool _canceled;
  bool get canceled => _$this._canceled;
  set canceled(bool canceled) => _$this._canceled = canceled;

  String _type;
  String get type => _$this._type;
  set type(String type) => _$this._type = type;

  String _day;
  String get day => _$this._day;
  set day(String day) => _$this._day = day;

  ReminderBuilder();

  ReminderBuilder get _$this {
    if (_$v != null) {
      _id = _$v.id;
      _goalId = _$v.goalId;
      _goalCategory = _$v.goalCategory;
      _timeCreated = _$v.timeCreated;
      _timeToRemind = _$v.timeToRemind;
      _timeCanceled = _$v.timeCanceled;
      _canceled = _$v.canceled;
      _type = _$v.type;
      _day = _$v.day;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Reminder other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$Reminder;
  }

  @override
  void update(void Function(ReminderBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$Reminder build() {
    final _$result = _$v ??
        new _$Reminder._(
            id: id,
            goalId: goalId,
            goalCategory: goalCategory,
            timeCreated: timeCreated,
            timeToRemind: timeToRemind,
            timeCanceled: timeCanceled,
            canceled: canceled,
            type: type,
            day: day);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
