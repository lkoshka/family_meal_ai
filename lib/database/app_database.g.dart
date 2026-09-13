// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $FamiliesTable extends Families with TableInfo<$FamiliesTable, Family> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FamiliesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, name, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'families';
  @override
  VerificationContext validateIntegrity(
    Insertable<Family> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Family map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Family(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $FamiliesTable createAlias(String alias) {
    return $FamiliesTable(attachedDatabase, alias);
  }
}

class Family extends DataClass implements Insertable<Family> {
  final int id;
  final String name;
  final DateTime createdAt;
  const Family({required this.id, required this.name, required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  FamiliesCompanion toCompanion(bool nullToAbsent) {
    return FamiliesCompanion(
      id: Value(id),
      name: Value(name),
      createdAt: Value(createdAt),
    );
  }

  factory Family.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Family(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  Family copyWith({int? id, String? name, DateTime? createdAt}) => Family(
    id: id ?? this.id,
    name: name ?? this.name,
    createdAt: createdAt ?? this.createdAt,
  );
  Family copyWithCompanion(FamiliesCompanion data) {
    return Family(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Family(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Family &&
          other.id == this.id &&
          other.name == this.name &&
          other.createdAt == this.createdAt);
}

class FamiliesCompanion extends UpdateCompanion<Family> {
  final Value<int> id;
  final Value<String> name;
  final Value<DateTime> createdAt;
  const FamiliesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  FamiliesCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required DateTime createdAt,
  }) : name = Value(name),
       createdAt = Value(createdAt);
  static Insertable<Family> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  FamiliesCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<DateTime>? createdAt,
  }) {
    return FamiliesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FamiliesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $FamilyMembersTable extends FamilyMembers
    with TableInfo<$FamilyMembersTable, FamilyMember> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FamilyMembersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _familyIdMeta = const VerificationMeta(
    'familyId',
  );
  @override
  late final GeneratedColumn<int> familyId = GeneratedColumn<int>(
    'family_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _birthDateMeta = const VerificationMeta(
    'birthDate',
  );
  @override
  late final GeneratedColumn<DateTime> birthDate = GeneratedColumn<DateTime>(
    'birth_date',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _genderMeta = const VerificationMeta('gender');
  @override
  late final GeneratedColumn<String> gender = GeneratedColumn<String>(
    'gender',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _heightCmMeta = const VerificationMeta(
    'heightCm',
  );
  @override
  late final GeneratedColumn<double> heightCm = GeneratedColumn<double>(
    'height_cm',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _weightKgMeta = const VerificationMeta(
    'weightKg',
  );
  @override
  late final GeneratedColumn<double> weightKg = GeneratedColumn<double>(
    'weight_kg',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _goalMeta = const VerificationMeta('goal');
  @override
  late final GeneratedColumn<String> goal = GeneratedColumn<String>(
    'goal',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _activityMeta = const VerificationMeta(
    'activity',
  );
  @override
  late final GeneratedColumn<String> activity = GeneratedColumn<String>(
    'activity',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _dietTypeMeta = const VerificationMeta(
    'dietType',
  );
  @override
  late final GeneratedColumn<String> dietType = GeneratedColumn<String>(
    'diet_type',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _allergiesMeta = const VerificationMeta(
    'allergies',
  );
  @override
  late final GeneratedColumn<String> allergies = GeneratedColumn<String>(
    'allergies',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _intolerancesMeta = const VerificationMeta(
    'intolerances',
  );
  @override
  late final GeneratedColumn<String> intolerances = GeneratedColumn<String>(
    'intolerances',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _dislikedFoodsMeta = const VerificationMeta(
    'dislikedFoods',
  );
  @override
  late final GeneratedColumn<String> dislikedFoods = GeneratedColumn<String>(
    'disliked_foods',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _likedFoodsMeta = const VerificationMeta(
    'likedFoods',
  );
  @override
  late final GeneratedColumn<String> likedFoods = GeneratedColumn<String>(
    'liked_foods',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _preferencesMeta = const VerificationMeta(
    'preferences',
  );
  @override
  late final GeneratedColumn<String> preferences = GeneratedColumn<String>(
    'preferences',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    familyId,
    name,
    birthDate,
    gender,
    heightCm,
    weightKg,
    goal,
    activity,
    dietType,
    allergies,
    intolerances,
    dislikedFoods,
    likedFoods,
    preferences,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'family_members';
  @override
  VerificationContext validateIntegrity(
    Insertable<FamilyMember> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('family_id')) {
      context.handle(
        _familyIdMeta,
        familyId.isAcceptableOrUnknown(data['family_id']!, _familyIdMeta),
      );
    } else if (isInserting) {
      context.missing(_familyIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('birth_date')) {
      context.handle(
        _birthDateMeta,
        birthDate.isAcceptableOrUnknown(data['birth_date']!, _birthDateMeta),
      );
    }
    if (data.containsKey('gender')) {
      context.handle(
        _genderMeta,
        gender.isAcceptableOrUnknown(data['gender']!, _genderMeta),
      );
    }
    if (data.containsKey('height_cm')) {
      context.handle(
        _heightCmMeta,
        heightCm.isAcceptableOrUnknown(data['height_cm']!, _heightCmMeta),
      );
    }
    if (data.containsKey('weight_kg')) {
      context.handle(
        _weightKgMeta,
        weightKg.isAcceptableOrUnknown(data['weight_kg']!, _weightKgMeta),
      );
    }
    if (data.containsKey('goal')) {
      context.handle(
        _goalMeta,
        goal.isAcceptableOrUnknown(data['goal']!, _goalMeta),
      );
    }
    if (data.containsKey('activity')) {
      context.handle(
        _activityMeta,
        activity.isAcceptableOrUnknown(data['activity']!, _activityMeta),
      );
    }
    if (data.containsKey('diet_type')) {
      context.handle(
        _dietTypeMeta,
        dietType.isAcceptableOrUnknown(data['diet_type']!, _dietTypeMeta),
      );
    }
    if (data.containsKey('allergies')) {
      context.handle(
        _allergiesMeta,
        allergies.isAcceptableOrUnknown(data['allergies']!, _allergiesMeta),
      );
    }
    if (data.containsKey('intolerances')) {
      context.handle(
        _intolerancesMeta,
        intolerances.isAcceptableOrUnknown(
          data['intolerances']!,
          _intolerancesMeta,
        ),
      );
    }
    if (data.containsKey('disliked_foods')) {
      context.handle(
        _dislikedFoodsMeta,
        dislikedFoods.isAcceptableOrUnknown(
          data['disliked_foods']!,
          _dislikedFoodsMeta,
        ),
      );
    }
    if (data.containsKey('liked_foods')) {
      context.handle(
        _likedFoodsMeta,
        likedFoods.isAcceptableOrUnknown(data['liked_foods']!, _likedFoodsMeta),
      );
    }
    if (data.containsKey('preferences')) {
      context.handle(
        _preferencesMeta,
        preferences.isAcceptableOrUnknown(
          data['preferences']!,
          _preferencesMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  FamilyMember map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return FamilyMember(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      familyId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}family_id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      birthDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}birth_date'],
      ),
      gender: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}gender'],
      ),
      heightCm: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}height_cm'],
      ),
      weightKg: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}weight_kg'],
      ),
      goal: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}goal'],
      ),
      activity: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}activity'],
      ),
      dietType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}diet_type'],
      ),
      allergies: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}allergies'],
      ),
      intolerances: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}intolerances'],
      ),
      dislikedFoods: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}disliked_foods'],
      ),
      likedFoods: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}liked_foods'],
      ),
      preferences: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}preferences'],
      ),
    );
  }

  @override
  $FamilyMembersTable createAlias(String alias) {
    return $FamilyMembersTable(attachedDatabase, alias);
  }
}

class FamilyMember extends DataClass implements Insertable<FamilyMember> {
  final int id;
  final int familyId;
  final String name;
  final DateTime? birthDate;
  final String? gender;
  final double? heightCm;
  final double? weightKg;
  final String? goal;
  final String? activity;
  final String? dietType;
  final String? allergies;
  final String? intolerances;
  final String? dislikedFoods;
  final String? likedFoods;
  final String? preferences;
  const FamilyMember({
    required this.id,
    required this.familyId,
    required this.name,
    this.birthDate,
    this.gender,
    this.heightCm,
    this.weightKg,
    this.goal,
    this.activity,
    this.dietType,
    this.allergies,
    this.intolerances,
    this.dislikedFoods,
    this.likedFoods,
    this.preferences,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['family_id'] = Variable<int>(familyId);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || birthDate != null) {
      map['birth_date'] = Variable<DateTime>(birthDate);
    }
    if (!nullToAbsent || gender != null) {
      map['gender'] = Variable<String>(gender);
    }
    if (!nullToAbsent || heightCm != null) {
      map['height_cm'] = Variable<double>(heightCm);
    }
    if (!nullToAbsent || weightKg != null) {
      map['weight_kg'] = Variable<double>(weightKg);
    }
    if (!nullToAbsent || goal != null) {
      map['goal'] = Variable<String>(goal);
    }
    if (!nullToAbsent || activity != null) {
      map['activity'] = Variable<String>(activity);
    }
    if (!nullToAbsent || dietType != null) {
      map['diet_type'] = Variable<String>(dietType);
    }
    if (!nullToAbsent || allergies != null) {
      map['allergies'] = Variable<String>(allergies);
    }
    if (!nullToAbsent || intolerances != null) {
      map['intolerances'] = Variable<String>(intolerances);
    }
    if (!nullToAbsent || dislikedFoods != null) {
      map['disliked_foods'] = Variable<String>(dislikedFoods);
    }
    if (!nullToAbsent || likedFoods != null) {
      map['liked_foods'] = Variable<String>(likedFoods);
    }
    if (!nullToAbsent || preferences != null) {
      map['preferences'] = Variable<String>(preferences);
    }
    return map;
  }

  FamilyMembersCompanion toCompanion(bool nullToAbsent) {
    return FamilyMembersCompanion(
      id: Value(id),
      familyId: Value(familyId),
      name: Value(name),
      birthDate: birthDate == null && nullToAbsent
          ? const Value.absent()
          : Value(birthDate),
      gender: gender == null && nullToAbsent
          ? const Value.absent()
          : Value(gender),
      heightCm: heightCm == null && nullToAbsent
          ? const Value.absent()
          : Value(heightCm),
      weightKg: weightKg == null && nullToAbsent
          ? const Value.absent()
          : Value(weightKg),
      goal: goal == null && nullToAbsent ? const Value.absent() : Value(goal),
      activity: activity == null && nullToAbsent
          ? const Value.absent()
          : Value(activity),
      dietType: dietType == null && nullToAbsent
          ? const Value.absent()
          : Value(dietType),
      allergies: allergies == null && nullToAbsent
          ? const Value.absent()
          : Value(allergies),
      intolerances: intolerances == null && nullToAbsent
          ? const Value.absent()
          : Value(intolerances),
      dislikedFoods: dislikedFoods == null && nullToAbsent
          ? const Value.absent()
          : Value(dislikedFoods),
      likedFoods: likedFoods == null && nullToAbsent
          ? const Value.absent()
          : Value(likedFoods),
      preferences: preferences == null && nullToAbsent
          ? const Value.absent()
          : Value(preferences),
    );
  }

  factory FamilyMember.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FamilyMember(
      id: serializer.fromJson<int>(json['id']),
      familyId: serializer.fromJson<int>(json['familyId']),
      name: serializer.fromJson<String>(json['name']),
      birthDate: serializer.fromJson<DateTime?>(json['birthDate']),
      gender: serializer.fromJson<String?>(json['gender']),
      heightCm: serializer.fromJson<double?>(json['heightCm']),
      weightKg: serializer.fromJson<double?>(json['weightKg']),
      goal: serializer.fromJson<String?>(json['goal']),
      activity: serializer.fromJson<String?>(json['activity']),
      dietType: serializer.fromJson<String?>(json['dietType']),
      allergies: serializer.fromJson<String?>(json['allergies']),
      intolerances: serializer.fromJson<String?>(json['intolerances']),
      dislikedFoods: serializer.fromJson<String?>(json['dislikedFoods']),
      likedFoods: serializer.fromJson<String?>(json['likedFoods']),
      preferences: serializer.fromJson<String?>(json['preferences']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'familyId': serializer.toJson<int>(familyId),
      'name': serializer.toJson<String>(name),
      'birthDate': serializer.toJson<DateTime?>(birthDate),
      'gender': serializer.toJson<String?>(gender),
      'heightCm': serializer.toJson<double?>(heightCm),
      'weightKg': serializer.toJson<double?>(weightKg),
      'goal': serializer.toJson<String?>(goal),
      'activity': serializer.toJson<String?>(activity),
      'dietType': serializer.toJson<String?>(dietType),
      'allergies': serializer.toJson<String?>(allergies),
      'intolerances': serializer.toJson<String?>(intolerances),
      'dislikedFoods': serializer.toJson<String?>(dislikedFoods),
      'likedFoods': serializer.toJson<String?>(likedFoods),
      'preferences': serializer.toJson<String?>(preferences),
    };
  }

  FamilyMember copyWith({
    int? id,
    int? familyId,
    String? name,
    Value<DateTime?> birthDate = const Value.absent(),
    Value<String?> gender = const Value.absent(),
    Value<double?> heightCm = const Value.absent(),
    Value<double?> weightKg = const Value.absent(),
    Value<String?> goal = const Value.absent(),
    Value<String?> activity = const Value.absent(),
    Value<String?> dietType = const Value.absent(),
    Value<String?> allergies = const Value.absent(),
    Value<String?> intolerances = const Value.absent(),
    Value<String?> dislikedFoods = const Value.absent(),
    Value<String?> likedFoods = const Value.absent(),
    Value<String?> preferences = const Value.absent(),
  }) => FamilyMember(
    id: id ?? this.id,
    familyId: familyId ?? this.familyId,
    name: name ?? this.name,
    birthDate: birthDate.present ? birthDate.value : this.birthDate,
    gender: gender.present ? gender.value : this.gender,
    heightCm: heightCm.present ? heightCm.value : this.heightCm,
    weightKg: weightKg.present ? weightKg.value : this.weightKg,
    goal: goal.present ? goal.value : this.goal,
    activity: activity.present ? activity.value : this.activity,
    dietType: dietType.present ? dietType.value : this.dietType,
    allergies: allergies.present ? allergies.value : this.allergies,
    intolerances: intolerances.present ? intolerances.value : this.intolerances,
    dislikedFoods: dislikedFoods.present
        ? dislikedFoods.value
        : this.dislikedFoods,
    likedFoods: likedFoods.present ? likedFoods.value : this.likedFoods,
    preferences: preferences.present ? preferences.value : this.preferences,
  );
  FamilyMember copyWithCompanion(FamilyMembersCompanion data) {
    return FamilyMember(
      id: data.id.present ? data.id.value : this.id,
      familyId: data.familyId.present ? data.familyId.value : this.familyId,
      name: data.name.present ? data.name.value : this.name,
      birthDate: data.birthDate.present ? data.birthDate.value : this.birthDate,
      gender: data.gender.present ? data.gender.value : this.gender,
      heightCm: data.heightCm.present ? data.heightCm.value : this.heightCm,
      weightKg: data.weightKg.present ? data.weightKg.value : this.weightKg,
      goal: data.goal.present ? data.goal.value : this.goal,
      activity: data.activity.present ? data.activity.value : this.activity,
      dietType: data.dietType.present ? data.dietType.value : this.dietType,
      allergies: data.allergies.present ? data.allergies.value : this.allergies,
      intolerances: data.intolerances.present
          ? data.intolerances.value
          : this.intolerances,
      dislikedFoods: data.dislikedFoods.present
          ? data.dislikedFoods.value
          : this.dislikedFoods,
      likedFoods: data.likedFoods.present
          ? data.likedFoods.value
          : this.likedFoods,
      preferences: data.preferences.present
          ? data.preferences.value
          : this.preferences,
    );
  }

