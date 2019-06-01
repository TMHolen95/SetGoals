// GENERATED CODE - DO NOT MODIFY BY HAND

part of account;

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<Account> _$accountSerializer = new _$AccountSerializer();

class _$AccountSerializer implements StructuredSerializer<Account> {
  @override
  final Iterable<Type> types = const [Account, _$Account];
  @override
  final String wireName = 'Account';

  @override
  Iterable serialize(Serializers serializers, Account object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'name',
      serializers.serialize(object.name, specifiedType: const FullType(String)),
      'accountPictureUrl',
      serializers.serialize(object.accountPictureUrl,
          specifiedType: const FullType(String)),
      'accountId',
      serializers.serialize(object.accountId,
          specifiedType: const FullType(String)),
    ];
    if (object.bio != null) {
      result
        ..add('bio')
        ..add(serializers.serialize(object.bio,
            specifiedType: const FullType(String)));
    }
    if (object.nickname != null) {
      result
        ..add('nickname')
        ..add(serializers.serialize(object.nickname,
            specifiedType: const FullType(String)));
    }
    if (object.friendCount != null) {
      result
        ..add('friendCount')
        ..add(serializers.serialize(object.friendCount,
            specifiedType: const FullType(int)));
    }
    if (object.nameLowerCase != null) {
      result
        ..add('nameLowerCase')
        ..add(serializers.serialize(object.nameLowerCase,
            specifiedType: const FullType(String)));
    }
    if (object.goalsCreated != null) {
      result
        ..add('goalsCreated')
        ..add(serializers.serialize(object.goalsCreated,
            specifiedType: const FullType(int)));
    }
    if (object.goalsCompleted != null) {
      result
        ..add('goalsCompleted')
        ..add(serializers.serialize(object.goalsCompleted,
            specifiedType: const FullType(int)));
    }
    if (object.postsCreated != null) {
      result
        ..add('postsCreated')
        ..add(serializers.serialize(object.postsCreated,
            specifiedType: const FullType(int)));
    }
    if (object.socialPoints != null) {
      result
        ..add('socialPoints')
        ..add(serializers.serialize(object.socialPoints,
            specifiedType: const FullType(int)));
    }
    if (object.activityPoints != null) {
      result
        ..add('activityPoints')
        ..add(serializers.serialize(object.activityPoints,
            specifiedType: const FullType(int)));
    }
    if (object.creativityPoints != null) {
      result
        ..add('creativityPoints')
        ..add(serializers.serialize(object.creativityPoints,
            specifiedType: const FullType(int)));
    }
    if (object.bfiTaken != null) {
      result
        ..add('bfiTaken')
        ..add(serializers.serialize(object.bfiTaken,
            specifiedType: const FullType(bool)));
    }
    if (object.questionnairesTaken != null) {
      result
        ..add('questionnairesTaken')
        ..add(serializers.serialize(object.questionnairesTaken,
            specifiedType:
                const FullType(BuiltList, const [const FullType(String)])));
    }
    if (object.playerType != null) {
      result
        ..add('playerType')
        ..add(serializers.serialize(object.playerType,
            specifiedType: const FullType(String)));
    }
    if (object.created != null) {
      result
        ..add('created')
        ..add(serializers.serialize(object.created,
            specifiedType: const FullType(Timestamp)));
    }
    if (object.lastNameChange != null) {
      result
        ..add('lastNameChange')
        ..add(serializers.serialize(object.lastNameChange,
            specifiedType: const FullType(Timestamp)));
    }

    return result;
  }

  @override
  Account deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new AccountBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'name':
          result.name = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'accountPictureUrl':
          result.accountPictureUrl = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'accountId':
          result.accountId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'bio':
          result.bio = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'nickname':
          result.nickname = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'friendCount':
          result.friendCount = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'nameLowerCase':
          result.nameLowerCase = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'goalsCreated':
          result.goalsCreated = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'goalsCompleted':
          result.goalsCompleted = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'postsCreated':
          result.postsCreated = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'socialPoints':
          result.socialPoints = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'activityPoints':
          result.activityPoints = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'creativityPoints':
          result.creativityPoints = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'bfiTaken':
          result.bfiTaken = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'questionnairesTaken':
          result.questionnairesTaken.replace(serializers.deserialize(value,
                  specifiedType:
                      const FullType(BuiltList, const [const FullType(String)]))
              as BuiltList);
          break;
        case 'playerType':
          result.playerType = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'created':
          result.created = serializers.deserialize(value,
              specifiedType: const FullType(Timestamp)) as Timestamp;
          break;
        case 'lastNameChange':
          result.lastNameChange = serializers.deserialize(value,
              specifiedType: const FullType(Timestamp)) as Timestamp;
          break;
      }
    }

    return result.build();
  }
}

