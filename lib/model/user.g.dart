// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      name: json['name'] as String? ?? "Anonimo",
      surname: json['surname'] as String? ?? "",
      address: json['address'] as String?,
      cellNumber: json['cellNumber'] as String?,
      gender: $enumDecodeNullable(_$GenderEnumMap, json['gender']),
      userType: $enumDecodeNullable(_$UserTypeEnumMap, json['userType']),
      regDateTimestamp: json['regDateTimestamp'] as int?,
      birthDateTimestamp: json['birthDateTimestamp'] as int?,
      postsUIDs: (json['postsUIDs'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    )..uid = json['uid'] as String?;

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'name': instance.name,
      'surname': instance.surname,
      'address': instance.address,
      'cellNumber': instance.cellNumber,
      'regDateTimestamp': instance.regDateTimestamp,
      'birthDateTimestamp': instance.birthDateTimestamp,
      'userType': _$UserTypeEnumMap[instance.userType]!,
      'gender': _$GenderEnumMap[instance.gender]!,
      'postsUIDs': instance.postsUIDs,
    };

const _$GenderEnumMap = {
  Gender.MALE: 'MALE',
  Gender.FEMALE: 'FEMALE',
  Gender.OTHER: 'OTHER',
};

const _$UserTypeEnumMap = {
  UserType.STUDENT: 'STUDENT',
  UserType.ELDER: 'ELDER',
};
