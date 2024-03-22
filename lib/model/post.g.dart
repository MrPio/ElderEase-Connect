// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Post _$PostFromJson(Map<String, dynamic> json) => Post(
      authorUID: json['authorUID'] as String?,
      timestamp: json['timestamp'] as int? ?? 0,
      description: json['description'] as String? ?? "",
      address: json['address'] as String?,
      uid: json['uid'] as String?,
      acceptedUserUID: json['acceptedUserUID'] as String?,
      hours: (json['hours'] as num?)?.toDouble() ?? 1,
      regDateTimestamp: json['regDateTimestamp'] as int?,
      elderName: json['elderName'] as String?,
      elderSurname: json['elderSurname'] as String?,
      postType: $enumDecodeNullable(_$PostTypeEnumMap, json['postType']),
      review: json['review'] as int?,
    );

Map<String, dynamic> _$PostToJson(Post instance) => <String, dynamic>{
      'authorUID': instance.authorUID,
      'timestamp': instance.timestamp,
      'regDateTimestamp': instance.regDateTimestamp,
      'hours': instance.hours,
      'address': instance.address,
      'description': instance.description,
      'acceptedUserUID': instance.acceptedUserUID,
      'elderName': instance.elderName,
      'elderSurname': instance.elderSurname,
      'postType': _$PostTypeEnumMap[instance.postType]!,
      'review': instance.review,
    };

const _$PostTypeEnumMap = {
  PostType.HOME: 'HOME',
  PostType.TRANSPORT: 'TRANSPORT',
};