class _$Account extends Account {
  @override
  final String name;
  @override
  final String accountPictureUrl;
  @override
  final String accountId;
  @override
  final String bio;
  @override
  final String nickname;
  @override
  final int friendCount;
  @override
  final String nameLowerCase;
  @override
  final int goalsCreated;
  @override
  final int goalsCompleted;
  @override
  final int postsCreated;
  @override
  final int socialPoints;
  @override
  final int activityPoints;
  @override
  final int creativityPoints;
  @override
  final bool bfiTaken;
  @override
  final BuiltList<String> questionnairesTaken;
  @override
  final String playerType;
  @override
  final Timestamp created;
  @override
  final Timestamp lastNameChange;

  factory _$Account([void Function(AccountBuilder) updates]) =>
      (new AccountBuilder()..update(updates)).build();

  _$Account._(
      {this.name,
      this.accountPictureUrl,
      this.accountId,
      this.bio,
      this.nickname,
      this.friendCount,
      this.nameLowerCase,
      this.goalsCreated,
      this.goalsCompleted,
      this.postsCreated,
      this.socialPoints,
      this.activityPoints,
      this.creativityPoints,
      this.bfiTaken,
      this.questionnairesTaken,
      this.playerType,
      this.created,
      this.lastNameChange})
      : super._() {
    if (name == null) {
      throw new BuiltValueNullFieldError('Account', 'name');
    }
    if (accountPictureUrl == null) {
      throw new BuiltValueNullFieldError('Account', 'accountPictureUrl');
    }
    if (accountId == null) {
      throw new BuiltValueNullFieldError('Account', 'accountId');
    }
  }

  @override
  Account rebuild(void Function(AccountBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  AccountBuilder toBuilder() => new AccountBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Account &&
        name == other.name &&
        accountPictureUrl == other.accountPictureUrl &&
        accountId == other.accountId &&
        bio == other.bio &&
        nickname == other.nickname &&
        friendCount == other.friendCount &&
        nameLowerCase == other.nameLowerCase &&
        goalsCreated == other.goalsCreated &&
        goalsCompleted == other.goalsCompleted &&
        postsCreated == other.postsCreated &&
        socialPoints == other.socialPoints &&
        activityPoints == other.activityPoints &&
        creativityPoints == other.creativityPoints &&
        bfiTaken == other.bfiTaken &&
        questionnairesTaken == other.questionnairesTaken &&
        playerType == other.playerType &&
        created == other.created &&
        lastNameChange == other.lastNameChange;
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
                                                                        $jc(
                                                                            0,
                                                                            name
                                                                                .hashCode),
                                                                        accountPictureUrl
                                                                            .hashCode),
                                                                    accountId
                                                                        .hashCode),
                                                                bio.hashCode),
                                                            nickname.hashCode),
                                                        friendCount.hashCode),
                                                    nameLowerCase.hashCode),
                                                goalsCreated.hashCode),
                                            goalsCompleted.hashCode),
                                        postsCreated.hashCode),
                                    socialPoints.hashCode),
                                activityPoints.hashCode),
                            creativityPoints.hashCode),
                        bfiTaken.hashCode),
                    questionnairesTaken.hashCode),
                playerType.hashCode),
            created.hashCode),
        lastNameChange.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('Account')
          ..add('name', name)
          ..add('accountPictureUrl', accountPictureUrl)
          ..add('accountId', accountId)
          ..add('bio', bio)
          ..add('nickname', nickname)
          ..add('friendCount', friendCount)
          ..add('nameLowerCase', nameLowerCase)
          ..add('goalsCreated', goalsCreated)
          ..add('goalsCompleted', goalsCompleted)
          ..add('postsCreated', postsCreated)
          ..add('socialPoints', socialPoints)
          ..add('activityPoints', activityPoints)
          ..add('creativityPoints', creativityPoints)
          ..add('bfiTaken', bfiTaken)
          ..add('questionnairesTaken', questionnairesTaken)
          ..add('playerType', playerType)
          ..add('created', created)
          ..add('lastNameChange', lastNameChange))
        .toString();
  }
}

class AccountBuilder implements Builder<Account, AccountBuilder> {
  _$Account _$v;

  String _name;
  String get name => _$this._name;
  set name(String name) => _$this._name = name;

  String _accountPictureUrl;
  String get accountPictureUrl => _$this._accountPictureUrl;
  set accountPictureUrl(String accountPictureUrl) =>
      _$this._accountPictureUrl = accountPictureUrl;

