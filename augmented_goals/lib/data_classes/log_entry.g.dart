// GENERATED CODE - DO NOT MODIFY BY HAND

part of log_entry;

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<LogEntry> _$logEntrySerializer = new _$LogEntrySerializer();

class _$LogEntrySerializer implements StructuredSerializer<LogEntry> {
  @override
  final Iterable<Type> types = const [LogEntry, _$LogEntry];
  @override
  final String wireName = 'LogEntry';

  @override
  Iterable serialize(Serializers serializers, LogEntry object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'entryId',
      serializers.serialize(object.entryId,
          specifiedType: const FullType(String)),
      'timestamp',
      serializers.serialize(object.timestamp,
          specifiedType: const FullType(Timestamp)),
    ];
    if (object.dailyCheckIn != null) {
      result
        ..add('dailyCheckIn')
        ..add(serializers.serialize(object.dailyCheckIn,
            specifiedType: const FullType(bool)));
    }
    if (object.duration != null) {
      result
        ..add('duration')
        ..add(serializers.serialize(object.duration,
            specifiedType: const FullType(Duration)));
    }
    if (object.measurement != null) {
      result
        ..add('measurement')
        ..add(serializers.serialize(object.measurement,
            specifiedType: const FullType(double)));
    }
    if (object.measurementUnit != null) {
      result
        ..add('measurementUnit')
        ..add(serializers.serialize(object.measurementUnit,
            specifiedType: const FullType(String)));
    }
    if (object.performance != null) {
      result
        ..add('performance')
        ..add(serializers.serialize(object.performance,
            specifiedType: const FullType(int)));
    }
    if (object.reflectiveNotes != null) {
      result
        ..add('reflectiveNotes')
        ..add(serializers.serialize(object.reflectiveNotes,
            specifiedType: const FullType(String)));
    }

    return result;
  }

  @override
  LogEntry deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new LogEntryBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'entryId':
          result.entryId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'timestamp':
          result.timestamp = serializers.deserialize(value,
              specifiedType: const FullType(Timestamp)) as Timestamp;
          break;
        case 'dailyCheckIn':
          result.dailyCheckIn = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'duration':
          result.duration = serializers.deserialize(value,
              specifiedType: const FullType(Duration)) as Duration;
          break;
        case 'measurement':
          result.measurement = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double;
          break;
        case 'measurementUnit':
          result.measurementUnit = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'performance':
          result.performance = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'reflectiveNotes':
          result.reflectiveNotes = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
      }
    }

    return result.build();
  }
}

class _$LogEntry extends LogEntry {
  @override
  final String entryId;
  @override
  final Timestamp timestamp;
  @override
  final bool dailyCheckIn;
  @override
  final Duration duration;
  @override
  final double measurement;
  @override
  final String measurementUnit;
  @override
  final int performance;
  @override
  final String reflectiveNotes;

  factory _$LogEntry([void Function(LogEntryBuilder) updates]) =>
      (new LogEntryBuilder()..update(updates)).build();

  _$LogEntry._(
      {this.entryId,
      this.timestamp,
      this.dailyCheckIn,
      this.duration,
      this.measurement,
      this.measurementUnit,
      this.performance,
      this.reflectiveNotes})
      : super._() {
    if (entryId == null) {
      throw new BuiltValueNullFieldError('LogEntry', 'entryId');
    }
    if (timestamp == null) {
      throw new BuiltValueNullFieldError('LogEntry', 'timestamp');
    }
  }

  @override
  LogEntry rebuild(void Function(LogEntryBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  LogEntryBuilder toBuilder() => new LogEntryBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is LogEntry &&
        entryId == other.entryId &&
        timestamp == other.timestamp &&
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
                $jc(
                    $jc(
                        $jc($jc($jc(0, entryId.hashCode), timestamp.hashCode),
                            dailyCheckIn.hashCode),
                        duration.hashCode),
                    measurement.hashCode),
                measurementUnit.hashCode),
            performance.hashCode),
        reflectiveNotes.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('LogEntry')
          ..add('entryId', entryId)
          ..add('timestamp', timestamp)
          ..add('dailyCheckIn', dailyCheckIn)
          ..add('duration', duration)
          ..add('measurement', measurement)
          ..add('measurementUnit', measurementUnit)
          ..add('performance', performance)
          ..add('reflectiveNotes', reflectiveNotes))
        .toString();
  }
}

class LogEntryBuilder implements Builder<LogEntry, LogEntryBuilder> {
  _$LogEntry _$v;

  String _entryId;
  String get entryId => _$this._entryId;
  set entryId(String entryId) => _$this._entryId = entryId;

  Timestamp _timestamp;
  Timestamp get timestamp => _$this._timestamp;
  set timestamp(Timestamp timestamp) => _$this._timestamp = timestamp;

  bool _dailyCheckIn;
  bool get dailyCheckIn => _$this._dailyCheckIn;
  set dailyCheckIn(bool dailyCheckIn) => _$this._dailyCheckIn = dailyCheckIn;

  Duration _duration;
  Duration get duration => _$this._duration;
  set duration(Duration duration) => _$this._duration = duration;

  double _measurement;
  double get measurement => _$this._measurement;
  set measurement(double measurement) => _$this._measurement = measurement;

  String _measurementUnit;
  String get measurementUnit => _$this._measurementUnit;
  set measurementUnit(String measurementUnit) =>
      _$this._measurementUnit = measurementUnit;

  int _performance;
  int get performance => _$this._performance;
  set performance(int performance) => _$this._performance = performance;

  String _reflectiveNotes;
  String get reflectiveNotes => _$this._reflectiveNotes;
  set reflectiveNotes(String reflectiveNotes) =>
      _$this._reflectiveNotes = reflectiveNotes;

  LogEntryBuilder();

  LogEntryBuilder get _$this {
    if (_$v != null) {
      _entryId = _$v.entryId;
      _timestamp = _$v.timestamp;
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
  void replace(LogEntry other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$LogEntry;
  }

  @override
  void update(void Function(LogEntryBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$LogEntry build() {
    final _$result = _$v ??
        new _$LogEntry._(
            entryId: entryId,
            timestamp: timestamp,
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
