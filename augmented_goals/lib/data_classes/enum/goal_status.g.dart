// GENERATED CODE - DO NOT MODIFY BY HAND

part of goal_status;

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const GoalStatus _$newGoal = const GoalStatus._('newGoal');
const GoalStatus _$failure = const GoalStatus._('failure');
const GoalStatus _$setback = const GoalStatus._('setback');
const GoalStatus _$unchanged = const GoalStatus._('unchanged');
const GoalStatus _$progress = const GoalStatus._('progress');
const GoalStatus _$completed = const GoalStatus._('completed');

GoalStatus _$stValueOf(String name) {
  switch (name) {
    case 'newGoal':
      return _$newGoal;
    case 'failure':
      return _$failure;
    case 'setback':
      return _$setback;
    case 'unchanged':
      return _$unchanged;
    case 'progress':
      return _$progress;
    case 'completed':
      return _$completed;
    default:
      throw new ArgumentError(name);
  }
}

final BuiltSet<GoalStatus> _$stValues =
    new BuiltSet<GoalStatus>(const <GoalStatus>[
  _$newGoal,
  _$failure,
  _$setback,
  _$unchanged,
  _$progress,
  _$completed,
]);

Serializer<GoalStatus> _$goalStatusSerializer = new _$GoalStatusSerializer();

class _$GoalStatusSerializer implements PrimitiveSerializer<GoalStatus> {
  @override
  final Iterable<Type> types = const <Type>[GoalStatus];
  @override
  final String wireName = 'GoalStatus';

  @override
  Object serialize(Serializers serializers, GoalStatus object,
          {FullType specifiedType = FullType.unspecified}) =>
      object.name;

  @override
  GoalStatus deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      GoalStatus.valueOf(serialized as String);
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