  @override
  String toString() {
    return (StringBuffer('FamilyMember(')
          ..write('id: $id, ')
          ..write('familyId: $familyId, ')
          ..write('name: $name, ')
          ..write('birthDate: $birthDate, ')
          ..write('gender: $gender, ')
          ..write('heightCm: $heightCm, ')
          ..write('weightKg: $weightKg, ')
          ..write('goal: $goal, ')
          ..write('activity: $activity, ')
          ..write('dietType: $dietType, ')
          ..write('allergies: $allergies, ')
          ..write('intolerances: $intolerances, ')
          ..write('dislikedFoods: $dislikedFoods, ')
          ..write('likedFoods: $likedFoods, ')
          ..write('preferences: $preferences')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    familyId,
    name,
    birthDate,
    gender,
    heightCm,
    weightKg,
    goal,
    activity,
    dietType,
    allergies,
    intolerances,
    dislikedFoods,
    likedFoods,
    preferences,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FamilyMember &&
          other.id == this.id &&
          other.familyId == this.familyId &&
          other.name == this.name &&
          other.birthDate == this.birthDate &&
          other.gender == this.gender &&
          other.heightCm == this.heightCm &&
          other.weightKg == this.weightKg &&
          other.goal == this.goal &&
          other.activity == this.activity &&
          other.dietType == this.dietType &&
          other.allergies == this.allergies &&
          other.intolerances == this.intolerances &&
          other.dislikedFoods == this.dislikedFoods &&
          other.likedFoods == this.likedFoods &&
          other.preferences == this.preferences);
}

class FamilyMembersCompanion extends UpdateCompanion<FamilyMember> {
  final Value<int> id;
  final Value<int> familyId;
  final Value<String> name;
  final Value<DateTime?> birthDate;
  final Value<String?> gender;
  final Value<double?> heightCm;
  final Value<double?> weightKg;
  final Value<String?> goal;
  final Value<String?> activity;
  final Value<String?> dietType;
  final Value<String?> allergies;
  final Value<String?> intolerances;
  final Value<String?> dislikedFoods;
  final Value<String?> likedFoods;
  final Value<String?> preferences;
  const FamilyMembersCompanion({
    this.id = const Value.absent(),
    this.familyId = const Value.absent(),
    this.name = const Value.absent(),
    this.birthDate = const Value.absent(),
    this.gender = const Value.absent(),
    this.heightCm = const Value.absent(),
    this.weightKg = const Value.absent(),
    this.goal = const Value.absent(),
    this.activity = const Value.absent(),
    this.dietType = const Value.absent(),
    this.allergies = const Value.absent(),
    this.intolerances = const Value.absent(),
    this.dislikedFoods = const Value.absent(),
    this.likedFoods = const Value.absent(),
    this.preferences = const Value.absent(),
  });
  FamilyMembersCompanion.insert({
    this.id = const Value.absent(),
    required int familyId,
    required String name,
    this.birthDate = const Value.absent(),
    this.gender = const Value.absent(),
    this.heightCm = const Value.absent(),
    this.weightKg = const Value.absent(),
    this.goal = const Value.absent(),
    this.activity = const Value.absent(),
    this.dietType = const Value.absent(),
    this.allergies = const Value.absent(),
    this.intolerances = const Value.absent(),
    this.dislikedFoods = const Value.absent(),
    this.likedFoods = const Value.absent(),
    this.preferences = const Value.absent(),
  }) : familyId = Value(familyId),
       name = Value(name);
  static Insertable<FamilyMember> custom({
    Expression<int>? id,
    Expression<int>? familyId,
    Expression<String>? name,
    Expression<DateTime>? birthDate,
    Expression<String>? gender,
    Expression<double>? heightCm,
    Expression<double>? weightKg,
    Expression<String>? goal,
    Expression<String>? activity,
    Expression<String>? dietType,
    Expression<String>? allergies,
    Expression<String>? intolerances,
    Expression<String>? dislikedFoods,
    Expression<String>? likedFoods,
    Expression<String>? preferences,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (familyId != null) 'family_id': familyId,
      if (name != null) 'name': name,
      if (birthDate != null) 'birth_date': birthDate,
      if (gender != null) 'gender': gender,
      if (heightCm != null) 'height_cm': heightCm,
      if (weightKg != null) 'weight_kg': weightKg,
      if (goal != null) 'goal': goal,
      if (activity != null) 'activity': activity,
      if (dietType != null) 'diet_type': dietType,
      if (allergies != null) 'allergies': allergies,
      if (intolerances != null) 'intolerances': intolerances,
      if (dislikedFoods != null) 'disliked_foods': dislikedFoods,
      if (likedFoods != null) 'liked_foods': likedFoods,
      if (preferences != null) 'preferences': preferences,
    });
  }

