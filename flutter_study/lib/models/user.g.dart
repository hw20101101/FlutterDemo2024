// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User3 _$User3FromJson(Map<String, dynamic> json) => User3(
      json['name'] as String,
      json['email'] as String,
      Address.fromJson(json['address'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$User3ToJson(User3 instance) => <String, dynamic>{
      'name': instance.name,
      'email': instance.email,
      'address': instance.address.toJson(),
    };
