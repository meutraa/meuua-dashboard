import 'package:json_annotation/json_annotation.dart';
import 'package:meuua/model/null_date_time.dart';
import 'package:meuua/model/null_string.dart';

part 'channel_settings.g.dart';

@JsonSerializable(explicitToJson: true)
class ChannelSettings {
  @JsonKey(name: 'ChannelID', required: true, includeIfNull: false)
  final String channelId;
  @JsonKey(name: 'AutoreplyEnabled', required: true, includeIfNull: false)
  bool autoReplyEnabled;
  @JsonKey(name: 'AutoreplyFrequency', required: true, includeIfNull: false)
  double autoReplyFrequency;
  @JsonKey(name: 'ReplySafety', required: true, includeIfNull: false)
  int replySafety;
  @JsonKey(name: 'OpenaiToken', required: true, includeIfNull: false)
  NullString openaiToken;
  @JsonKey(name: 'CreatedAt', required: true, includeIfNull: false)
  final DateTime createdAt;
  @JsonKey(name: 'UpdatedAt', required: true, includeIfNull: false)
  final NullDateTime updatedAt;

  ChannelSettings({
    required this.channelId,
    required this.autoReplyEnabled,
    required this.autoReplyFrequency,
    required this.replySafety,
    required this.openaiToken,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ChannelSettings.fromJson(Map<String, dynamic> json) =>
      _$ChannelSettingsFromJson(json);

  Map<String, dynamic> toJson() => _$ChannelSettingsToJson(this);

  @override
  String toString() => 'ChannelSettings{'
      'channelId: $channelId, '
      'autoReplyEnabled: $autoReplyEnabled, '
      'autoReplyFrequency: $autoReplyFrequency, '
      'replySafety: $replySafety, '
      'openaiToken: $openaiToken, '
      'createdAt: $createdAt, '
      'updatedAt: $updatedAt'
      '}';
}

const deserializeChannelSettings = ChannelSettings.fromJson;

Map<String, dynamic> serializeChannelSettings(ChannelSettings object) =>
    object.toJson();

List<ChannelSettings> deserializeChannelSettingsList(
        List<Map<String, dynamic>> jsonList) =>
    jsonList.map(ChannelSettings.fromJson).toList();

List<Map<String, dynamic>> serializeChannelSettingsList(
        List<ChannelSettings> objects) =>
    objects.map((object) => object.toJson()).toList();
