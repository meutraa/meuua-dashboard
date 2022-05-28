// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'channel_settings.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChannelSettings _$ChannelSettingsFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    requiredKeys: const [
      'ChannelID',
      'AutoreplyEnabled',
      'AutoreplyFrequency',
      'ReplySafety',
      'OpenaiToken',
      'CreatedAt',
      'UpdatedAt'
    ],
  );
  return ChannelSettings(
    channelId: json['ChannelID'] as String,
    autoReplyEnabled: json['AutoreplyEnabled'] as bool,
    autoReplyFrequency: (json['AutoreplyFrequency'] as num).toDouble(),
    replySafety: json['ReplySafety'] as int,
    openaiToken:
        NullString.fromJson(json['OpenaiToken'] as Map<String, dynamic>),
    createdAt: DateTime.parse(json['CreatedAt'] as String),
    updatedAt: NullDateTime.fromJson(json['UpdatedAt'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$ChannelSettingsToJson(ChannelSettings instance) =>
    <String, dynamic>{
      'ChannelID': instance.channelId,
      'AutoreplyEnabled': instance.autoReplyEnabled,
      'AutoreplyFrequency': instance.autoReplyFrequency,
      'ReplySafety': instance.replySafety,
      'OpenaiToken': instance.openaiToken.toJson(),
      'CreatedAt': instance.createdAt.toIso8601String(),
      'UpdatedAt': instance.updatedAt.toJson(),
    };
