// GENERATED CODE - DO NOT MODIFY BY HAND

part of goal_category;

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const GoalCategory _$Academic = const GoalCategory._('Academic');
const GoalCategory _$Exercise = const GoalCategory._('Exercise');
const GoalCategory _$Food = const GoalCategory._('Food');
const GoalCategory _$Fun = const GoalCategory._('Fun');
const GoalCategory _$Hobby = const GoalCategory._('Hobby');
const GoalCategory _$Health = const GoalCategory._('Health');
const GoalCategory _$Romantic = const GoalCategory._('Romantic');
const GoalCategory _$Music = const GoalCategory._('Music');
const GoalCategory _$Sightseeing = const GoalCategory._('Sightseeing');
const GoalCategory _$Social = const GoalCategory._('Social');
const GoalCategory _$Work = const GoalCategory._('Work');
const GoalCategory _$Other = const GoalCategory._('Other');

GoalCategory _$stValueOf(String name) {
  switch (name) {
    case 'Academic':
      return _$Academic;
    case 'Exercise':
      return _$Exercise;
    case 'Food':
      return _$Food;
    case 'Fun':
      return _$Fun;
    case 'Hobby':
      return _$Hobby;
    case 'Health':
      return _$Health;
    case 'Romantic':
      return _$Romantic;
    case 'Music':
      return _$Music;
    case 'Sightseeing':
      return _$Sightseeing;
    case 'Social':
      return _$Social;
    case 'Work':
      return _$Work;
    case 'Other':
      return _$Other;
    default:
      throw new ArgumentError(name);
  }
}

final BuiltSet<GoalCategory> _$stValues =
    new BuiltSet<GoalCategory>(const <GoalCategory>[
  _$Academic,
  _$Exercise,
  _$Food,
  _$Fun,
  _$Hobby,
  _$Health,
  _$Romantic,
  _$Music,
  _$Sightseeing,
  _$Social,
  _$Work,
  _$Other,
]);

Serializer<GoalCategory> _$goalCategorySerializer =
    new _$GoalCategorySerializer();

class _$GoalCategorySerializer implements PrimitiveSerializer<GoalCategory> {
  @override
  final Iterable<Type> types = const <Type>[GoalCategory];
  @override
  final String wireName = 'GoalCategory';

  @override
  Object serialize(Serializers serializers, GoalCategory object,
          {FullType specifiedType = FullType.unspecified}) =>
      object.name;

  @override
  GoalCategory deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      GoalCategory.valueOf(serialized as String);
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
