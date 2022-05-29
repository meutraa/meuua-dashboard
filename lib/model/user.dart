import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable(explicitToJson: true)
class User {
  @JsonKey(name: 'id', required: true, includeIfNull: false)
  final String id;
  @JsonKey(name: 'login', required: true, includeIfNull: false)
  final String login;
  @JsonKey(name: 'display_name', required: true, includeIfNull: false)
  final String displayName;
  @JsonKey(name: 'broadcaster_type', required: true, includeIfNull: false)
  final String broadcasterType;
  @JsonKey(name: 'description', required: true, includeIfNull: false)
  final String description;
  @JsonKey(name: 'profile_image_url', required: true, includeIfNull: false)
  final String profileImageUrl;
  @JsonKey(name: 'offline_image_url', required: true, includeIfNull: false)
  final String offlineImageUrl;
  @JsonKey(name: 'view_count', required: true, includeIfNull: false)
  final int viewCount;
  @JsonKey(name: 'created_at', includeIfNull: false)
  final DateTime? createdAt;

  const User({
    required this.id,
    required this.login,
    required this.displayName,
    required this.broadcasterType,
    required this.description,
    required this.profileImageUrl,
    required this.offlineImageUrl,
    required this.viewCount,
    this.createdAt,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);

  @override
  String toString() => 'User{'
      'id: $id, '
      'login: $login, '
      'displayName: $displayName, '
      'broadcasterType: $broadcasterType, '
      'description: $description, '
      'profileImageUrl: $profileImageUrl, '
      'offlineImageUrl: $offlineImageUrl, '
      'viewCount: $viewCount, '
      'createdAt: $createdAt'
      '}';
}

const deserializeUser = User.fromJson;

Map<String, dynamic> serializeUser(User object) => object.toJson();

List<User> deserializeUserList(List<Map<String, dynamic>> jsonList) =>
    jsonList.map(User.fromJson).toList();

List<Map<String, dynamic>> serializeUserList(List<User> objects) =>
    objects.map((object) => object.toJson()).toList();