  String _accountId;
  String get accountId => _$this._accountId;
  set accountId(String accountId) => _$this._accountId = accountId;

  String _bio;
  String get bio => _$this._bio;
  set bio(String bio) => _$this._bio = bio;

  String _nickname;
  String get nickname => _$this._nickname;
  set nickname(String nickname) => _$this._nickname = nickname;

  int _friendCount;
  int get friendCount => _$this._friendCount;
  set friendCount(int friendCount) => _$this._friendCount = friendCount;

  String _nameLowerCase;
  String get nameLowerCase => _$this._nameLowerCase;
  set nameLowerCase(String nameLowerCase) =>
      _$this._nameLowerCase = nameLowerCase;

  int _goalsCreated;
  int get goalsCreated => _$this._goalsCreated;
  set goalsCreated(int goalsCreated) => _$this._goalsCreated = goalsCreated;

  int _goalsCompleted;
  int get goalsCompleted => _$this._goalsCompleted;
  set goalsCompleted(int goalsCompleted) =>
      _$this._goalsCompleted = goalsCompleted;

  int _postsCreated;
  int get postsCreated => _$this._postsCreated;
  set postsCreated(int postsCreated) => _$this._postsCreated = postsCreated;

  int _socialPoints;
  int get socialPoints => _$this._socialPoints;
  set socialPoints(int socialPoints) => _$this._socialPoints = socialPoints;

  int _activityPoints;
  int get activityPoints => _$this._activityPoints;
  set activityPoints(int activityPoints) =>
      _$this._activityPoints = activityPoints;

  int _creativityPoints;
  int get creativityPoints => _$this._creativityPoints;
  set creativityPoints(int creativityPoints) =>
      _$this._creativityPoints = creativityPoints;

  bool _bfiTaken;
  bool get bfiTaken => _$this._bfiTaken;
  set bfiTaken(bool bfiTaken) => _$this._bfiTaken = bfiTaken;

  ListBuilder<String> _questionnairesTaken;
  ListBuilder<String> get questionnairesTaken =>
      _$this._questionnairesTaken ??= new ListBuilder<String>();
  set questionnairesTaken(ListBuilder<String> questionnairesTaken) =>
      _$this._questionnairesTaken = questionnairesTaken;

  String _playerType;
  String get playerType => _$this._playerType;
  set playerType(String playerType) => _$this._playerType = playerType;

  Timestamp _created;
  Timestamp get created => _$this._created;
  set created(Timestamp created) => _$this._created = created;

  Timestamp _lastNameChange;
  Timestamp get lastNameChange => _$this._lastNameChange;
  set lastNameChange(Timestamp lastNameChange) =>
      _$this._lastNameChange = lastNameChange;

  AccountBuilder();

  AccountBuilder get _$this {
    if (_$v != null) {
      _name = _$v.name;
      _accountPictureUrl = _$v.accountPictureUrl;
      _accountId = _$v.accountId;
      _bio = _$v.bio;
      _nickname = _$v.nickname;
      _friendCount = _$v.friendCount;
      _nameLowerCase = _$v.nameLowerCase;
      _goalsCreated = _$v.goalsCreated;
      _goalsCompleted = _$v.goalsCompleted;
      _postsCreated = _$v.postsCreated;
      _socialPoints = _$v.socialPoints;
      _activityPoints = _$v.activityPoints;
      _creativityPoints = _$v.creativityPoints;
      _bfiTaken = _$v.bfiTaken;
      _questionnairesTaken = _$v.questionnairesTaken?.toBuilder();
      _playerType = _$v.playerType;
      _created = _$v.created;
      _lastNameChange = _$v.lastNameChange;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Account other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$Account;
  }

  @override
  void update(void Function(AccountBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$Account build() {
    _$Account _$result;
    try {
      _$result = _$v ??
          new _$Account._(
              name: name,
              accountPictureUrl: accountPictureUrl,
              accountId: accountId,
              bio: bio,
              nickname: nickname,
              friendCount: friendCount,
              nameLowerCase: nameLowerCase,
              goalsCreated: goalsCreated,
              goalsCompleted: goalsCompleted,
              postsCreated: postsCreated,
              socialPoints: socialPoints,
              activityPoints: activityPoints,
              creativityPoints: creativityPoints,
              bfiTaken: bfiTaken,
              questionnairesTaken: _questionnairesTaken?.build(),
              playerType: playerType,
              created: created,
              lastNameChange: lastNameChange);
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'questionnairesTaken';
        _questionnairesTaken?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'Account', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
