// GENERATED CODE - DO NOT MODIFY BY HAND

part of enabled_log_option;

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<EnabledLogOptions> _$enabledLogOptionsSerializer =
    new _$EnabledLogOptionsSerializer();

class _$EnabledLogOptionsSerializer
    implements StructuredSerializer<EnabledLogOptions> {
  @override
  final Iterable<Type> types = const [EnabledLogOptions, _$EnabledLogOptions];
  @override
  final String wireName = 'EnabledLogOptions';

  @override
  Iterable serialize(Serializers serializers, EnabledLogOptions object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'dailyCheckIn',
      serializers.serialize(object.dailyCheckIn,
          specifiedType: const FullType(bool)),
      'duration',
      serializers.serialize(object.duration,
          specifiedType: const FullType(bool)),
      'measurement',
      serializers.serialize(object.measurement,
          specifiedType: const FullType(bool)),
      'performance',
      serializers.serialize(object.performance,
          specifiedType: const FullType(bool)),
      'reflectiveNotes',
      serializers.serialize(object.reflectiveNotes,
          specifiedType: const FullType(bool)),
    ];
    if (object.measurementUnit != null) {
      result
        ..add('measurementUnit')
        ..add(serializers.serialize(object.measurementUnit,
            specifiedType: const FullType(String)));
    }

    return result;
  }

  @override
  EnabledLogOptions deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new EnabledLogOptionsBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'dailyCheckIn':
          result.dailyCheckIn = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'duration':
          result.duration = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'measurement':
          result.measurement = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'measurementUnit':
          result.measurementUnit = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'performance':
          result.performance = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'reflectiveNotes':
          result.reflectiveNotes = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
      }
    }

    return result.build();
  }
}

class _$EnabledLogOptions extends EnabledLogOptions {
  @override
  final bool dailyCheckIn;
  @override
  final bool duration;
  @override
  final bool measurement;
  @override
  final String measurementUnit;
  @override
  final bool performance;
  @override
  final bool reflectiveNotes;

  factory _$EnabledLogOptions(
          [void Function(EnabledLogOptionsBuilder) updates]) =>
      (new EnabledLogOptionsBuilder()..update(updates)).build();

  _$EnabledLogOptions._(
      {this.dailyCheckIn,
      this.duration,
      this.measurement,
      this.measurementUnit,
      this.performance,
      this.reflectiveNotes})
      : super._() {
    if (dailyCheckIn == null) {
      throw new BuiltValueNullFieldError('EnabledLogOptions', 'dailyCheckIn');
    }
    if (duration == null) {
      throw new BuiltValueNullFieldError('EnabledLogOptions', 'duration');
    }
    if (measurement == null) {
      throw new BuiltValueNullFieldError('EnabledLogOptions', 'measurement');
    }
    if (performance == null) {
      throw new BuiltValueNullFieldError('EnabledLogOptions', 'performance');
    }
    if (reflectiveNotes == null) {
      throw new BuiltValueNullFieldError(
          'EnabledLogOptions', 'reflectiveNotes');
    }
  }

  @override
  EnabledLogOptions rebuild(void Function(EnabledLogOptionsBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  EnabledLogOptionsBuilder toBuilder() =>
      new EnabledLogOptionsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is EnabledLogOptions &&
        dailyCheckIn == other.dailyCheckIn &&
        duration == other.duration &&
        measurement == other.measurement &&
        measurementUnit == other.measurementUnit &&
        performance == other.performance &&
        reflectiveNotes == other.reflectiveNotes;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc($jc($jc(0, dailyCheckIn.hashCode), duration.hashCode),
                    measurement.hashCode),
                measurementUnit.hashCode),
            performance.hashCode),
        reflectiveNotes.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('EnabledLogOptions')
          ..add('dailyCheckIn', dailyCheckIn)
          ..add('duration', duration)
          ..add('measurement', measurement)
          ..add('measurementUnit', measurementUnit)
          ..add('performance', performance)
          ..add('reflectiveNotes', reflectiveNotes))
        .toString();
  }
}

class EnabledLogOptionsBuilder
    implements Builder<EnabledLogOptions, EnabledLogOptionsBuilder> {
  _$EnabledLogOptions _$v;

  bool _dailyCheckIn;
  bool get dailyCheckIn => _$this._dailyCheckIn;
  set dailyCheckIn(bool dailyCheckIn) => _$this._dailyCheckIn = dailyCheckIn;

  bool _duration;
  bool get duration => _$this._duration;
  set duration(bool duration) => _$this._duration = duration;

  bool _measurement;
  bool get measurement => _$this._measurement;
  set measurement(bool measurement) => _$this._measurement = measurement;

  String _measurementUnit;
  String get measurementUnit => _$this._measurementUnit;
  set measurementUnit(String measurementUnit) =>
      _$this._measurementUnit = measurementUnit;

  bool _performance;
  bool get performance => _$this._performance;
  set performance(bool performance) => _$this._performance = performance;

  bool _reflectiveNotes;
  bool get reflectiveNotes => _$this._reflectiveNotes;
  set reflectiveNotes(bool reflectiveNotes) =>
      _$this._reflectiveNotes = reflectiveNotes;

  EnabledLogOptionsBuilder();

  EnabledLogOptionsBuilder get _$this {
    if (_$v != null) {
      _dailyCheckIn = _$v.dailyCheckIn;
      _duration = _$v.duration;
      _measurement = _$v.measurement;
      _measurementUnit = _$v.measurementUnit;
      _performance = _$v.performance;
      _reflectiveNotes = _$v.reflectiveNotes;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(EnabledLogOptions other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$EnabledLogOptions;
  }

  @override
  void update(void Function(EnabledLogOptionsBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$EnabledLogOptions build() {
    final _$result = _$v ??
        new _$EnabledLogOptions._(
            dailyCheckIn: dailyCheckIn,
            duration: duration,
            measurement: measurement,
            measurementUnit: measurementUnit,
            performance: performance,
            reflectiveNotes: reflectiveNotes);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