  FamilyMembersCompanion copyWith({
    Value<int>? id,
    Value<int>? familyId,
    Value<String>? name,
    Value<DateTime?>? birthDate,
    Value<String?>? gender,
    Value<double?>? heightCm,
    Value<double?>? weightKg,
    Value<String?>? goal,
    Value<String?>? activity,
    Value<String?>? dietType,
    Value<String?>? allergies,
    Value<String?>? intolerances,
    Value<String?>? dislikedFoods,
    Value<String?>? likedFoods,
    Value<String?>? preferences,
  }) {
    return FamilyMembersCompanion(
      id: id ?? this.id,
      familyId: familyId ?? this.familyId,
      name: name ?? this.name,
      birthDate: birthDate ?? this.birthDate,
      gender: gender ?? this.gender,
      heightCm: heightCm ?? this.heightCm,
      weightKg: weightKg ?? this.weightKg,
      goal: goal ?? this.goal,
      activity: activity ?? this.activity,
      dietType: dietType ?? this.dietType,
      allergies: allergies ?? this.allergies,
      intolerances: intolerances ?? this.intolerances,
      dislikedFoods: dislikedFoods ?? this.dislikedFoods,
      likedFoods: likedFoods ?? this.likedFoods,
      preferences: preferences ?? this.preferences,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (familyId.present) {
      map['family_id'] = Variable<int>(familyId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (birthDate.present) {
      map['birth_date'] = Variable<DateTime>(birthDate.value);
    }
    if (gender.present) {
      map['gender'] = Variable<String>(gender.value);
    }
    if (heightCm.present) {
      map['height_cm'] = Variable<double>(heightCm.value);
    }
    if (weightKg.present) {
      map['weight_kg'] = Variable<double>(weightKg.value);
    }
    if (goal.present) {
      map['goal'] = Variable<String>(goal.value);
    }
    if (activity.present) {
      map['activity'] = Variable<String>(activity.value);
    }
    if (dietType.present) {
      map['diet_type'] = Variable<String>(dietType.value);
    }
    if (allergies.present) {
      map['allergies'] = Variable<String>(allergies.value);
    }
    if (intolerances.present) {
      map['intolerances'] = Variable<String>(intolerances.value);
    }
    if (dislikedFoods.present) {
      map['disliked_foods'] = Variable<String>(dislikedFoods.value);
    }
    if (likedFoods.present) {
      map['liked_foods'] = Variable<String>(likedFoods.value);
    }
    if (preferences.present) {
      map['preferences'] = Variable<String>(preferences.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FamilyMembersCompanion(')
          ..write('id: $id, ')
          ..write('familyId: $familyId, ')
          ..write('name: $name, ')
          ..write('birthDate: $birthDate, ')
          ..write('gender: $gender, ')
          ..write('heightCm: $heightCm, ')
          ..write('weightKg: $weightKg, ')
          ..write('goal: $goal, ')
          ..write('activity: $activity, ')
          ..write('dietType: $dietType, ')
          ..write('allergies: $allergies, ')
          ..write('intolerances: $intolerances, ')
          ..write('dislikedFoods: $dislikedFoods, ')
          ..write('likedFoods: $likedFoods, ')
          ..write('preferences: $preferences')
          ..write(')'))
        .toString();
  }
}

class $PantryProductsTable extends PantryProducts
    with TableInfo<$PantryProductsTable, PantryProduct> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PantryProductsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _familyIdMeta = const VerificationMeta(
    'familyId',
  );
  @override
  late final GeneratedColumn<int> familyId = GeneratedColumn<int>(
    'family_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<String> amount = GeneratedColumn<String>(
    'amount',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _unitMeta = const VerificationMeta('unit');
  @override
  late final GeneratedColumn<String> unit = GeneratedColumn<String>(
    'unit',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _weightGramsMeta = const VerificationMeta(
    'weightGrams',
  );
  @override
  late final GeneratedColumn<double> weightGrams = GeneratedColumn<double>(
    'weight_grams',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _expirationDateMeta = const VerificationMeta(
    'expirationDate',
  );
  @override
  late final GeneratedColumn<DateTime> expirationDate =
      GeneratedColumn<DateTime>(
        'expiration_date',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    familyId,
    name,
    amount,
    unit,
    weightGrams,
    expirationDate,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'pantry_products';
  @override
  VerificationContext validateIntegrity(
    Insertable<PantryProduct> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('family_id')) {
      context.handle(
        _familyIdMeta,
        familyId.isAcceptableOrUnknown(data['family_id']!, _familyIdMeta),
      );
    } else if (isInserting) {
      context.missing(_familyIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('amount')) {
      context.handle(
        _amountMeta,
        amount.isAcceptableOrUnknown(data['amount']!, _amountMeta),
      );
    } else if (isInserting) {
      context.missing(_amountMeta);
    }
    if (data.containsKey('unit')) {
      context.handle(
        _unitMeta,
        unit.isAcceptableOrUnknown(data['unit']!, _unitMeta),
      );
    } else if (isInserting) {
      context.missing(_unitMeta);
    }
    if (data.containsKey('weight_grams')) {
      context.handle(
        _weightGramsMeta,
        weightGrams.isAcceptableOrUnknown(
          data['weight_grams']!,
          _weightGramsMeta,
        ),
      );
    }
    if (data.containsKey('expiration_date')) {
      context.handle(
        _expirationDateMeta,
        expirationDate.isAcceptableOrUnknown(
          data['expiration_date']!,
          _expirationDateMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PantryProduct map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PantryProduct(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      familyId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}family_id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      amount: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}amount'],
      )!,
      unit: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}unit'],
      )!,
      weightGrams: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}weight_grams'],
      ),
      expirationDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}expiration_date'],
      ),
    );
  }

  @override
  $PantryProductsTable createAlias(String alias) {
    return $PantryProductsTable(attachedDatabase, alias);
  }
}

class PantryProduct extends DataClass implements Insertable<PantryProduct> {
  final int id;
  final int familyId;
  final String name;
  final String amount;
  final String unit;
  final double? weightGrams;
  final DateTime? expirationDate;
  const PantryProduct({
    required this.id,
    required this.familyId,
    required this.name,
    required this.amount,
    required this.unit,
    this.weightGrams,
    this.expirationDate,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['family_id'] = Variable<int>(familyId);
    map['name'] = Variable<String>(name);
    map['amount'] = Variable<String>(amount);
    map['unit'] = Variable<String>(unit);
    if (!nullToAbsent || weightGrams != null) {
      map['weight_grams'] = Variable<double>(weightGrams);
    }
    if (!nullToAbsent || expirationDate != null) {
      map['expiration_date'] = Variable<DateTime>(expirationDate);
    }
    return map;
  }

  PantryProductsCompanion toCompanion(bool nullToAbsent) {
    return PantryProductsCompanion(
      id: Value(id),
      familyId: Value(familyId),
      name: Value(name),
      amount: Value(amount),
      unit: Value(unit),
      weightGrams: weightGrams == null && nullToAbsent
          ? const Value.absent()
          : Value(weightGrams),
      expirationDate: expirationDate == null && nullToAbsent
          ? const Value.absent()
          : Value(expirationDate),
    );
  }

  factory PantryProduct.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PantryProduct(
      id: serializer.fromJson<int>(json['id']),
      familyId: serializer.fromJson<int>(json['familyId']),
      name: serializer.fromJson<String>(json['name']),
      amount: serializer.fromJson<String>(json['amount']),
      unit: serializer.fromJson<String>(json['unit']),
      weightGrams: serializer.fromJson<double?>(json['weightGrams']),
      expirationDate: serializer.fromJson<DateTime?>(json['expirationDate']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'familyId': serializer.toJson<int>(familyId),
      'name': serializer.toJson<String>(name),
      'amount': serializer.toJson<String>(amount),
      'unit': serializer.toJson<String>(unit),
      'weightGrams': serializer.toJson<double?>(weightGrams),
      'expirationDate': serializer.toJson<DateTime?>(expirationDate),
    };
  }

  PantryProduct copyWith({
    int? id,
    int? familyId,
    String? name,
    String? amount,
    String? unit,
    Value<double?> weightGrams = const Value.absent(),
    Value<DateTime?> expirationDate = const Value.absent(),
  }) => PantryProduct(
    id: id ?? this.id,
    familyId: familyId ?? this.familyId,
    name: name ?? this.name,
    amount: amount ?? this.amount,
    unit: unit ?? this.unit,
    weightGrams: weightGrams.present ? weightGrams.value : this.weightGrams,
    expirationDate: expirationDate.present
        ? expirationDate.value
        : this.expirationDate,
  );
  PantryProduct copyWithCompanion(PantryProductsCompanion data) {
    return PantryProduct(
      id: data.id.present ? data.id.value : this.id,
      familyId: data.familyId.present ? data.familyId.value : this.familyId,
      name: data.name.present ? data.name.value : this.name,
      amount: data.amount.present ? data.amount.value : this.amount,
      unit: data.unit.present ? data.unit.value : this.unit,
      weightGrams: data.weightGrams.present
          ? data.weightGrams.value
          : this.weightGrams,
      expirationDate: data.expirationDate.present
          ? data.expirationDate.value
          : this.expirationDate,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PantryProduct(')
          ..write('id: $id, ')
          ..write('familyId: $familyId, ')
          ..write('name: $name, ')
          ..write('amount: $amount, ')
          ..write('unit: $unit, ')
          ..write('weightGrams: $weightGrams, ')
          ..write('expirationDate: $expirationDate')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    familyId,
    name,
    amount,
    unit,
    weightGrams,
    expirationDate,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PantryProduct &&
          other.id == this.id &&
          other.familyId == this.familyId &&
          other.name == this.name &&
          other.amount == this.amount &&
          other.unit == this.unit &&
          other.weightGrams == this.weightGrams &&
          other.expirationDate == this.expirationDate);
}

class PantryProductsCompanion extends UpdateCompanion<PantryProduct> {
  final Value<int> id;
  final Value<int> familyId;
  final Value<String> name;
  final Value<String> amount;
  final Value<String> unit;
  final Value<double?> weightGrams;
  final Value<DateTime?> expirationDate;
  const PantryProductsCompanion({
    this.id = const Value.absent(),
    this.familyId = const Value.absent(),
    this.name = const Value.absent(),
    this.amount = const Value.absent(),
    this.unit = const Value.absent(),
    this.weightGrams = const Value.absent(),
    this.expirationDate = const Value.absent(),
  });
  PantryProductsCompanion.insert({
    this.id = const Value.absent(),
    required int familyId,
    required String name,
    required String amount,
    required String unit,
    this.weightGrams = const Value.absent(),
    this.expirationDate = const Value.absent(),
  }) : familyId = Value(familyId),
       name = Value(name),
       amount = Value(amount),
       unit = Value(unit);
  static Insertable<PantryProduct> custom({
    Expression<int>? id,
    Expression<int>? familyId,
    Expression<String>? name,
    Expression<String>? amount,
    Expression<String>? unit,
    Expression<double>? weightGrams,
    Expression<DateTime>? expirationDate,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (familyId != null) 'family_id': familyId,
      if (name != null) 'name': name,
      if (amount != null) 'amount': amount,
      if (unit != null) 'unit': unit,
      if (weightGrams != null) 'weight_grams': weightGrams,
      if (expirationDate != null) 'expiration_date': expirationDate,
    });
  }

  PantryProductsCompanion copyWith({
    Value<int>? id,
    Value<int>? familyId,
    Value<String>? name,
    Value<String>? amount,
    Value<String>? unit,
    Value<double?>? weightGrams,
    Value<DateTime?>? expirationDate,
  }) {
    return PantryProductsCompanion(
      id: id ?? this.id,
      familyId: familyId ?? this.familyId,
      name: name ?? this.name,
      amount: amount ?? this.amount,
      unit: unit ?? this.unit,
      weightGrams: weightGrams ?? this.weightGrams,
      expirationDate: expirationDate ?? this.expirationDate,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (familyId.present) {
      map['family_id'] = Variable<int>(familyId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (amount.present) {
      map['amount'] = Variable<String>(amount.value);
    }
    if (unit.present) {
      map['unit'] = Variable<String>(unit.value);
    }
    if (weightGrams.present) {
      map['weight_grams'] = Variable<double>(weightGrams.value);
    }
    if (expirationDate.present) {
      map['expiration_date'] = Variable<DateTime>(expirationDate.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PantryProductsCompanion(')
          ..write('id: $id, ')
          ..write('familyId: $familyId, ')
          ..write('name: $name, ')
          ..write('amount: $amount, ')
          ..write('unit: $unit, ')
          ..write('weightGrams: $weightGrams, ')
          ..write('expirationDate: $expirationDate')
          ..write(')'))
        .toString();
  }
}

class $FoodProductsTable extends FoodProducts
    with TableInfo<$FoodProductsTable, FoodProduct> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FoodProductsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _stateMeta = const VerificationMeta('state');
  @override
  late final GeneratedColumn<String> state = GeneratedColumn<String>(
    'state',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _categoryMeta = const VerificationMeta(
    'category',
  );
  @override
  late final GeneratedColumn<String> category = GeneratedColumn<String>(
    'category',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _sourceMeta = const VerificationMeta('source');
  @override
  late final GeneratedColumn<String> source = GeneratedColumn<String>(
    'source',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _sourceIdMeta = const VerificationMeta(
    'sourceId',
  );
  @override
  late final GeneratedColumn<String> sourceId = GeneratedColumn<String>(
    'source_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _caloriesPer100gMeta = const VerificationMeta(
    'caloriesPer100g',
  );
  @override
  late final GeneratedColumn<double> caloriesPer100g = GeneratedColumn<double>(
    'calories_per100g',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _proteinPer100gMeta = const VerificationMeta(
    'proteinPer100g',
  );
  @override
  late final GeneratedColumn<double> proteinPer100g = GeneratedColumn<double>(
    'protein_per100g',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _fatPer100gMeta = const VerificationMeta(
    'fatPer100g',
  );
  @override
  late final GeneratedColumn<double> fatPer100g = GeneratedColumn<double>(
    'fat_per100g',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _carbsPer100gMeta = const VerificationMeta(
    'carbsPer100g',
  );
  @override
  late final GeneratedColumn<double> carbsPer100g = GeneratedColumn<double>(
    'carbs_per100g',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _gramsPerMlMeta = const VerificationMeta(
    'gramsPerMl',
  );
  @override
  late final GeneratedColumn<double> gramsPerMl = GeneratedColumn<double>(
    'grams_per_ml',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    state,
    category,
    source,
    sourceId,
    caloriesPer100g,
    proteinPer100g,
    fatPer100g,
    carbsPer100g,
    gramsPerMl,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'food_products';
  @override
  VerificationContext validateIntegrity(
    Insertable<FoodProduct> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('state')) {
      context.handle(
        _stateMeta,
        state.isAcceptableOrUnknown(data['state']!, _stateMeta),
      );
    } else if (isInserting) {
      context.missing(_stateMeta);
    }
    if (data.containsKey('category')) {
      context.handle(
        _categoryMeta,
        category.isAcceptableOrUnknown(data['category']!, _categoryMeta),
      );
    }
    if (data.containsKey('source')) {
      context.handle(
        _sourceMeta,
        source.isAcceptableOrUnknown(data['source']!, _sourceMeta),
      );
    }
    if (data.containsKey('source_id')) {
      context.handle(
        _sourceIdMeta,
        sourceId.isAcceptableOrUnknown(data['source_id']!, _sourceIdMeta),
      );
    }
    if (data.containsKey('calories_per100g')) {
      context.handle(
        _caloriesPer100gMeta,
        caloriesPer100g.isAcceptableOrUnknown(
          data['calories_per100g']!,
          _caloriesPer100gMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_caloriesPer100gMeta);
    }
    if (data.containsKey('protein_per100g')) {
      context.handle(
        _proteinPer100gMeta,
        proteinPer100g.isAcceptableOrUnknown(
          data['protein_per100g']!,
          _proteinPer100gMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_proteinPer100gMeta);
    }
    if (data.containsKey('fat_per100g')) {
      context.handle(
        _fatPer100gMeta,
        fatPer100g.isAcceptableOrUnknown(data['fat_per100g']!, _fatPer100gMeta),
      );
    } else if (isInserting) {
      context.missing(_fatPer100gMeta);
    }
    if (data.containsKey('carbs_per100g')) {
      context.handle(
        _carbsPer100gMeta,
        carbsPer100g.isAcceptableOrUnknown(
          data['carbs_per100g']!,
          _carbsPer100gMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_carbsPer100gMeta);
    }
    if (data.containsKey('grams_per_ml')) {
      context.handle(
        _gramsPerMlMeta,
        gramsPerMl.isAcceptableOrUnknown(
          data['grams_per_ml']!,
          _gramsPerMlMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  FoodProduct map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return FoodProduct(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      state: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}state'],
      )!,
      category: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}category'],
      )!,
      source: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}source'],
      )!,
      sourceId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}source_id'],
      ),
      caloriesPer100g: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}calories_per100g'],
      )!,
      proteinPer100g: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}protein_per100g'],
      )!,
      fatPer100g: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}fat_per100g'],
      )!,
      carbsPer100g: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}carbs_per100g'],
      )!,
      gramsPerMl: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}grams_per_ml'],
      ),
    );
  }

  @override
  $FoodProductsTable createAlias(String alias) {
    return $FoodProductsTable(attachedDatabase, alias);
  }
}

class FoodProduct extends DataClass implements Insertable<FoodProduct> {
  final int id;
  final String name;
  final String state;
  final String category;
  final String source;
  final String? sourceId;
  final double caloriesPer100g;
  final double proteinPer100g;
  final double fatPer100g;
  final double carbsPer100g;
  final double? gramsPerMl;
  const FoodProduct({
    required this.id,
    required this.name,
    required this.state,
    required this.category,
    required this.source,
    this.sourceId,
    required this.caloriesPer100g,
    required this.proteinPer100g,
    required this.fatPer100g,
    required this.carbsPer100g,
    this.gramsPerMl,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['state'] = Variable<String>(state);
    map['category'] = Variable<String>(category);
    map['source'] = Variable<String>(source);
    if (!nullToAbsent || sourceId != null) {
      map['source_id'] = Variable<String>(sourceId);
    }
    map['calories_per100g'] = Variable<double>(caloriesPer100g);
    map['protein_per100g'] = Variable<double>(proteinPer100g);
    map['fat_per100g'] = Variable<double>(fatPer100g);
    map['carbs_per100g'] = Variable<double>(carbsPer100g);
    if (!nullToAbsent || gramsPerMl != null) {
      map['grams_per_ml'] = Variable<double>(gramsPerMl);
    }
    return map;
  }

  FoodProductsCompanion toCompanion(bool nullToAbsent) {
    return FoodProductsCompanion(
      id: Value(id),
      name: Value(name),
      state: Value(state),
      category: Value(category),
      source: Value(source),
      sourceId: sourceId == null && nullToAbsent
          ? const Value.absent()
          : Value(sourceId),
      caloriesPer100g: Value(caloriesPer100g),
      proteinPer100g: Value(proteinPer100g),
      fatPer100g: Value(fatPer100g),
      carbsPer100g: Value(carbsPer100g),
      gramsPerMl: gramsPerMl == null && nullToAbsent
          ? const Value.absent()
          : Value(gramsPerMl),
    );
  }

  factory FoodProduct.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FoodProduct(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      state: serializer.fromJson<String>(json['state']),
      category: serializer.fromJson<String>(json['category']),
      source: serializer.fromJson<String>(json['source']),
      sourceId: serializer.fromJson<String?>(json['sourceId']),
      caloriesPer100g: serializer.fromJson<double>(json['caloriesPer100g']),
      proteinPer100g: serializer.fromJson<double>(json['proteinPer100g']),
      fatPer100g: serializer.fromJson<double>(json['fatPer100g']),
      carbsPer100g: serializer.fromJson<double>(json['carbsPer100g']),
      gramsPerMl: serializer.fromJson<double?>(json['gramsPerMl']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'state': serializer.toJson<String>(state),
      'category': serializer.toJson<String>(category),
      'source': serializer.toJson<String>(source),
      'sourceId': serializer.toJson<String?>(sourceId),
      'caloriesPer100g': serializer.toJson<double>(caloriesPer100g),
      'proteinPer100g': serializer.toJson<double>(proteinPer100g),
      'fatPer100g': serializer.toJson<double>(fatPer100g),
      'carbsPer100g': serializer.toJson<double>(carbsPer100g),
      'gramsPerMl': serializer.toJson<double?>(gramsPerMl),
    };
  }

  FoodProduct copyWith({
    int? id,
    String? name,
    String? state,
    String? category,
    String? source,
    Value<String?> sourceId = const Value.absent(),
    double? caloriesPer100g,
    double? proteinPer100g,
    double? fatPer100g,
    double? carbsPer100g,
    Value<double?> gramsPerMl = const Value.absent(),
  }) => FoodProduct(
    id: id ?? this.id,
    name: name ?? this.name,
    state: state ?? this.state,
    category: category ?? this.category,
    source: source ?? this.source,
    sourceId: sourceId.present ? sourceId.value : this.sourceId,
    caloriesPer100g: caloriesPer100g ?? this.caloriesPer100g,
    proteinPer100g: proteinPer100g ?? this.proteinPer100g,
    fatPer100g: fatPer100g ?? this.fatPer100g,
    carbsPer100g: carbsPer100g ?? this.carbsPer100g,
    gramsPerMl: gramsPerMl.present ? gramsPerMl.value : this.gramsPerMl,
  );
  FoodProduct copyWithCompanion(FoodProductsCompanion data) {
    return FoodProduct(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      state: data.state.present ? data.state.value : this.state,
      category: data.category.present ? data.category.value : this.category,
      source: data.source.present ? data.source.value : this.source,
      sourceId: data.sourceId.present ? data.sourceId.value : this.sourceId,
      caloriesPer100g: data.caloriesPer100g.present
          ? data.caloriesPer100g.value
          : this.caloriesPer100g,
      proteinPer100g: data.proteinPer100g.present
          ? data.proteinPer100g.value
          : this.proteinPer100g,
      fatPer100g: data.fatPer100g.present
          ? data.fatPer100g.value
          : this.fatPer100g,
      carbsPer100g: data.carbsPer100g.present
          ? data.carbsPer100g.value
          : this.carbsPer100g,
      gramsPerMl: data.gramsPerMl.present
          ? data.gramsPerMl.value
          : this.gramsPerMl,
    );
  }

  @override
  String toString() {
    return (StringBuffer('FoodProduct(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('state: $state, ')
          ..write('category: $category, ')
          ..write('source: $source, ')
          ..write('sourceId: $sourceId, ')
          ..write('caloriesPer100g: $caloriesPer100g, ')
          ..write('proteinPer100g: $proteinPer100g, ')
          ..write('fatPer100g: $fatPer100g, ')
          ..write('carbsPer100g: $carbsPer100g, ')
          ..write('gramsPerMl: $gramsPerMl')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    state,
    category,
    source,
    sourceId,
    caloriesPer100g,
    proteinPer100g,
    fatPer100g,
    carbsPer100g,
    gramsPerMl,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FoodProduct &&
          other.id == this.id &&
          other.name == this.name &&
          other.state == this.state &&
          other.category == this.category &&
          other.source == this.source &&
          other.sourceId == this.sourceId &&
          other.caloriesPer100g == this.caloriesPer100g &&
          other.proteinPer100g == this.proteinPer100g &&
          other.fatPer100g == this.fatPer100g &&
          other.carbsPer100g == this.carbsPer100g &&
          other.gramsPerMl == this.gramsPerMl);
}

class FoodProductsCompanion extends UpdateCompanion<FoodProduct> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> state;
  final Value<String> category;
  final Value<String> source;
  final Value<String?> sourceId;
  final Value<double> caloriesPer100g;
  final Value<double> proteinPer100g;
  final Value<double> fatPer100g;
  final Value<double> carbsPer100g;
  final Value<double?> gramsPerMl;
  const FoodProductsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.state = const Value.absent(),
    this.category = const Value.absent(),
    this.source = const Value.absent(),
    this.sourceId = const Value.absent(),
    this.caloriesPer100g = const Value.absent(),
    this.proteinPer100g = const Value.absent(),
    this.fatPer100g = const Value.absent(),
    this.carbsPer100g = const Value.absent(),
    this.gramsPerMl = const Value.absent(),
  });
  FoodProductsCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required String state,
    this.category = const Value.absent(),
    this.source = const Value.absent(),
    this.sourceId = const Value.absent(),
    required double caloriesPer100g,
    required double proteinPer100g,
    required double fatPer100g,
    required double carbsPer100g,
    this.gramsPerMl = const Value.absent(),
  }) : name = Value(name),
       state = Value(state),
       caloriesPer100g = Value(caloriesPer100g),
       proteinPer100g = Value(proteinPer100g),
       fatPer100g = Value(fatPer100g),
       carbsPer100g = Value(carbsPer100g);
  static Insertable<FoodProduct> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? state,
    Expression<String>? category,
    Expression<String>? source,
    Expression<String>? sourceId,
    Expression<double>? caloriesPer100g,
    Expression<double>? proteinPer100g,
    Expression<double>? fatPer100g,
    Expression<double>? carbsPer100g,
    Expression<double>? gramsPerMl,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (state != null) 'state': state,
      if (category != null) 'category': category,
      if (source != null) 'source': source,
      if (sourceId != null) 'source_id': sourceId,
      if (caloriesPer100g != null) 'calories_per100g': caloriesPer100g,
      if (proteinPer100g != null) 'protein_per100g': proteinPer100g,
      if (fatPer100g != null) 'fat_per100g': fatPer100g,
      if (carbsPer100g != null) 'carbs_per100g': carbsPer100g,
      if (gramsPerMl != null) 'grams_per_ml': gramsPerMl,
    });
  }

  FoodProductsCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<String>? state,
    Value<String>? category,
    Value<String>? source,
    Value<String?>? sourceId,
    Value<double>? caloriesPer100g,
    Value<double>? proteinPer100g,
    Value<double>? fatPer100g,
    Value<double>? carbsPer100g,
    Value<double?>? gramsPerMl,
  }) {
    return FoodProductsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      state: state ?? this.state,
      category: category ?? this.category,
      source: source ?? this.source,
      sourceId: sourceId ?? this.sourceId,
      caloriesPer100g: caloriesPer100g ?? this.caloriesPer100g,
      proteinPer100g: proteinPer100g ?? this.proteinPer100g,
      fatPer100g: fatPer100g ?? this.fatPer100g,
      carbsPer100g: carbsPer100g ?? this.carbsPer100g,
      gramsPerMl: gramsPerMl ?? this.gramsPerMl,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (state.present) {
      map['state'] = Variable<String>(state.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (source.present) {
      map['source'] = Variable<String>(source.value);
    }
    if (sourceId.present) {
      map['source_id'] = Variable<String>(sourceId.value);
    }
    if (caloriesPer100g.present) {
      map['calories_per100g'] = Variable<double>(caloriesPer100g.value);
    }
    if (proteinPer100g.present) {
      map['protein_per100g'] = Variable<double>(proteinPer100g.value);
    }
    if (fatPer100g.present) {
      map['fat_per100g'] = Variable<double>(fatPer100g.value);
    }
    if (carbsPer100g.present) {
      map['carbs_per100g'] = Variable<double>(carbsPer100g.value);
    }
    if (gramsPerMl.present) {
      map['grams_per_ml'] = Variable<double>(gramsPerMl.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FoodProductsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('state: $state, ')
          ..write('category: $category, ')
          ..write('source: $source, ')
          ..write('sourceId: $sourceId, ')
          ..write('caloriesPer100g: $caloriesPer100g, ')
          ..write('proteinPer100g: $proteinPer100g, ')
          ..write('fatPer100g: $fatPer100g, ')
          ..write('carbsPer100g: $carbsPer100g, ')
          ..write('gramsPerMl: $gramsPerMl')
          ..write(')'))
        .toString();
  }
}

class $FoodProductAliasesTable extends FoodProductAliases
    with TableInfo<$FoodProductAliasesTable, FoodProductAliase> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FoodProductAliasesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _foodProductIdMeta = const VerificationMeta(
    'foodProductId',
  );
  @override
  late final GeneratedColumn<int> foodProductId = GeneratedColumn<int>(
    'food_product_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _aliasMeta = const VerificationMeta('alias');
  @override
  late final GeneratedColumn<String> alias = GeneratedColumn<String>(
    'alias',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  @override
  List<GeneratedColumn> get $columns => [id, foodProductId, alias];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'food_product_aliases';
  @override
  VerificationContext validateIntegrity(
    Insertable<FoodProductAliase> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('food_product_id')) {
      context.handle(
        _foodProductIdMeta,
        foodProductId.isAcceptableOrUnknown(
          data['food_product_id']!,
          _foodProductIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_foodProductIdMeta);
    }
    if (data.containsKey('alias')) {
      context.handle(
        _aliasMeta,
        alias.isAcceptableOrUnknown(data['alias']!, _aliasMeta),
      );
    } else if (isInserting) {
      context.missing(_aliasMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  FoodProductAliase map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return FoodProductAliase(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      foodProductId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}food_product_id'],
      )!,
      alias: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}alias'],
      )!,
    );
  }

  @override
  $FoodProductAliasesTable createAlias(String alias) {
    return $FoodProductAliasesTable(attachedDatabase, alias);
  }
}

class FoodProductAliase extends DataClass
    implements Insertable<FoodProductAliase> {
  final int id;
  final int foodProductId;
  final String alias;
  const FoodProductAliase({
    required this.id,
    required this.foodProductId,
    required this.alias,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['food_product_id'] = Variable<int>(foodProductId);
    map['alias'] = Variable<String>(alias);
    return map;
  }

  FoodProductAliasesCompanion toCompanion(bool nullToAbsent) {
    return FoodProductAliasesCompanion(
      id: Value(id),
      foodProductId: Value(foodProductId),
      alias: Value(alias),
    );
  }

  factory FoodProductAliase.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FoodProductAliase(
      id: serializer.fromJson<int>(json['id']),
      foodProductId: serializer.fromJson<int>(json['foodProductId']),
      alias: serializer.fromJson<String>(json['alias']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'foodProductId': serializer.toJson<int>(foodProductId),
      'alias': serializer.toJson<String>(alias),
    };
  }

  FoodProductAliase copyWith({int? id, int? foodProductId, String? alias}) =>
      FoodProductAliase(
        id: id ?? this.id,
        foodProductId: foodProductId ?? this.foodProductId,
        alias: alias ?? this.alias,
      );
  FoodProductAliase copyWithCompanion(FoodProductAliasesCompanion data) {
    return FoodProductAliase(
      id: data.id.present ? data.id.value : this.id,
      foodProductId: data.foodProductId.present
          ? data.foodProductId.value
          : this.foodProductId,
      alias: data.alias.present ? data.alias.value : this.alias,
    );
  }

  @override
  String toString() {
    return (StringBuffer('FoodProductAliase(')
          ..write('id: $id, ')
          ..write('foodProductId: $foodProductId, ')
          ..write('alias: $alias')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, foodProductId, alias);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FoodProductAliase &&
          other.id == this.id &&
          other.foodProductId == this.foodProductId &&
          other.alias == this.alias);
}

class FoodProductAliasesCompanion extends UpdateCompanion<FoodProductAliase> {
  final Value<int> id;
  final Value<int> foodProductId;
  final Value<String> alias;
  const FoodProductAliasesCompanion({
    this.id = const Value.absent(),
    this.foodProductId = const Value.absent(),
    this.alias = const Value.absent(),
  });
  FoodProductAliasesCompanion.insert({
    this.id = const Value.absent(),
    required int foodProductId,
    required String alias,
  }) : foodProductId = Value(foodProductId),
       alias = Value(alias);
  static Insertable<FoodProductAliase> custom({
    Expression<int>? id,
    Expression<int>? foodProductId,
    Expression<String>? alias,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (foodProductId != null) 'food_product_id': foodProductId,
      if (alias != null) 'alias': alias,
    });
  }

  FoodProductAliasesCompanion copyWith({
    Value<int>? id,
    Value<int>? foodProductId,
    Value<String>? alias,
  }) {
    return FoodProductAliasesCompanion(
      id: id ?? this.id,
      foodProductId: foodProductId ?? this.foodProductId,
      alias: alias ?? this.alias,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (foodProductId.present) {
      map['food_product_id'] = Variable<int>(foodProductId.value);
    }
    if (alias.present) {
      map['alias'] = Variable<String>(alias.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FoodProductAliasesCompanion(')
          ..write('id: $id, ')
          ..write('foodProductId: $foodProductId, ')
          ..write('alias: $alias')
          ..write(')'))
        .toString();
  }
}

class $UnknownFoodProductsTable extends UnknownFoodProducts
    with TableInfo<$UnknownFoodProductsTable, UnknownFoodProduct> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UnknownFoodProductsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('pending'),
  );
  static const VerificationMeta _resolvedFoodProductIdMeta =
      const VerificationMeta('resolvedFoodProductId');
  @override
  late final GeneratedColumn<int> resolvedFoodProductId = GeneratedColumn<int>(
    'resolved_food_product_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _firstSeenAtMeta = const VerificationMeta(
    'firstSeenAt',
  );
  @override
  late final GeneratedColumn<DateTime> firstSeenAt = GeneratedColumn<DateTime>(
    'first_seen_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    status,
    resolvedFoodProductId,
    firstSeenAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'unknown_food_products';
  @override
  VerificationContext validateIntegrity(
    Insertable<UnknownFoodProduct> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    }
    if (data.containsKey('resolved_food_product_id')) {
      context.handle(
        _resolvedFoodProductIdMeta,
        resolvedFoodProductId.isAcceptableOrUnknown(
          data['resolved_food_product_id']!,
          _resolvedFoodProductIdMeta,
        ),
      );
    }
    if (data.containsKey('first_seen_at')) {
      context.handle(
        _firstSeenAtMeta,
        firstSeenAt.isAcceptableOrUnknown(
          data['first_seen_at']!,
          _firstSeenAtMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_firstSeenAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  UnknownFoodProduct map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return UnknownFoodProduct(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      resolvedFoodProductId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}resolved_food_product_id'],
      ),
      firstSeenAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}first_seen_at'],
      )!,
    );
  }

  @override
  $UnknownFoodProductsTable createAlias(String alias) {
    return $UnknownFoodProductsTable(attachedDatabase, alias);
  }
}

class UnknownFoodProduct extends DataClass
    implements Insertable<UnknownFoodProduct> {
  final int id;
  final String name;
  final String status;
  final int? resolvedFoodProductId;
  final DateTime firstSeenAt;
  const UnknownFoodProduct({
    required this.id,
    required this.name,
    required this.status,
    this.resolvedFoodProductId,
    required this.firstSeenAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['status'] = Variable<String>(status);
    if (!nullToAbsent || resolvedFoodProductId != null) {
      map['resolved_food_product_id'] = Variable<int>(resolvedFoodProductId);
    }
    map['first_seen_at'] = Variable<DateTime>(firstSeenAt);
    return map;
  }

  UnknownFoodProductsCompanion toCompanion(bool nullToAbsent) {
    return UnknownFoodProductsCompanion(
      id: Value(id),
      name: Value(name),
      status: Value(status),
      resolvedFoodProductId: resolvedFoodProductId == null && nullToAbsent
          ? const Value.absent()
          : Value(resolvedFoodProductId),
      firstSeenAt: Value(firstSeenAt),
    );
  }

  factory UnknownFoodProduct.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return UnknownFoodProduct(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      status: serializer.fromJson<String>(json['status']),
      resolvedFoodProductId: serializer.fromJson<int?>(
        json['resolvedFoodProductId'],
      ),
      firstSeenAt: serializer.fromJson<DateTime>(json['firstSeenAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'status': serializer.toJson<String>(status),
      'resolvedFoodProductId': serializer.toJson<int?>(resolvedFoodProductId),
      'firstSeenAt': serializer.toJson<DateTime>(firstSeenAt),
    };
  }

  UnknownFoodProduct copyWith({
    int? id,
    String? name,
    String? status,
    Value<int?> resolvedFoodProductId = const Value.absent(),
    DateTime? firstSeenAt,
  }) => UnknownFoodProduct(
    id: id ?? this.id,
    name: name ?? this.name,
    status: status ?? this.status,
    resolvedFoodProductId: resolvedFoodProductId.present
        ? resolvedFoodProductId.value
        : this.resolvedFoodProductId,
    firstSeenAt: firstSeenAt ?? this.firstSeenAt,
  );
  UnknownFoodProduct copyWithCompanion(UnknownFoodProductsCompanion data) {
    return UnknownFoodProduct(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      status: data.status.present ? data.status.value : this.status,
      resolvedFoodProductId: data.resolvedFoodProductId.present
          ? data.resolvedFoodProductId.value
          : this.resolvedFoodProductId,
      firstSeenAt: data.firstSeenAt.present
          ? data.firstSeenAt.value
          : this.firstSeenAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('UnknownFoodProduct(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('status: $status, ')
          ..write('resolvedFoodProductId: $resolvedFoodProductId, ')
          ..write('firstSeenAt: $firstSeenAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, name, status, resolvedFoodProductId, firstSeenAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UnknownFoodProduct &&
          other.id == this.id &&
          other.name == this.name &&
          other.status == this.status &&
          other.resolvedFoodProductId == this.resolvedFoodProductId &&
          other.firstSeenAt == this.firstSeenAt);
}

class UnknownFoodProductsCompanion extends UpdateCompanion<UnknownFoodProduct> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> status;
  final Value<int?> resolvedFoodProductId;
  final Value<DateTime> firstSeenAt;
  const UnknownFoodProductsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.status = const Value.absent(),
    this.resolvedFoodProductId = const Value.absent(),
    this.firstSeenAt = const Value.absent(),
  });
  UnknownFoodProductsCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    this.status = const Value.absent(),
    this.resolvedFoodProductId = const Value.absent(),
    required DateTime firstSeenAt,
  }) : name = Value(name),
       firstSeenAt = Value(firstSeenAt);
  static Insertable<UnknownFoodProduct> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? status,
    Expression<int>? resolvedFoodProductId,
    Expression<DateTime>? firstSeenAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (status != null) 'status': status,
      if (resolvedFoodProductId != null)
        'resolved_food_product_id': resolvedFoodProductId,
      if (firstSeenAt != null) 'first_seen_at': firstSeenAt,
    });
  }

  UnknownFoodProductsCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<String>? status,
    Value<int?>? resolvedFoodProductId,
    Value<DateTime>? firstSeenAt,
  }) {
    return UnknownFoodProductsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      status: status ?? this.status,
      resolvedFoodProductId:
          resolvedFoodProductId ?? this.resolvedFoodProductId,
      firstSeenAt: firstSeenAt ?? this.firstSeenAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (resolvedFoodProductId.present) {
      map['resolved_food_product_id'] = Variable<int>(
        resolvedFoodProductId.value,
      );
    }
    if (firstSeenAt.present) {
      map['first_seen_at'] = Variable<DateTime>(firstSeenAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UnknownFoodProductsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('status: $status, ')
          ..write('resolvedFoodProductId: $resolvedFoodProductId, ')
          ..write('firstSeenAt: $firstSeenAt')
          ..write(')'))
        .toString();
  }
}

