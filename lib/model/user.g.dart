// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    requiredKeys: const [
      'id',
      'login',
      'display_name',
      'broadcaster_type',
      'description',
      'profile_image_url',
      'offline_image_url',
      'view_count'
    ],
  );
  return User(
    id: json['id'] as String,
    login: json['login'] as String,
    displayName: json['display_name'] as String,
    broadcasterType: json['broadcaster_type'] as String,
    description: json['description'] as String,
    profileImageUrl: json['profile_image_url'] as String,
    offlineImageUrl: json['offline_image_url'] as String,
    viewCount: json['view_count'] as int,
    createdAt: json['created_at'] == null
        ? null
        : DateTime.parse(json['created_at'] as String),
  );
}

Map<String, dynamic> _$UserToJson(User instance) {
  final val = <String, dynamic>{
    'id': instance.id,
    'login': instance.login,
    'display_name': instance.displayName,
    'broadcaster_type': instance.broadcasterType,
    'description': instance.description,
    'profile_image_url': instance.profileImageUrl,
    'offline_image_url': instance.offlineImageUrl,
    'view_count': instance.viewCount,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('created_at', instance.createdAt?.toIso8601String());
  return val;
}
