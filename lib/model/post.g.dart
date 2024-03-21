// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Post _$PostFromJson(Map<String, dynamic> json) => Post(
      authorUID: json['authorUID'] as String?,
      timestamp: json['timestamp'] as int? ?? 0,
      description: json['description'] as String? ?? "",
      uid: json['uid'] as String?,
      acceptedUserUID: json['acceptedUserUID'] as String?,
      elderName: json['elderName'] as String?,
      elderSurname: json['elderSurname'] as String?,
      review: json['review'] as int?,
    );

Map<String, dynamic> _$PostToJson(Post instance) => <String, dynamic>{
      'authorUID': instance.authorUID,
      'timestamp': instance.timestamp,
      'description': instance.description,
      'acceptedUserUID': instance.acceptedUserUID,
      'elderName': instance.elderName,
      'elderSurname': instance.elderSurname,
      'review': instance.review,
    };