class $RecipesTable extends Recipes with TableInfo<$RecipesTable, Recipe> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RecipesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _instructionsMeta = const VerificationMeta(
    'instructions',
  );
  @override
  late final GeneratedColumn<String> instructions = GeneratedColumn<String>(
    'instructions',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _prepMinutesMeta = const VerificationMeta(
    'prepMinutes',
  );
  @override
  late final GeneratedColumn<int> prepMinutes = GeneratedColumn<int>(
    'prep_minutes',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _servingsMeta = const VerificationMeta(
    'servings',
  );
  @override
  late final GeneratedColumn<int> servings = GeneratedColumn<int>(
    'servings',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _caloriesPerServingMeta =
      const VerificationMeta('caloriesPerServing');
  @override
  late final GeneratedColumn<double> caloriesPerServing =
      GeneratedColumn<double>(
        'calories_per_serving',
        aliasedName,
        false,
        type: DriftSqlType.double,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _proteinPerServingMeta = const VerificationMeta(
    'proteinPerServing',
  );
  @override
  late final GeneratedColumn<double> proteinPerServing =
      GeneratedColumn<double>(
        'protein_per_serving',
        aliasedName,
        false,
        type: DriftSqlType.double,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _fatPerServingMeta = const VerificationMeta(
    'fatPerServing',
  );
  @override
  late final GeneratedColumn<double> fatPerServing = GeneratedColumn<double>(
    'fat_per_serving',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _carbsPerServingMeta = const VerificationMeta(
    'carbsPerServing',
  );
  @override
  late final GeneratedColumn<double> carbsPerServing = GeneratedColumn<double>(
    'carbs_per_serving',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dietTypesMeta = const VerificationMeta(
    'dietTypes',
  );
  @override
  late final GeneratedColumn<String> dietTypes = GeneratedColumn<String>(
    'diet_types',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _allergensMeta = const VerificationMeta(
    'allergens',
  );
  @override
  late final GeneratedColumn<String> allergens = GeneratedColumn<String>(
    'allergens',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isBuiltInMeta = const VerificationMeta(
    'isBuiltIn',
  );
  @override
  late final GeneratedColumn<bool> isBuiltIn = GeneratedColumn<bool>(
    'is_built_in',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_built_in" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    description,
    instructions,
    prepMinutes,
    servings,
    caloriesPerServing,
    proteinPerServing,
    fatPerServing,
    carbsPerServing,
    dietTypes,
    allergens,
    isBuiltIn,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'recipes';
  @override
  VerificationContext validateIntegrity(
    Insertable<Recipe> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    }
    if (data.containsKey('instructions')) {
      context.handle(
        _instructionsMeta,
        instructions.isAcceptableOrUnknown(
          data['instructions']!,
          _instructionsMeta,
        ),
      );
    }
    if (data.containsKey('prep_minutes')) {
      context.handle(
        _prepMinutesMeta,
        prepMinutes.isAcceptableOrUnknown(
          data['prep_minutes']!,
          _prepMinutesMeta,
        ),
      );
    }
    if (data.containsKey('servings')) {
      context.handle(
        _servingsMeta,
        servings.isAcceptableOrUnknown(data['servings']!, _servingsMeta),
      );
    }
    if (data.containsKey('calories_per_serving')) {
      context.handle(
        _caloriesPerServingMeta,
        caloriesPerServing.isAcceptableOrUnknown(
          data['calories_per_serving']!,
          _caloriesPerServingMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_caloriesPerServingMeta);
    }
    if (data.containsKey('protein_per_serving')) {
      context.handle(
        _proteinPerServingMeta,
        proteinPerServing.isAcceptableOrUnknown(
          data['protein_per_serving']!,
          _proteinPerServingMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_proteinPerServingMeta);
    }
    if (data.containsKey('fat_per_serving')) {
      context.handle(
        _fatPerServingMeta,
        fatPerServing.isAcceptableOrUnknown(
          data['fat_per_serving']!,
          _fatPerServingMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_fatPerServingMeta);
    }
    if (data.containsKey('carbs_per_serving')) {
      context.handle(
        _carbsPerServingMeta,
        carbsPerServing.isAcceptableOrUnknown(
          data['carbs_per_serving']!,
          _carbsPerServingMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_carbsPerServingMeta);
    }
    if (data.containsKey('diet_types')) {
      context.handle(
        _dietTypesMeta,
        dietTypes.isAcceptableOrUnknown(data['diet_types']!, _dietTypesMeta),
      );
    }
    if (data.containsKey('allergens')) {
      context.handle(
        _allergensMeta,
        allergens.isAcceptableOrUnknown(data['allergens']!, _allergensMeta),
      );
    }
    if (data.containsKey('is_built_in')) {
      context.handle(
        _isBuiltInMeta,
        isBuiltIn.isAcceptableOrUnknown(data['is_built_in']!, _isBuiltInMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Recipe map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Recipe(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      )!,
      instructions: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}instructions'],
      )!,
      prepMinutes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}prep_minutes'],
      ),
      servings: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}servings'],
      )!,
      caloriesPerServing: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}calories_per_serving'],
      )!,
      proteinPerServing: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}protein_per_serving'],
      )!,
      fatPerServing: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}fat_per_serving'],
      )!,
      carbsPerServing: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}carbs_per_serving'],
      )!,
      dietTypes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}diet_types'],
      ),
      allergens: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}allergens'],
      ),
      isBuiltIn: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_built_in'],
      )!,
    );
  }

  @override
  $RecipesTable createAlias(String alias) {
    return $RecipesTable(attachedDatabase, alias);
  }
}

