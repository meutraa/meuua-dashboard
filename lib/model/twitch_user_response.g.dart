// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'twitch_user_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TwitchUserResponse _$TwitchUserResponseFromJson(Map<String, dynamic> json) =>
    TwitchUserResponse(
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => User.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TwitchUserResponseToJson(TwitchUserResponse instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('data', instance.data?.map((e) => e.toJson()).toList());
  return val;
}
