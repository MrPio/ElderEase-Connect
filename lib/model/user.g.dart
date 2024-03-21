// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      name: json['name'] as String? ?? "Anonimo",
      surname: json['surname'] as String? ?? "",
      address: json['address'] as String?,
      regDateTimestamp: json['regDateTimestamp'] as int?,
      postsUIDs: (json['postsUIDs'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    )..uid = json['uid'] as String?;

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'name': instance.name,
      'surname': instance.surname,
      'address': instance.address,
      'regDateTimestamp': instance.regDateTimestamp,
      'postsUIDs': instance.postsUIDs,
    };