class Recipe extends DataClass implements Insertable<Recipe> {
  final int id;
  final String name;
  final String description;
  final String instructions;
  final int? prepMinutes;
  final int servings;
  final double caloriesPerServing;
  final double proteinPerServing;
  final double fatPerServing;
  final double carbsPerServing;
  final String? dietTypes;
  final String? allergens;
  final bool isBuiltIn;
  const Recipe({
    required this.id,
    required this.name,
    required this.description,
    required this.instructions,
    this.prepMinutes,
    required this.servings,
    required this.caloriesPerServing,
    required this.proteinPerServing,
    required this.fatPerServing,
    required this.carbsPerServing,
    this.dietTypes,
    this.allergens,
    required this.isBuiltIn,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['description'] = Variable<String>(description);
    map['instructions'] = Variable<String>(instructions);
    if (!nullToAbsent || prepMinutes != null) {
      map['prep_minutes'] = Variable<int>(prepMinutes);
    }
    map['servings'] = Variable<int>(servings);
    map['calories_per_serving'] = Variable<double>(caloriesPerServing);
    map['protein_per_serving'] = Variable<double>(proteinPerServing);
    map['fat_per_serving'] = Variable<double>(fatPerServing);
    map['carbs_per_serving'] = Variable<double>(carbsPerServing);
    if (!nullToAbsent || dietTypes != null) {
      map['diet_types'] = Variable<String>(dietTypes);
    }
    if (!nullToAbsent || allergens != null) {
      map['allergens'] = Variable<String>(allergens);
    }
    map['is_built_in'] = Variable<bool>(isBuiltIn);
    return map;
  }

  RecipesCompanion toCompanion(bool nullToAbsent) {
    return RecipesCompanion(
      id: Value(id),
      name: Value(name),
      description: Value(description),
      instructions: Value(instructions),
      prepMinutes: prepMinutes == null && nullToAbsent
          ? const Value.absent()
          : Value(prepMinutes),
      servings: Value(servings),
      caloriesPerServing: Value(caloriesPerServing),
      proteinPerServing: Value(proteinPerServing),
      fatPerServing: Value(fatPerServing),
      carbsPerServing: Value(carbsPerServing),
      dietTypes: dietTypes == null && nullToAbsent
          ? const Value.absent()
          : Value(dietTypes),
      allergens: allergens == null && nullToAbsent
          ? const Value.absent()
          : Value(allergens),
      isBuiltIn: Value(isBuiltIn),
    );
  }

  factory Recipe.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Recipe(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      description: serializer.fromJson<String>(json['description']),
      instructions: serializer.fromJson<String>(json['instructions']),
      prepMinutes: serializer.fromJson<int?>(json['prepMinutes']),
      servings: serializer.fromJson<int>(json['servings']),
      caloriesPerServing: serializer.fromJson<double>(
        json['caloriesPerServing'],
      ),
      proteinPerServing: serializer.fromJson<double>(json['proteinPerServing']),
      fatPerServing: serializer.fromJson<double>(json['fatPerServing']),
      carbsPerServing: serializer.fromJson<double>(json['carbsPerServing']),
      dietTypes: serializer.fromJson<String?>(json['dietTypes']),
      allergens: serializer.fromJson<String?>(json['allergens']),
      isBuiltIn: serializer.fromJson<bool>(json['isBuiltIn']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'description': serializer.toJson<String>(description),
      'instructions': serializer.toJson<String>(instructions),
      'prepMinutes': serializer.toJson<int?>(prepMinutes),
      'servings': serializer.toJson<int>(servings),
      'caloriesPerServing': serializer.toJson<double>(caloriesPerServing),
      'proteinPerServing': serializer.toJson<double>(proteinPerServing),
      'fatPerServing': serializer.toJson<double>(fatPerServing),
      'carbsPerServing': serializer.toJson<double>(carbsPerServing),
      'dietTypes': serializer.toJson<String?>(dietTypes),
      'allergens': serializer.toJson<String?>(allergens),
      'isBuiltIn': serializer.toJson<bool>(isBuiltIn),
    };
  }

  Recipe copyWith({
    int? id,
    String? name,
    String? description,
    String? instructions,
    Value<int?> prepMinutes = const Value.absent(),
    int? servings,
    double? caloriesPerServing,
    double? proteinPerServing,
    double? fatPerServing,
    double? carbsPerServing,
    Value<String?> dietTypes = const Value.absent(),
    Value<String?> allergens = const Value.absent(),
    bool? isBuiltIn,
  }) => Recipe(
    id: id ?? this.id,
    name: name ?? this.name,
    description: description ?? this.description,
    instructions: instructions ?? this.instructions,
    prepMinutes: prepMinutes.present ? prepMinutes.value : this.prepMinutes,
    servings: servings ?? this.servings,
    caloriesPerServing: caloriesPerServing ?? this.caloriesPerServing,
    proteinPerServing: proteinPerServing ?? this.proteinPerServing,
    fatPerServing: fatPerServing ?? this.fatPerServing,
    carbsPerServing: carbsPerServing ?? this.carbsPerServing,
    dietTypes: dietTypes.present ? dietTypes.value : this.dietTypes,
    allergens: allergens.present ? allergens.value : this.allergens,
    isBuiltIn: isBuiltIn ?? this.isBuiltIn,
  );
  Recipe copyWithCompanion(RecipesCompanion data) {
    return Recipe(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      description: data.description.present
          ? data.description.value
          : this.description,
      instructions: data.instructions.present
          ? data.instructions.value
          : this.instructions,
      prepMinutes: data.prepMinutes.present
          ? data.prepMinutes.value
          : this.prepMinutes,
      servings: data.servings.present ? data.servings.value : this.servings,
      caloriesPerServing: data.caloriesPerServing.present
          ? data.caloriesPerServing.value
          : this.caloriesPerServing,
      proteinPerServing: data.proteinPerServing.present
          ? data.proteinPerServing.value
          : this.proteinPerServing,
      fatPerServing: data.fatPerServing.present
          ? data.fatPerServing.value
          : this.fatPerServing,
      carbsPerServing: data.carbsPerServing.present
          ? data.carbsPerServing.value
          : this.carbsPerServing,
      dietTypes: data.dietTypes.present ? data.dietTypes.value : this.dietTypes,
      allergens: data.allergens.present ? data.allergens.value : this.allergens,
      isBuiltIn: data.isBuiltIn.present ? data.isBuiltIn.value : this.isBuiltIn,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Recipe(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('instructions: $instructions, ')
          ..write('prepMinutes: $prepMinutes, ')
          ..write('servings: $servings, ')
          ..write('caloriesPerServing: $caloriesPerServing, ')
          ..write('proteinPerServing: $proteinPerServing, ')
          ..write('fatPerServing: $fatPerServing, ')
          ..write('carbsPerServing: $carbsPerServing, ')
          ..write('dietTypes: $dietTypes, ')
          ..write('allergens: $allergens, ')
          ..write('isBuiltIn: $isBuiltIn')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    description,
    instructions,
    prepMinutes,
    servings,
    caloriesPerServing,
    proteinPerServing,
    fatPerServing,
    carbsPerServing,
    dietTypes,
    allergens,
    isBuiltIn,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Recipe &&
          other.id == this.id &&
          other.name == this.name &&
          other.description == this.description &&
          other.instructions == this.instructions &&
          other.prepMinutes == this.prepMinutes &&
          other.servings == this.servings &&
          other.caloriesPerServing == this.caloriesPerServing &&
          other.proteinPerServing == this.proteinPerServing &&
          other.fatPerServing == this.fatPerServing &&
          other.carbsPerServing == this.carbsPerServing &&
          other.dietTypes == this.dietTypes &&
          other.allergens == this.allergens &&
          other.isBuiltIn == this.isBuiltIn);
}

class RecipesCompanion extends UpdateCompanion<Recipe> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> description;
  final Value<String> instructions;
  final Value<int?> prepMinutes;
  final Value<int> servings;
  final Value<double> caloriesPerServing;
  final Value<double> proteinPerServing;
  final Value<double> fatPerServing;
  final Value<double> carbsPerServing;
  final Value<String?> dietTypes;
  final Value<String?> allergens;
  final Value<bool> isBuiltIn;
  const RecipesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.description = const Value.absent(),
    this.instructions = const Value.absent(),
    this.prepMinutes = const Value.absent(),
    this.servings = const Value.absent(),
    this.caloriesPerServing = const Value.absent(),
    this.proteinPerServing = const Value.absent(),
    this.fatPerServing = const Value.absent(),
    this.carbsPerServing = const Value.absent(),
    this.dietTypes = const Value.absent(),
    this.allergens = const Value.absent(),
    this.isBuiltIn = const Value.absent(),
  });
  RecipesCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    this.description = const Value.absent(),
    this.instructions = const Value.absent(),
    this.prepMinutes = const Value.absent(),
    this.servings = const Value.absent(),
    required double caloriesPerServing,
    required double proteinPerServing,
    required double fatPerServing,
    required double carbsPerServing,
    this.dietTypes = const Value.absent(),
    this.allergens = const Value.absent(),
    this.isBuiltIn = const Value.absent(),
  }) : name = Value(name),
       caloriesPerServing = Value(caloriesPerServing),
       proteinPerServing = Value(proteinPerServing),
       fatPerServing = Value(fatPerServing),
       carbsPerServing = Value(carbsPerServing);
  static Insertable<Recipe> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? description,
    Expression<String>? instructions,
    Expression<int>? prepMinutes,
    Expression<int>? servings,
    Expression<double>? caloriesPerServing,
    Expression<double>? proteinPerServing,
    Expression<double>? fatPerServing,
    Expression<double>? carbsPerServing,
    Expression<String>? dietTypes,
    Expression<String>? allergens,
    Expression<bool>? isBuiltIn,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (instructions != null) 'instructions': instructions,
      if (prepMinutes != null) 'prep_minutes': prepMinutes,
      if (servings != null) 'servings': servings,
      if (caloriesPerServing != null)
        'calories_per_serving': caloriesPerServing,
      if (proteinPerServing != null) 'protein_per_serving': proteinPerServing,
      if (fatPerServing != null) 'fat_per_serving': fatPerServing,
      if (carbsPerServing != null) 'carbs_per_serving': carbsPerServing,
      if (dietTypes != null) 'diet_types': dietTypes,
      if (allergens != null) 'allergens': allergens,
      if (isBuiltIn != null) 'is_built_in': isBuiltIn,
    });
  }

  RecipesCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<String>? description,
    Value<String>? instructions,
    Value<int?>? prepMinutes,
    Value<int>? servings,
    Value<double>? caloriesPerServing,
    Value<double>? proteinPerServing,
    Value<double>? fatPerServing,
    Value<double>? carbsPerServing,
    Value<String?>? dietTypes,
    Value<String?>? allergens,
    Value<bool>? isBuiltIn,
  }) {
    return RecipesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      instructions: instructions ?? this.instructions,
      prepMinutes: prepMinutes ?? this.prepMinutes,
      servings: servings ?? this.servings,
      caloriesPerServing: caloriesPerServing ?? this.caloriesPerServing,
      proteinPerServing: proteinPerServing ?? this.proteinPerServing,
      fatPerServing: fatPerServing ?? this.fatPerServing,
      carbsPerServing: carbsPerServing ?? this.carbsPerServing,
      dietTypes: dietTypes ?? this.dietTypes,
      allergens: allergens ?? this.allergens,
      isBuiltIn: isBuiltIn ?? this.isBuiltIn,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (instructions.present) {
      map['instructions'] = Variable<String>(instructions.value);
    }
    if (prepMinutes.present) {
      map['prep_minutes'] = Variable<int>(prepMinutes.value);
    }
    if (servings.present) {
      map['servings'] = Variable<int>(servings.value);
    }
    if (caloriesPerServing.present) {
      map['calories_per_serving'] = Variable<double>(caloriesPerServing.value);
    }
    if (proteinPerServing.present) {
      map['protein_per_serving'] = Variable<double>(proteinPerServing.value);
    }
    if (fatPerServing.present) {
      map['fat_per_serving'] = Variable<double>(fatPerServing.value);
    }
    if (carbsPerServing.present) {
      map['carbs_per_serving'] = Variable<double>(carbsPerServing.value);
    }
    if (dietTypes.present) {
      map['diet_types'] = Variable<String>(dietTypes.value);
    }
    if (allergens.present) {
      map['allergens'] = Variable<String>(allergens.value);
    }
    if (isBuiltIn.present) {
      map['is_built_in'] = Variable<bool>(isBuiltIn.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RecipesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('instructions: $instructions, ')
          ..write('prepMinutes: $prepMinutes, ')
          ..write('servings: $servings, ')
          ..write('caloriesPerServing: $caloriesPerServing, ')
          ..write('proteinPerServing: $proteinPerServing, ')
          ..write('fatPerServing: $fatPerServing, ')
          ..write('carbsPerServing: $carbsPerServing, ')
          ..write('dietTypes: $dietTypes, ')
          ..write('allergens: $allergens, ')
          ..write('isBuiltIn: $isBuiltIn')
          ..write(')'))
        .toString();
  }
}

class $RecipeIngredientsTable extends RecipeIngredients
    with TableInfo<$RecipeIngredientsTable, RecipeIngredient> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RecipeIngredientsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _recipeIdMeta = const VerificationMeta(
    'recipeId',
  );
  @override
  late final GeneratedColumn<int> recipeId = GeneratedColumn<int>(
    'recipe_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<double> amount = GeneratedColumn<double>(
    'amount',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _unitMeta = const VerificationMeta('unit');
  @override
  late final GeneratedColumn<String> unit = GeneratedColumn<String>(
    'unit',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _weightGramsMeta = const VerificationMeta(
    'weightGrams',
  );
  @override
  late final GeneratedColumn<double> weightGrams = GeneratedColumn<double>(
    'weight_grams',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _caloriesPer100gMeta = const VerificationMeta(
    'caloriesPer100g',
  );
  @override
  late final GeneratedColumn<double> caloriesPer100g = GeneratedColumn<double>(
    'calories_per100g',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _proteinPer100gMeta = const VerificationMeta(
    'proteinPer100g',
  );
  @override
  late final GeneratedColumn<double> proteinPer100g = GeneratedColumn<double>(
    'protein_per100g',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _fatPer100gMeta = const VerificationMeta(
    'fatPer100g',
  );
  @override
  late final GeneratedColumn<double> fatPer100g = GeneratedColumn<double>(
    'fat_per100g',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _carbsPer100gMeta = const VerificationMeta(
    'carbsPer100g',
  );
  @override
  late final GeneratedColumn<double> carbsPer100g = GeneratedColumn<double>(
    'carbs_per100g',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    recipeId,
    name,
    amount,
    unit,
    weightGrams,
    caloriesPer100g,
    proteinPer100g,
    fatPer100g,
    carbsPer100g,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'recipe_ingredients';
  @override
  VerificationContext validateIntegrity(
    Insertable<RecipeIngredient> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('recipe_id')) {
      context.handle(
        _recipeIdMeta,
        recipeId.isAcceptableOrUnknown(data['recipe_id']!, _recipeIdMeta),
      );
    } else if (isInserting) {
      context.missing(_recipeIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('amount')) {
      context.handle(
        _amountMeta,
        amount.isAcceptableOrUnknown(data['amount']!, _amountMeta),
      );
    } else if (isInserting) {
      context.missing(_amountMeta);
    }
    if (data.containsKey('unit')) {
      context.handle(
        _unitMeta,
        unit.isAcceptableOrUnknown(data['unit']!, _unitMeta),
      );
    } else if (isInserting) {
      context.missing(_unitMeta);
    }
    if (data.containsKey('weight_grams')) {
      context.handle(
        _weightGramsMeta,
        weightGrams.isAcceptableOrUnknown(
          data['weight_grams']!,
          _weightGramsMeta,
        ),
      );
    }
    if (data.containsKey('calories_per100g')) {
      context.handle(
        _caloriesPer100gMeta,
        caloriesPer100g.isAcceptableOrUnknown(
          data['calories_per100g']!,
          _caloriesPer100gMeta,
        ),
      );
    }
    if (data.containsKey('protein_per100g')) {
      context.handle(
        _proteinPer100gMeta,
        proteinPer100g.isAcceptableOrUnknown(
          data['protein_per100g']!,
          _proteinPer100gMeta,
        ),
      );
    }
    if (data.containsKey('fat_per100g')) {
      context.handle(
        _fatPer100gMeta,
        fatPer100g.isAcceptableOrUnknown(data['fat_per100g']!, _fatPer100gMeta),
      );
    }
    if (data.containsKey('carbs_per100g')) {
      context.handle(
        _carbsPer100gMeta,
        carbsPer100g.isAcceptableOrUnknown(
          data['carbs_per100g']!,
          _carbsPer100gMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  RecipeIngredient map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return RecipeIngredient(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      recipeId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}recipe_id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      amount: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}amount'],
      )!,
      unit: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}unit'],
      )!,
      weightGrams: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}weight_grams'],
      ),
      caloriesPer100g: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}calories_per100g'],
      ),
      proteinPer100g: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}protein_per100g'],
      ),
      fatPer100g: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}fat_per100g'],
      ),
      carbsPer100g: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}carbs_per100g'],
      ),
    );
  }

  @override
  $RecipeIngredientsTable createAlias(String alias) {
    return $RecipeIngredientsTable(attachedDatabase, alias);
  }
}

