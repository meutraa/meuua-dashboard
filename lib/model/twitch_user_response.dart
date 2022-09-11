import 'package:json_annotation/json_annotation.dart';
import 'user.dart';

part 'twitch_user_response.g.dart';

@JsonSerializable(explicitToJson: true)
class TwitchUserResponse {
  @JsonKey(name: 'data', includeIfNull: false)
  final List<User>? data;

  const TwitchUserResponse({
    this.data,
  });

  factory TwitchUserResponse.fromJson(Map<String, dynamic> json) =>
      _$TwitchUserResponseFromJson(json);

  Map<String, dynamic> toJson() => _$TwitchUserResponseToJson(this);

  @override
  String toString() => 'TwitchUserResponse{'
      'data: $data'
      '}';
}

const deserializeTwitchUserResponse = TwitchUserResponse.fromJson;

Map<String, dynamic> serializeTwitchUserResponse(TwitchUserResponse object) =>
    object.toJson();

List<TwitchUserResponse> deserializeTwitchUserResponseList(
        List<Map<String, dynamic>> jsonList) =>
    jsonList.map(TwitchUserResponse.fromJson).toList();

List<Map<String, dynamic>> serializeTwitchUserResponseList(
        List<TwitchUserResponse> objects) =>
    objects.map((object) => object.toJson()).toList();