class RecipeIngredient extends DataClass
    implements Insertable<RecipeIngredient> {
  final int id;
  final int recipeId;
  final String name;
  final double amount;
  final String unit;
  final double? weightGrams;
  final double? caloriesPer100g;
  final double? proteinPer100g;
  final double? fatPer100g;
  final double? carbsPer100g;
  const RecipeIngredient({
    required this.id,
    required this.recipeId,
    required this.name,
    required this.amount,
    required this.unit,
    this.weightGrams,
    this.caloriesPer100g,
    this.proteinPer100g,
    this.fatPer100g,
    this.carbsPer100g,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['recipe_id'] = Variable<int>(recipeId);
    map['name'] = Variable<String>(name);
    map['amount'] = Variable<double>(amount);
    map['unit'] = Variable<String>(unit);
    if (!nullToAbsent || weightGrams != null) {
      map['weight_grams'] = Variable<double>(weightGrams);
    }
    if (!nullToAbsent || caloriesPer100g != null) {
      map['calories_per100g'] = Variable<double>(caloriesPer100g);
    }
    if (!nullToAbsent || proteinPer100g != null) {
      map['protein_per100g'] = Variable<double>(proteinPer100g);
    }
    if (!nullToAbsent || fatPer100g != null) {
      map['fat_per100g'] = Variable<double>(fatPer100g);
    }
    if (!nullToAbsent || carbsPer100g != null) {
      map['carbs_per100g'] = Variable<double>(carbsPer100g);
    }
    return map;
  }

  RecipeIngredientsCompanion toCompanion(bool nullToAbsent) {
    return RecipeIngredientsCompanion(
      id: Value(id),
      recipeId: Value(recipeId),
      name: Value(name),
      amount: Value(amount),
      unit: Value(unit),
      weightGrams: weightGrams == null && nullToAbsent
          ? const Value.absent()
          : Value(weightGrams),
      caloriesPer100g: caloriesPer100g == null && nullToAbsent
          ? const Value.absent()
          : Value(caloriesPer100g),
      proteinPer100g: proteinPer100g == null && nullToAbsent
          ? const Value.absent()
          : Value(proteinPer100g),
      fatPer100g: fatPer100g == null && nullToAbsent
          ? const Value.absent()
          : Value(fatPer100g),
      carbsPer100g: carbsPer100g == null && nullToAbsent
          ? const Value.absent()
          : Value(carbsPer100g),
    );
  }

  factory RecipeIngredient.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RecipeIngredient(
      id: serializer.fromJson<int>(json['id']),
      recipeId: serializer.fromJson<int>(json['recipeId']),
      name: serializer.fromJson<String>(json['name']),
      amount: serializer.fromJson<double>(json['amount']),
      unit: serializer.fromJson<String>(json['unit']),
      weightGrams: serializer.fromJson<double?>(json['weightGrams']),
      caloriesPer100g: serializer.fromJson<double?>(json['caloriesPer100g']),
      proteinPer100g: serializer.fromJson<double?>(json['proteinPer100g']),
      fatPer100g: serializer.fromJson<double?>(json['fatPer100g']),
      carbsPer100g: serializer.fromJson<double?>(json['carbsPer100g']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'recipeId': serializer.toJson<int>(recipeId),
      'name': serializer.toJson<String>(name),
      'amount': serializer.toJson<double>(amount),
      'unit': serializer.toJson<String>(unit),
      'weightGrams': serializer.toJson<double?>(weightGrams),
      'caloriesPer100g': serializer.toJson<double?>(caloriesPer100g),
      'proteinPer100g': serializer.toJson<double?>(proteinPer100g),
      'fatPer100g': serializer.toJson<double?>(fatPer100g),
      'carbsPer100g': serializer.toJson<double?>(carbsPer100g),
    };
  }

  RecipeIngredient copyWith({
    int? id,
    int? recipeId,
    String? name,
    double? amount,
    String? unit,
    Value<double?> weightGrams = const Value.absent(),
    Value<double?> caloriesPer100g = const Value.absent(),
    Value<double?> proteinPer100g = const Value.absent(),
    Value<double?> fatPer100g = const Value.absent(),
    Value<double?> carbsPer100g = const Value.absent(),
  }) => RecipeIngredient(
    id: id ?? this.id,
    recipeId: recipeId ?? this.recipeId,
    name: name ?? this.name,
    amount: amount ?? this.amount,
    unit: unit ?? this.unit,
    weightGrams: weightGrams.present ? weightGrams.value : this.weightGrams,
    caloriesPer100g: caloriesPer100g.present
        ? caloriesPer100g.value
        : this.caloriesPer100g,
    proteinPer100g: proteinPer100g.present
        ? proteinPer100g.value
        : this.proteinPer100g,
    fatPer100g: fatPer100g.present ? fatPer100g.value : this.fatPer100g,
    carbsPer100g: carbsPer100g.present ? carbsPer100g.value : this.carbsPer100g,
  );
  RecipeIngredient copyWithCompanion(RecipeIngredientsCompanion data) {
    return RecipeIngredient(
      id: data.id.present ? data.id.value : this.id,
      recipeId: data.recipeId.present ? data.recipeId.value : this.recipeId,
      name: data.name.present ? data.name.value : this.name,
      amount: data.amount.present ? data.amount.value : this.amount,
      unit: data.unit.present ? data.unit.value : this.unit,
      weightGrams: data.weightGrams.present
          ? data.weightGrams.value
          : this.weightGrams,
      caloriesPer100g: data.caloriesPer100g.present
          ? data.caloriesPer100g.value
          : this.caloriesPer100g,
      proteinPer100g: data.proteinPer100g.present
          ? data.proteinPer100g.value
          : this.proteinPer100g,
      fatPer100g: data.fatPer100g.present
          ? data.fatPer100g.value
          : this.fatPer100g,
      carbsPer100g: data.carbsPer100g.present
          ? data.carbsPer100g.value
          : this.carbsPer100g,
    );
  }

  @override
  String toString() {
    return (StringBuffer('RecipeIngredient(')
          ..write('id: $id, ')
          ..write('recipeId: $recipeId, ')
          ..write('name: $name, ')
          ..write('amount: $amount, ')
          ..write('unit: $unit, ')
          ..write('weightGrams: $weightGrams, ')
          ..write('caloriesPer100g: $caloriesPer100g, ')
          ..write('proteinPer100g: $proteinPer100g, ')
          ..write('fatPer100g: $fatPer100g, ')
          ..write('carbsPer100g: $carbsPer100g')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    recipeId,
    name,
    amount,
    unit,
    weightGrams,
    caloriesPer100g,
    proteinPer100g,
    fatPer100g,
    carbsPer100g,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RecipeIngredient &&
          other.id == this.id &&
          other.recipeId == this.recipeId &&
          other.name == this.name &&
          other.amount == this.amount &&
          other.unit == this.unit &&
          other.weightGrams == this.weightGrams &&
          other.caloriesPer100g == this.caloriesPer100g &&
          other.proteinPer100g == this.proteinPer100g &&
          other.fatPer100g == this.fatPer100g &&
          other.carbsPer100g == this.carbsPer100g);
}

class RecipeIngredientsCompanion extends UpdateCompanion<RecipeIngredient> {
  final Value<int> id;
  final Value<int> recipeId;
  final Value<String> name;
  final Value<double> amount;
  final Value<String> unit;
  final Value<double?> weightGrams;
  final Value<double?> caloriesPer100g;
  final Value<double?> proteinPer100g;
  final Value<double?> fatPer100g;
  final Value<double?> carbsPer100g;
  const RecipeIngredientsCompanion({
    this.id = const Value.absent(),
    this.recipeId = const Value.absent(),
    this.name = const Value.absent(),
    this.amount = const Value.absent(),
    this.unit = const Value.absent(),
    this.weightGrams = const Value.absent(),
    this.caloriesPer100g = const Value.absent(),
    this.proteinPer100g = const Value.absent(),
    this.fatPer100g = const Value.absent(),
    this.carbsPer100g = const Value.absent(),
  });
  RecipeIngredientsCompanion.insert({
    this.id = const Value.absent(),
    required int recipeId,
    required String name,
    required double amount,
    required String unit,
    this.weightGrams = const Value.absent(),
    this.caloriesPer100g = const Value.absent(),
    this.proteinPer100g = const Value.absent(),
    this.fatPer100g = const Value.absent(),
    this.carbsPer100g = const Value.absent(),
  }) : recipeId = Value(recipeId),
       name = Value(name),
       amount = Value(amount),
       unit = Value(unit);
  static Insertable<RecipeIngredient> custom({
    Expression<int>? id,
    Expression<int>? recipeId,
    Expression<String>? name,
    Expression<double>? amount,
    Expression<String>? unit,
    Expression<double>? weightGrams,
    Expression<double>? caloriesPer100g,
    Expression<double>? proteinPer100g,
    Expression<double>? fatPer100g,
    Expression<double>? carbsPer100g,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (recipeId != null) 'recipe_id': recipeId,
      if (name != null) 'name': name,
      if (amount != null) 'amount': amount,
      if (unit != null) 'unit': unit,
      if (weightGrams != null) 'weight_grams': weightGrams,
      if (caloriesPer100g != null) 'calories_per100g': caloriesPer100g,
      if (proteinPer100g != null) 'protein_per100g': proteinPer100g,
      if (fatPer100g != null) 'fat_per100g': fatPer100g,
      if (carbsPer100g != null) 'carbs_per100g': carbsPer100g,
    });
  }

  RecipeIngredientsCompanion copyWith({
    Value<int>? id,
    Value<int>? recipeId,
    Value<String>? name,
    Value<double>? amount,
    Value<String>? unit,
    Value<double?>? weightGrams,
    Value<double?>? caloriesPer100g,
    Value<double?>? proteinPer100g,
    Value<double?>? fatPer100g,
    Value<double?>? carbsPer100g,
  }) {
    return RecipeIngredientsCompanion(
      id: id ?? this.id,
      recipeId: recipeId ?? this.recipeId,
      name: name ?? this.name,
      amount: amount ?? this.amount,
      unit: unit ?? this.unit,
      weightGrams: weightGrams ?? this.weightGrams,
      caloriesPer100g: caloriesPer100g ?? this.caloriesPer100g,
      proteinPer100g: proteinPer100g ?? this.proteinPer100g,
      fatPer100g: fatPer100g ?? this.fatPer100g,
      carbsPer100g: carbsPer100g ?? this.carbsPer100g,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (recipeId.present) {
      map['recipe_id'] = Variable<int>(recipeId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (amount.present) {
      map['amount'] = Variable<double>(amount.value);
    }
    if (unit.present) {
      map['unit'] = Variable<String>(unit.value);
    }
    if (weightGrams.present) {
      map['weight_grams'] = Variable<double>(weightGrams.value);
    }
    if (caloriesPer100g.present) {
      map['calories_per100g'] = Variable<double>(caloriesPer100g.value);
    }
    if (proteinPer100g.present) {
      map['protein_per100g'] = Variable<double>(proteinPer100g.value);
    }
    if (fatPer100g.present) {
      map['fat_per100g'] = Variable<double>(fatPer100g.value);
    }
    if (carbsPer100g.present) {
      map['carbs_per100g'] = Variable<double>(carbsPer100g.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RecipeIngredientsCompanion(')
          ..write('id: $id, ')
          ..write('recipeId: $recipeId, ')
          ..write('name: $name, ')
          ..write('amount: $amount, ')
          ..write('unit: $unit, ')
          ..write('weightGrams: $weightGrams, ')
          ..write('caloriesPer100g: $caloriesPer100g, ')
          ..write('proteinPer100g: $proteinPer100g, ')
          ..write('fatPer100g: $fatPer100g, ')
          ..write('carbsPer100g: $carbsPer100g')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $FamiliesTable families = $FamiliesTable(this);
  late final $FamilyMembersTable familyMembers = $FamilyMembersTable(this);
  late final $PantryProductsTable pantryProducts = $PantryProductsTable(this);
  late final $FoodProductsTable foodProducts = $FoodProductsTable(this);
  late final $FoodProductAliasesTable foodProductAliases =
      $FoodProductAliasesTable(this);
  late final $UnknownFoodProductsTable unknownFoodProducts =
      $UnknownFoodProductsTable(this);
  late final $RecipesTable recipes = $RecipesTable(this);
  late final $RecipeIngredientsTable recipeIngredients =
      $RecipeIngredientsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    families,
    familyMembers,
    pantryProducts,
    foodProducts,
    foodProductAliases,
    unknownFoodProducts,
    recipes,
    recipeIngredients,
  ];
}

typedef $$FamiliesTableCreateCompanionBuilder = FamiliesCompanion Function({
  Value<int> id,
  required String name,
  required DateTime createdAt,
});
typedef $$FamiliesTableUpdateCompanionBuilder = FamiliesCompanion Function({
  Value<int> id,
  Value<String> name,
  Value<DateTime> createdAt,
});

class $$FamiliesTableFilterComposer
    extends Composer<_$AppDatabase, $FamiliesTable> {
  $$FamiliesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$FamiliesTableOrderingComposer
    extends Composer<_$AppDatabase, $FamiliesTable> {
  $$FamiliesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$FamiliesTableAnnotationComposer
    extends Composer<_$AppDatabase, $FamiliesTable> {
  $$FamiliesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$FamiliesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $FamiliesTable,
          Family,
          $$FamiliesTableFilterComposer,
          $$FamiliesTableOrderingComposer,
          $$FamiliesTableAnnotationComposer,
          $$FamiliesTableCreateCompanionBuilder,
          $$FamiliesTableUpdateCompanionBuilder,
          (Family, BaseReferences<_$AppDatabase, $FamiliesTable, Family>),
          Family,
          PrefetchHooks Function()
        > {
  $$FamiliesTableTableManager(_$AppDatabase db, $FamiliesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$FamiliesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$FamiliesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$FamiliesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
          }) => FamiliesCompanion(id: id, name: name, createdAt: createdAt),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                required DateTime createdAt,
              }) => FamiliesCompanion.insert(
                id: id,
                name: name,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$FamiliesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $FamiliesTable,
      Family,
      $$FamiliesTableFilterComposer,
      $$FamiliesTableOrderingComposer,
      $$FamiliesTableAnnotationComposer,
      $$FamiliesTableCreateCompanionBuilder,
      $$FamiliesTableUpdateCompanionBuilder,
      (Family, BaseReferences<_$AppDatabase, $FamiliesTable, Family>),
      Family,
      PrefetchHooks Function()
    >;
typedef $$FamilyMembersTableCreateCompanionBuilder =
    FamilyMembersCompanion Function({
      Value<int> id,
      required int familyId,
      required String name,
      Value<DateTime?> birthDate,
      Value<String?> gender,
      Value<double?> heightCm,
      Value<double?> weightKg,
      Value<String?> goal,
      Value<String?> activity,
      Value<String?> dietType,
      Value<String?> allergies,
      Value<String?> intolerances,
      Value<String?> dislikedFoods,
      Value<String?> likedFoods,
      Value<String?> preferences,
    });
typedef $$FamilyMembersTableUpdateCompanionBuilder =
    FamilyMembersCompanion Function({
      Value<int> id,
      Value<int> familyId,
      Value<String> name,
      Value<DateTime?> birthDate,
      Value<String?> gender,
      Value<double?> heightCm,
      Value<double?> weightKg,
      Value<String?> goal,
      Value<String?> activity,
      Value<String?> dietType,
      Value<String?> allergies,
      Value<String?> intolerances,
      Value<String?> dislikedFoods,
      Value<String?> likedFoods,
      Value<String?> preferences,
    });

class $$FamilyMembersTableFilterComposer
    extends Composer<_$AppDatabase, $FamilyMembersTable> {
  $$FamilyMembersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get familyId => $composableBuilder(
    column: $table.familyId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get birthDate => $composableBuilder(
    column: $table.birthDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get gender => $composableBuilder(
    column: $table.gender,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get heightCm => $composableBuilder(
    column: $table.heightCm,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get weightKg => $composableBuilder(
    column: $table.weightKg,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get goal => $composableBuilder(
    column: $table.goal,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get activity => $composableBuilder(
    column: $table.activity,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get dietType => $composableBuilder(
    column: $table.dietType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get allergies => $composableBuilder(
    column: $table.allergies,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get intolerances => $composableBuilder(
    column: $table.intolerances,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get dislikedFoods => $composableBuilder(
    column: $table.dislikedFoods,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get likedFoods => $composableBuilder(
    column: $table.likedFoods,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get preferences => $composableBuilder(
    column: $table.preferences,
    builder: (column) => ColumnFilters(column),
  );
}

class $$FamilyMembersTableOrderingComposer
    extends Composer<_$AppDatabase, $FamilyMembersTable> {
  $$FamilyMembersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get familyId => $composableBuilder(
    column: $table.familyId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get birthDate => $composableBuilder(
    column: $table.birthDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get gender => $composableBuilder(
    column: $table.gender,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get heightCm => $composableBuilder(
    column: $table.heightCm,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get weightKg => $composableBuilder(
    column: $table.weightKg,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get goal => $composableBuilder(
    column: $table.goal,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get activity => $composableBuilder(
    column: $table.activity,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get dietType => $composableBuilder(
    column: $table.dietType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get allergies => $composableBuilder(
    column: $table.allergies,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get intolerances => $composableBuilder(
    column: $table.intolerances,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get dislikedFoods => $composableBuilder(
    column: $table.dislikedFoods,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get likedFoods => $composableBuilder(
    column: $table.likedFoods,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get preferences => $composableBuilder(
    column: $table.preferences,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$FamilyMembersTableAnnotationComposer
    extends Composer<_$AppDatabase, $FamilyMembersTable> {
  $$FamilyMembersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get familyId =>
      $composableBuilder(column: $table.familyId, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<DateTime> get birthDate =>
      $composableBuilder(column: $table.birthDate, builder: (column) => column);

  GeneratedColumn<String> get gender =>
      $composableBuilder(column: $table.gender, builder: (column) => column);

  GeneratedColumn<double> get heightCm =>
      $composableBuilder(column: $table.heightCm, builder: (column) => column);

  GeneratedColumn<double> get weightKg =>
      $composableBuilder(column: $table.weightKg, builder: (column) => column);

  GeneratedColumn<String> get goal =>
      $composableBuilder(column: $table.goal, builder: (column) => column);

  GeneratedColumn<String> get activity =>
      $composableBuilder(column: $table.activity, builder: (column) => column);

  GeneratedColumn<String> get dietType =>
      $composableBuilder(column: $table.dietType, builder: (column) => column);

  GeneratedColumn<String> get allergies =>
      $composableBuilder(column: $table.allergies, builder: (column) => column);

  GeneratedColumn<String> get intolerances => $composableBuilder(
    column: $table.intolerances,
    builder: (column) => column,
  );

  GeneratedColumn<String> get dislikedFoods => $composableBuilder(
    column: $table.dislikedFoods,
    builder: (column) => column,
  );

  GeneratedColumn<String> get likedFoods => $composableBuilder(
    column: $table.likedFoods,
    builder: (column) => column,
  );

  GeneratedColumn<String> get preferences => $composableBuilder(
    column: $table.preferences,
    builder: (column) => column,
  );
}

class $$FamilyMembersTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $FamilyMembersTable,
          FamilyMember,
          $$FamilyMembersTableFilterComposer,
          $$FamilyMembersTableOrderingComposer,
          $$FamilyMembersTableAnnotationComposer,
          $$FamilyMembersTableCreateCompanionBuilder,
          $$FamilyMembersTableUpdateCompanionBuilder,
          (
            FamilyMember,
            BaseReferences<_$AppDatabase, $FamilyMembersTable, FamilyMember>,
          ),
          FamilyMember,
          PrefetchHooks Function()
        > {
  $$FamilyMembersTableTableManager(_$AppDatabase db, $FamilyMembersTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$FamilyMembersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$FamilyMembersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$FamilyMembersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> familyId = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<DateTime?> birthDate = const Value.absent(),
                Value<String?> gender = const Value.absent(),
                Value<double?> heightCm = const Value.absent(),
                Value<double?> weightKg = const Value.absent(),
                Value<String?> goal = const Value.absent(),
                Value<String?> activity = const Value.absent(),
                Value<String?> dietType = const Value.absent(),
                Value<String?> allergies = const Value.absent(),
                Value<String?> intolerances = const Value.absent(),
                Value<String?> dislikedFoods = const Value.absent(),
                Value<String?> likedFoods = const Value.absent(),
                Value<String?> preferences = const Value.absent(),
              }) => FamilyMembersCompanion(
                id: id,
                familyId: familyId,
                name: name,
                birthDate: birthDate,
                gender: gender,
                heightCm: heightCm,
                weightKg: weightKg,
                goal: goal,
                activity: activity,
                dietType: dietType,
                allergies: allergies,
                intolerances: intolerances,
                dislikedFoods: dislikedFoods,
                likedFoods: likedFoods,
                preferences: preferences,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int familyId,
                required String name,
                Value<DateTime?> birthDate = const Value.absent(),
                Value<String?> gender = const Value.absent(),
                Value<double?> heightCm = const Value.absent(),
                Value<double?> weightKg = const Value.absent(),
                Value<String?> goal = const Value.absent(),
                Value<String?> activity = const Value.absent(),
                Value<String?> dietType = const Value.absent(),
                Value<String?> allergies = const Value.absent(),
                Value<String?> intolerances = const Value.absent(),
                Value<String?> dislikedFoods = const Value.absent(),
                Value<String?> likedFoods = const Value.absent(),
                Value<String?> preferences = const Value.absent(),
              }) => FamilyMembersCompanion.insert(
                id: id,
                familyId: familyId,
                name: name,
                birthDate: birthDate,
                gender: gender,
                heightCm: heightCm,
                weightKg: weightKg,
                goal: goal,
                activity: activity,
                dietType: dietType,
                allergies: allergies,
                intolerances: intolerances,
                dislikedFoods: dislikedFoods,
                likedFoods: likedFoods,
                preferences: preferences,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$FamilyMembersTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $FamilyMembersTable,
      FamilyMember,
      $$FamilyMembersTableFilterComposer,
      $$FamilyMembersTableOrderingComposer,
      $$FamilyMembersTableAnnotationComposer,
      $$FamilyMembersTableCreateCompanionBuilder,
      $$FamilyMembersTableUpdateCompanionBuilder,
      (
        FamilyMember,
        BaseReferences<_$AppDatabase, $FamilyMembersTable, FamilyMember>,
      ),
      FamilyMember,
      PrefetchHooks Function()
    >;
typedef $$PantryProductsTableCreateCompanionBuilder =
    PantryProductsCompanion Function({
      Value<int> id,
      required int familyId,
      required String name,
      required String amount,
      required String unit,
      Value<double?> weightGrams,
      Value<DateTime?> expirationDate,
    });
typedef $$PantryProductsTableUpdateCompanionBuilder =
    PantryProductsCompanion Function({
      Value<int> id,
      Value<int> familyId,
      Value<String> name,
      Value<String> amount,
      Value<String> unit,
      Value<double?> weightGrams,
      Value<DateTime?> expirationDate,
    });

class $$PantryProductsTableFilterComposer
    extends Composer<_$AppDatabase, $PantryProductsTable> {
  $$PantryProductsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get familyId => $composableBuilder(
    column: $table.familyId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get unit => $composableBuilder(
    column: $table.unit,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get weightGrams => $composableBuilder(
    column: $table.weightGrams,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get expirationDate => $composableBuilder(
    column: $table.expirationDate,
    builder: (column) => ColumnFilters(column),
  );
}

class $$PantryProductsTableOrderingComposer
    extends Composer<_$AppDatabase, $PantryProductsTable> {
  $$PantryProductsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get familyId => $composableBuilder(
    column: $table.familyId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get unit => $composableBuilder(
    column: $table.unit,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get weightGrams => $composableBuilder(
    column: $table.weightGrams,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get expirationDate => $composableBuilder(
    column: $table.expirationDate,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$PantryProductsTableAnnotationComposer
    extends Composer<_$AppDatabase, $PantryProductsTable> {
  $$PantryProductsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get familyId =>
      $composableBuilder(column: $table.familyId, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get amount =>
      $composableBuilder(column: $table.amount, builder: (column) => column);

  GeneratedColumn<String> get unit =>
      $composableBuilder(column: $table.unit, builder: (column) => column);

  GeneratedColumn<double> get weightGrams => $composableBuilder(
    column: $table.weightGrams,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get expirationDate => $composableBuilder(
    column: $table.expirationDate,
    builder: (column) => column,
  );
}

class $$PantryProductsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PantryProductsTable,
          PantryProduct,
          $$PantryProductsTableFilterComposer,
          $$PantryProductsTableOrderingComposer,
          $$PantryProductsTableAnnotationComposer,
          $$PantryProductsTableCreateCompanionBuilder,
          $$PantryProductsTableUpdateCompanionBuilder,
          (
            PantryProduct,
            BaseReferences<_$AppDatabase, $PantryProductsTable, PantryProduct>,
          ),
          PantryProduct,
          PrefetchHooks Function()
        > {
  $$PantryProductsTableTableManager(
    _$AppDatabase db,
    $PantryProductsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PantryProductsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PantryProductsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PantryProductsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> familyId = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> amount = const Value.absent(),
                Value<String> unit = const Value.absent(),
                Value<double?> weightGrams = const Value.absent(),
                Value<DateTime?> expirationDate = const Value.absent(),
              }) => PantryProductsCompanion(
                id: id,
                familyId: familyId,
                name: name,
                amount: amount,
                unit: unit,
                weightGrams: weightGrams,
                expirationDate: expirationDate,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int familyId,
                required String name,
                required String amount,
                required String unit,
                Value<double?> weightGrams = const Value.absent(),
                Value<DateTime?> expirationDate = const Value.absent(),
              }) => PantryProductsCompanion.insert(
                id: id,
                familyId: familyId,
                name: name,
                amount: amount,
                unit: unit,
                weightGrams: weightGrams,
                expirationDate: expirationDate,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$PantryProductsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PantryProductsTable,
      PantryProduct,
      $$PantryProductsTableFilterComposer,
      $$PantryProductsTableOrderingComposer,
      $$PantryProductsTableAnnotationComposer,
      $$PantryProductsTableCreateCompanionBuilder,
      $$PantryProductsTableUpdateCompanionBuilder,
      (
        PantryProduct,
        BaseReferences<_$AppDatabase, $PantryProductsTable, PantryProduct>,
      ),
      PantryProduct,
      PrefetchHooks Function()
    >;
typedef $$FoodProductsTableCreateCompanionBuilder =
    FoodProductsCompanion Function({
      Value<int> id,
      required String name,
      required String state,
      Value<String> category,
      Value<String> source,
      Value<String?> sourceId,
      required double caloriesPer100g,
      required double proteinPer100g,
      required double fatPer100g,
      required double carbsPer100g,
      Value<double?> gramsPerMl,
    });
typedef $$FoodProductsTableUpdateCompanionBuilder =
    FoodProductsCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<String> state,
      Value<String> category,
      Value<String> source,
      Value<String?> sourceId,
      Value<double> caloriesPer100g,
      Value<double> proteinPer100g,
      Value<double> fatPer100g,
      Value<double> carbsPer100g,
      Value<double?> gramsPerMl,
    });

class $$FoodProductsTableFilterComposer
    extends Composer<_$AppDatabase, $FoodProductsTable> {
  $$FoodProductsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get state => $composableBuilder(
    column: $table.state,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get source => $composableBuilder(
    column: $table.source,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get sourceId => $composableBuilder(
    column: $table.sourceId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get caloriesPer100g => $composableBuilder(
    column: $table.caloriesPer100g,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get proteinPer100g => $composableBuilder(
    column: $table.proteinPer100g,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get fatPer100g => $composableBuilder(
    column: $table.fatPer100g,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get carbsPer100g => $composableBuilder(
    column: $table.carbsPer100g,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get gramsPerMl => $composableBuilder(
    column: $table.gramsPerMl,
    builder: (column) => ColumnFilters(column),
  );
}

class $$FoodProductsTableOrderingComposer
    extends Composer<_$AppDatabase, $FoodProductsTable> {
  $$FoodProductsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get state => $composableBuilder(
    column: $table.state,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get source => $composableBuilder(
    column: $table.source,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sourceId => $composableBuilder(
    column: $table.sourceId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get caloriesPer100g => $composableBuilder(
    column: $table.caloriesPer100g,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get proteinPer100g => $composableBuilder(
    column: $table.proteinPer100g,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get fatPer100g => $composableBuilder(
    column: $table.fatPer100g,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get carbsPer100g => $composableBuilder(
    column: $table.carbsPer100g,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get gramsPerMl => $composableBuilder(
    column: $table.gramsPerMl,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$FoodProductsTableAnnotationComposer
    extends Composer<_$AppDatabase, $FoodProductsTable> {
  $$FoodProductsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get state =>
      $composableBuilder(column: $table.state, builder: (column) => column);

  GeneratedColumn<String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  GeneratedColumn<String> get source =>
      $composableBuilder(column: $table.source, builder: (column) => column);

  GeneratedColumn<String> get sourceId =>
      $composableBuilder(column: $table.sourceId, builder: (column) => column);

  GeneratedColumn<double> get caloriesPer100g => $composableBuilder(
    column: $table.caloriesPer100g,
    builder: (column) => column,
  );

  GeneratedColumn<double> get proteinPer100g => $composableBuilder(
    column: $table.proteinPer100g,
    builder: (column) => column,
  );

  GeneratedColumn<double> get fatPer100g => $composableBuilder(
    column: $table.fatPer100g,
    builder: (column) => column,
  );

  GeneratedColumn<double> get carbsPer100g => $composableBuilder(
    column: $table.carbsPer100g,
    builder: (column) => column,
  );

  GeneratedColumn<double> get gramsPerMl => $composableBuilder(
    column: $table.gramsPerMl,
    builder: (column) => column,
  );
}

class $$FoodProductsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $FoodProductsTable,
          FoodProduct,
          $$FoodProductsTableFilterComposer,
          $$FoodProductsTableOrderingComposer,
          $$FoodProductsTableAnnotationComposer,
          $$FoodProductsTableCreateCompanionBuilder,
          $$FoodProductsTableUpdateCompanionBuilder,
          (
            FoodProduct,
            BaseReferences<_$AppDatabase, $FoodProductsTable, FoodProduct>,
          ),
          FoodProduct,
          PrefetchHooks Function()
        > {
  $$FoodProductsTableTableManager(_$AppDatabase db, $FoodProductsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$FoodProductsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$FoodProductsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$FoodProductsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> state = const Value.absent(),
                Value<String> category = const Value.absent(),
                Value<String> source = const Value.absent(),
                Value<String?> sourceId = const Value.absent(),
                Value<double> caloriesPer100g = const Value.absent(),
                Value<double> proteinPer100g = const Value.absent(),
                Value<double> fatPer100g = const Value.absent(),
                Value<double> carbsPer100g = const Value.absent(),
                Value<double?> gramsPerMl = const Value.absent(),
              }) => FoodProductsCompanion(
                id: id,
                name: name,
                state: state,
                category: category,
                source: source,
                sourceId: sourceId,
                caloriesPer100g: caloriesPer100g,
                proteinPer100g: proteinPer100g,
                fatPer100g: fatPer100g,
                carbsPer100g: carbsPer100g,
                gramsPerMl: gramsPerMl,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                required String state,
                Value<String> category = const Value.absent(),
                Value<String> source = const Value.absent(),
                Value<String?> sourceId = const Value.absent(),
                required double caloriesPer100g,
                required double proteinPer100g,
                required double fatPer100g,
                required double carbsPer100g,
                Value<double?> gramsPerMl = const Value.absent(),
              }) => FoodProductsCompanion.insert(
                id: id,
                name: name,
                state: state,
                category: category,
                source: source,
                sourceId: sourceId,
                caloriesPer100g: caloriesPer100g,
                proteinPer100g: proteinPer100g,
                fatPer100g: fatPer100g,
                carbsPer100g: carbsPer100g,
                gramsPerMl: gramsPerMl,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$FoodProductsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $FoodProductsTable,
      FoodProduct,
      $$FoodProductsTableFilterComposer,
      $$FoodProductsTableOrderingComposer,
      $$FoodProductsTableAnnotationComposer,
      $$FoodProductsTableCreateCompanionBuilder,
      $$FoodProductsTableUpdateCompanionBuilder,
      (
        FoodProduct,
        BaseReferences<_$AppDatabase, $FoodProductsTable, FoodProduct>,
      ),
      FoodProduct,
      PrefetchHooks Function()
    >;
typedef $$FoodProductAliasesTableCreateCompanionBuilder =
    FoodProductAliasesCompanion Function({
      Value<int> id,
      required int foodProductId,
      required String alias,
    });
typedef $$FoodProductAliasesTableUpdateCompanionBuilder =
    FoodProductAliasesCompanion Function({
      Value<int> id,
      Value<int> foodProductId,
      Value<String> alias,
    });

class $$FoodProductAliasesTableFilterComposer
    extends Composer<_$AppDatabase, $FoodProductAliasesTable> {
  $$FoodProductAliasesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get foodProductId => $composableBuilder(
    column: $table.foodProductId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get alias => $composableBuilder(
    column: $table.alias,
    builder: (column) => ColumnFilters(column),
  );
}

class $$FoodProductAliasesTableOrderingComposer
    extends Composer<_$AppDatabase, $FoodProductAliasesTable> {
  $$FoodProductAliasesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get foodProductId => $composableBuilder(
    column: $table.foodProductId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get alias => $composableBuilder(
    column: $table.alias,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$FoodProductAliasesTableAnnotationComposer
    extends Composer<_$AppDatabase, $FoodProductAliasesTable> {
  $$FoodProductAliasesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get foodProductId => $composableBuilder(
    column: $table.foodProductId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get alias =>
      $composableBuilder(column: $table.alias, builder: (column) => column);
}

class $$FoodProductAliasesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $FoodProductAliasesTable,
          FoodProductAliase,
          $$FoodProductAliasesTableFilterComposer,
          $$FoodProductAliasesTableOrderingComposer,
          $$FoodProductAliasesTableAnnotationComposer,
          $$FoodProductAliasesTableCreateCompanionBuilder,
          $$FoodProductAliasesTableUpdateCompanionBuilder,
          (
            FoodProductAliase,
            BaseReferences<
              _$AppDatabase,
              $FoodProductAliasesTable,
              FoodProductAliase
            >,
          ),
          FoodProductAliase,
          PrefetchHooks Function()
        > {
  $$FoodProductAliasesTableTableManager(
    _$AppDatabase db,
    $FoodProductAliasesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$FoodProductAliasesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$FoodProductAliasesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$FoodProductAliasesTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> foodProductId = const Value.absent(),
                Value<String> alias = const Value.absent(),
              }) => FoodProductAliasesCompanion(
                id: id,
                foodProductId: foodProductId,
                alias: alias,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int foodProductId,
                required String alias,
              }) => FoodProductAliasesCompanion.insert(
                id: id,
                foodProductId: foodProductId,
                alias: alias,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$FoodProductAliasesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $FoodProductAliasesTable,
      FoodProductAliase,
      $$FoodProductAliasesTableFilterComposer,
      $$FoodProductAliasesTableOrderingComposer,
      $$FoodProductAliasesTableAnnotationComposer,
      $$FoodProductAliasesTableCreateCompanionBuilder,
      $$FoodProductAliasesTableUpdateCompanionBuilder,
      (
        FoodProductAliase,
        BaseReferences<
          _$AppDatabase,
          $FoodProductAliasesTable,
          FoodProductAliase
        >,
      ),
      FoodProductAliase,
      PrefetchHooks Function()
    >;
typedef $$UnknownFoodProductsTableCreateCompanionBuilder =
    UnknownFoodProductsCompanion Function({
      Value<int> id,
      required String name,
      Value<String> status,
      Value<int?> resolvedFoodProductId,
      required DateTime firstSeenAt,
    });
typedef $$UnknownFoodProductsTableUpdateCompanionBuilder =
    UnknownFoodProductsCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<String> status,
      Value<int?> resolvedFoodProductId,
      Value<DateTime> firstSeenAt,
    });

class $$UnknownFoodProductsTableFilterComposer
    extends Composer<_$AppDatabase, $UnknownFoodProductsTable> {
  $$UnknownFoodProductsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get resolvedFoodProductId => $composableBuilder(
    column: $table.resolvedFoodProductId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get firstSeenAt => $composableBuilder(
    column: $table.firstSeenAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$UnknownFoodProductsTableOrderingComposer
    extends Composer<_$AppDatabase, $UnknownFoodProductsTable> {
  $$UnknownFoodProductsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get resolvedFoodProductId => $composableBuilder(
    column: $table.resolvedFoodProductId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get firstSeenAt => $composableBuilder(
    column: $table.firstSeenAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$UnknownFoodProductsTableAnnotationComposer
    extends Composer<_$AppDatabase, $UnknownFoodProductsTable> {
  $$UnknownFoodProductsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<int> get resolvedFoodProductId => $composableBuilder(
    column: $table.resolvedFoodProductId,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get firstSeenAt => $composableBuilder(
    column: $table.firstSeenAt,
    builder: (column) => column,
  );
}

class $$UnknownFoodProductsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $UnknownFoodProductsTable,
          UnknownFoodProduct,
          $$UnknownFoodProductsTableFilterComposer,
          $$UnknownFoodProductsTableOrderingComposer,
          $$UnknownFoodProductsTableAnnotationComposer,
          $$UnknownFoodProductsTableCreateCompanionBuilder,
          $$UnknownFoodProductsTableUpdateCompanionBuilder,
          (
            UnknownFoodProduct,
            BaseReferences<
              _$AppDatabase,
              $UnknownFoodProductsTable,
              UnknownFoodProduct
            >,
          ),
          UnknownFoodProduct,
          PrefetchHooks Function()
        > {
  $$UnknownFoodProductsTableTableManager(
    _$AppDatabase db,
    $UnknownFoodProductsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UnknownFoodProductsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$UnknownFoodProductsTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$UnknownFoodProductsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<int?> resolvedFoodProductId = const Value.absent(),
                Value<DateTime> firstSeenAt = const Value.absent(),
              }) => UnknownFoodProductsCompanion(
                id: id,
                name: name,
                status: status,
                resolvedFoodProductId: resolvedFoodProductId,
                firstSeenAt: firstSeenAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                Value<String> status = const Value.absent(),
                Value<int?> resolvedFoodProductId = const Value.absent(),
                required DateTime firstSeenAt,
              }) => UnknownFoodProductsCompanion.insert(
                id: id,
                name: name,
                status: status,
                resolvedFoodProductId: resolvedFoodProductId,
                firstSeenAt: firstSeenAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$UnknownFoodProductsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $UnknownFoodProductsTable,
      UnknownFoodProduct,
      $$UnknownFoodProductsTableFilterComposer,
      $$UnknownFoodProductsTableOrderingComposer,
      $$UnknownFoodProductsTableAnnotationComposer,
      $$UnknownFoodProductsTableCreateCompanionBuilder,
      $$UnknownFoodProductsTableUpdateCompanionBuilder,
      (
        UnknownFoodProduct,
        BaseReferences<
          _$AppDatabase,
          $UnknownFoodProductsTable,
          UnknownFoodProduct
        >,
      ),
      UnknownFoodProduct,
      PrefetchHooks Function()
    >;
typedef $$RecipesTableCreateCompanionBuilder = RecipesCompanion Function({
  Value<int> id,
  required String name,
  Value<String> description,
  Value<String> instructions,
  Value<int?> prepMinutes,
  Value<int> servings,
  required double caloriesPerServing,
  required double proteinPerServing,
  required double fatPerServing,
  required double carbsPerServing,
  Value<String?> dietTypes,
  Value<String?> allergens,
  Value<bool> isBuiltIn,
});
typedef $$RecipesTableUpdateCompanionBuilder = RecipesCompanion Function({
  Value<int> id,
  Value<String> name,
  Value<String> description,
  Value<String> instructions,
  Value<int?> prepMinutes,
  Value<int> servings,
  Value<double> caloriesPerServing,
  Value<double> proteinPerServing,
  Value<double> fatPerServing,
  Value<double> carbsPerServing,
  Value<String?> dietTypes,
  Value<String?> allergens,
  Value<bool> isBuiltIn,
});

class $$RecipesTableFilterComposer
    extends Composer<_$AppDatabase, $RecipesTable> {
  $$RecipesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get instructions => $composableBuilder(
    column: $table.instructions,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get prepMinutes => $composableBuilder(
    column: $table.prepMinutes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get servings => $composableBuilder(
    column: $table.servings,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get caloriesPerServing => $composableBuilder(
    column: $table.caloriesPerServing,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get proteinPerServing => $composableBuilder(
    column: $table.proteinPerServing,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get fatPerServing => $composableBuilder(
    column: $table.fatPerServing,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get carbsPerServing => $composableBuilder(
    column: $table.carbsPerServing,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get dietTypes => $composableBuilder(
    column: $table.dietTypes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get allergens => $composableBuilder(
    column: $table.allergens,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isBuiltIn => $composableBuilder(
    column: $table.isBuiltIn,
    builder: (column) => ColumnFilters(column),
  );
}

class $$RecipesTableOrderingComposer
    extends Composer<_$AppDatabase, $RecipesTable> {
  $$RecipesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get instructions => $composableBuilder(
    column: $table.instructions,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get prepMinutes => $composableBuilder(
    column: $table.prepMinutes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get servings => $composableBuilder(
    column: $table.servings,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get caloriesPerServing => $composableBuilder(
    column: $table.caloriesPerServing,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get proteinPerServing => $composableBuilder(
    column: $table.proteinPerServing,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get fatPerServing => $composableBuilder(
    column: $table.fatPerServing,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get carbsPerServing => $composableBuilder(
    column: $table.carbsPerServing,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get dietTypes => $composableBuilder(
    column: $table.dietTypes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get allergens => $composableBuilder(
    column: $table.allergens,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isBuiltIn => $composableBuilder(
    column: $table.isBuiltIn,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$RecipesTableAnnotationComposer
    extends Composer<_$AppDatabase, $RecipesTable> {
  $$RecipesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<String> get instructions => $composableBuilder(
    column: $table.instructions,
    builder: (column) => column,
  );

  GeneratedColumn<int> get prepMinutes => $composableBuilder(
    column: $table.prepMinutes,
    builder: (column) => column,
  );

  GeneratedColumn<int> get servings =>
      $composableBuilder(column: $table.servings, builder: (column) => column);

  GeneratedColumn<double> get caloriesPerServing => $composableBuilder(
    column: $table.caloriesPerServing,
    builder: (column) => column,
  );

  GeneratedColumn<double> get proteinPerServing => $composableBuilder(
    column: $table.proteinPerServing,
    builder: (column) => column,
  );

  GeneratedColumn<double> get fatPerServing => $composableBuilder(
    column: $table.fatPerServing,
    builder: (column) => column,
  );

  GeneratedColumn<double> get carbsPerServing => $composableBuilder(
    column: $table.carbsPerServing,
    builder: (column) => column,
  );

  GeneratedColumn<String> get dietTypes =>
      $composableBuilder(column: $table.dietTypes, builder: (column) => column);

  GeneratedColumn<String> get allergens =>
      $composableBuilder(column: $table.allergens, builder: (column) => column);

  GeneratedColumn<bool> get isBuiltIn =>
      $composableBuilder(column: $table.isBuiltIn, builder: (column) => column);
}

class $$RecipesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $RecipesTable,
          Recipe,
          $$RecipesTableFilterComposer,
          $$RecipesTableOrderingComposer,
          $$RecipesTableAnnotationComposer,
          $$RecipesTableCreateCompanionBuilder,
          $$RecipesTableUpdateCompanionBuilder,
          (Recipe, BaseReferences<_$AppDatabase, $RecipesTable, Recipe>),
          Recipe,
          PrefetchHooks Function()
        > {
  $$RecipesTableTableManager(_$AppDatabase db, $RecipesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RecipesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$RecipesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$RecipesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> description = const Value.absent(),
                Value<String> instructions = const Value.absent(),
                Value<int?> prepMinutes = const Value.absent(),
                Value<int> servings = const Value.absent(),
                Value<double> caloriesPerServing = const Value.absent(),
                Value<double> proteinPerServing = const Value.absent(),
                Value<double> fatPerServing = const Value.absent(),
                Value<double> carbsPerServing = const Value.absent(),
                Value<String?> dietTypes = const Value.absent(),
                Value<String?> allergens = const Value.absent(),
                Value<bool> isBuiltIn = const Value.absent(),
              }) => RecipesCompanion(
                id: id,
                name: name,
                description: description,
                instructions: instructions,
                prepMinutes: prepMinutes,
                servings: servings,
                caloriesPerServing: caloriesPerServing,
                proteinPerServing: proteinPerServing,
                fatPerServing: fatPerServing,
                carbsPerServing: carbsPerServing,
                dietTypes: dietTypes,
                allergens: allergens,
                isBuiltIn: isBuiltIn,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                Value<String> description = const Value.absent(),
                Value<String> instructions = const Value.absent(),
                Value<int?> prepMinutes = const Value.absent(),
                Value<int> servings = const Value.absent(),
                required double caloriesPerServing,
                required double proteinPerServing,
                required double fatPerServing,
                required double carbsPerServing,
                Value<String?> dietTypes = const Value.absent(),
                Value<String?> allergens = const Value.absent(),
                Value<bool> isBuiltIn = const Value.absent(),
              }) => RecipesCompanion.insert(
                id: id,
                name: name,
                description: description,
                instructions: instructions,
                prepMinutes: prepMinutes,
                servings: servings,
                caloriesPerServing: caloriesPerServing,
                proteinPerServing: proteinPerServing,
                fatPerServing: fatPerServing,
                carbsPerServing: carbsPerServing,
                dietTypes: dietTypes,
                allergens: allergens,
                isBuiltIn: isBuiltIn,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$RecipesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $RecipesTable,
      Recipe,
      $$RecipesTableFilterComposer,
      $$RecipesTableOrderingComposer,
      $$RecipesTableAnnotationComposer,
      $$RecipesTableCreateCompanionBuilder,
      $$RecipesTableUpdateCompanionBuilder,
      (Recipe, BaseReferences<_$AppDatabase, $RecipesTable, Recipe>),
      Recipe,
      PrefetchHooks Function()
    >;
typedef $$RecipeIngredientsTableCreateCompanionBuilder =
    RecipeIngredientsCompanion Function({
      Value<int> id,
      required int recipeId,
      required String name,
      required double amount,
      required String unit,
      Value<double?> weightGrams,
      Value<double?> caloriesPer100g,
      Value<double?> proteinPer100g,
      Value<double?> fatPer100g,
      Value<double?> carbsPer100g,
    });
typedef $$RecipeIngredientsTableUpdateCompanionBuilder =
    RecipeIngredientsCompanion Function({
      Value<int> id,
      Value<int> recipeId,
      Value<String> name,
      Value<double> amount,
      Value<String> unit,
      Value<double?> weightGrams,
      Value<double?> caloriesPer100g,
      Value<double?> proteinPer100g,
      Value<double?> fatPer100g,
      Value<double?> carbsPer100g,
    });

class $$RecipeIngredientsTableFilterComposer
    extends Composer<_$AppDatabase, $RecipeIngredientsTable> {
  $$RecipeIngredientsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get recipeId => $composableBuilder(
    column: $table.recipeId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get unit => $composableBuilder(
    column: $table.unit,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get weightGrams => $composableBuilder(
    column: $table.weightGrams,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get caloriesPer100g => $composableBuilder(
    column: $table.caloriesPer100g,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get proteinPer100g => $composableBuilder(
    column: $table.proteinPer100g,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get fatPer100g => $composableBuilder(
    column: $table.fatPer100g,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get carbsPer100g => $composableBuilder(
    column: $table.carbsPer100g,
    builder: (column) => ColumnFilters(column),
  );
}

class $$RecipeIngredientsTableOrderingComposer
    extends Composer<_$AppDatabase, $RecipeIngredientsTable> {
  $$RecipeIngredientsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get recipeId => $composableBuilder(
    column: $table.recipeId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get unit => $composableBuilder(
    column: $table.unit,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get weightGrams => $composableBuilder(
    column: $table.weightGrams,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get caloriesPer100g => $composableBuilder(
    column: $table.caloriesPer100g,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get proteinPer100g => $composableBuilder(
    column: $table.proteinPer100g,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get fatPer100g => $composableBuilder(
    column: $table.fatPer100g,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get carbsPer100g => $composableBuilder(
    column: $table.carbsPer100g,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$RecipeIngredientsTableAnnotationComposer
    extends Composer<_$AppDatabase, $RecipeIngredientsTable> {
  $$RecipeIngredientsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get recipeId =>
      $composableBuilder(column: $table.recipeId, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<double> get amount =>
      $composableBuilder(column: $table.amount, builder: (column) => column);

  GeneratedColumn<String> get unit =>
      $composableBuilder(column: $table.unit, builder: (column) => column);

  GeneratedColumn<double> get weightGrams => $composableBuilder(
    column: $table.weightGrams,
    builder: (column) => column,
  );

  GeneratedColumn<double> get caloriesPer100g => $composableBuilder(
    column: $table.caloriesPer100g,
    builder: (column) => column,
  );

  GeneratedColumn<double> get proteinPer100g => $composableBuilder(
    column: $table.proteinPer100g,
    builder: (column) => column,
  );

  GeneratedColumn<double> get fatPer100g => $composableBuilder(
    column: $table.fatPer100g,
    builder: (column) => column,
  );

  GeneratedColumn<double> get carbsPer100g => $composableBuilder(
    column: $table.carbsPer100g,
    builder: (column) => column,
  );
}

class $$RecipeIngredientsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $RecipeIngredientsTable,
          RecipeIngredient,
          $$RecipeIngredientsTableFilterComposer,
          $$RecipeIngredientsTableOrderingComposer,
          $$RecipeIngredientsTableAnnotationComposer,
          $$RecipeIngredientsTableCreateCompanionBuilder,
          $$RecipeIngredientsTableUpdateCompanionBuilder,
          (
            RecipeIngredient,
            BaseReferences<
              _$AppDatabase,
              $RecipeIngredientsTable,
              RecipeIngredient
            >,
          ),
          RecipeIngredient,
          PrefetchHooks Function()
        > {
  $$RecipeIngredientsTableTableManager(
    _$AppDatabase db,
    $RecipeIngredientsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RecipeIngredientsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$RecipeIngredientsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$RecipeIngredientsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> recipeId = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<double> amount = const Value.absent(),
                Value<String> unit = const Value.absent(),
                Value<double?> weightGrams = const Value.absent(),
                Value<double?> caloriesPer100g = const Value.absent(),
                Value<double?> proteinPer100g = const Value.absent(),
                Value<double?> fatPer100g = const Value.absent(),
                Value<double?> carbsPer100g = const Value.absent(),
              }) => RecipeIngredientsCompanion(
                id: id,
                recipeId: recipeId,
                name: name,
                amount: amount,
                unit: unit,
                weightGrams: weightGrams,
                caloriesPer100g: caloriesPer100g,
                proteinPer100g: proteinPer100g,
                fatPer100g: fatPer100g,
                carbsPer100g: carbsPer100g,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int recipeId,
                required String name,
                required double amount,
                required String unit,
                Value<double?> weightGrams = const Value.absent(),
                Value<double?> caloriesPer100g = const Value.absent(),
                Value<double?> proteinPer100g = const Value.absent(),
                Value<double?> fatPer100g = const Value.absent(),
                Value<double?> carbsPer100g = const Value.absent(),
              }) => RecipeIngredientsCompanion.insert(
                id: id,
                recipeId: recipeId,
                name: name,
                amount: amount,
                unit: unit,
                weightGrams: weightGrams,
                caloriesPer100g: caloriesPer100g,
                proteinPer100g: proteinPer100g,
                fatPer100g: fatPer100g,
                carbsPer100g: carbsPer100g,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$RecipeIngredientsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $RecipeIngredientsTable,
      RecipeIngredient,
      $$RecipeIngredientsTableFilterComposer,
      $$RecipeIngredientsTableOrderingComposer,
      $$RecipeIngredientsTableAnnotationComposer,
      $$RecipeIngredientsTableCreateCompanionBuilder,
      $$RecipeIngredientsTableUpdateCompanionBuilder,
      (
        RecipeIngredient,
        BaseReferences<
          _$AppDatabase,
          $RecipeIngredientsTable,
          RecipeIngredient
        >,
      ),
      RecipeIngredient,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$FamiliesTableTableManager get families =>
      $$FamiliesTableTableManager(_db, _db.families);
  $$FamilyMembersTableTableManager get familyMembers =>
      $$FamilyMembersTableTableManager(_db, _db.familyMembers);
  $$PantryProductsTableTableManager get pantryProducts =>
      $$PantryProductsTableTableManager(_db, _db.pantryProducts);
  $$FoodProductsTableTableManager get foodProducts =>
      $$FoodProductsTableTableManager(_db, _db.foodProducts);
  $$FoodProductAliasesTableTableManager get foodProductAliases =>
      $$FoodProductAliasesTableTableManager(_db, _db.foodProductAliases);
  $$UnknownFoodProductsTableTableManager get unknownFoodProducts =>
      $$UnknownFoodProductsTableTableManager(_db, _db.unknownFoodProducts);
  $$RecipesTableTableManager get recipes =>
      $$RecipesTableTableManager(_db, _db.recipes);
  $$RecipeIngredientsTableTableManager get recipeIngredients =>
      $$RecipeIngredientsTableTableManager(_db, _db.recipeIngredients);
}
