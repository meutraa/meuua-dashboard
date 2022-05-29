import 'package:json_annotation/json_annotation.dart';

part 'approval.g.dart';

@JsonSerializable(explicitToJson: true)
class Approval {
  @JsonKey(name: 'ChannelID', required: true, includeIfNull: false)
  final String channelId;
  @JsonKey(name: 'UserID', required: true, includeIfNull: false)
  final String userId;

  const Approval({
    required this.channelId,
    required this.userId,
  });

  factory Approval.fromJson(Map<String, dynamic> json) =>
      _$ApprovalFromJson(json);

  Map<String, dynamic> toJson() => _$ApprovalToJson(this);

  @override
  String toString() => 'Approval{'
      'channelId: $channelId, '
      'userId: $userId'
      '}';
}

const deserializeApproval = Approval.fromJson;

Map<String, dynamic> serializeApproval(Approval object) => object.toJson();

List<Approval> deserializeApprovalList(List<Map<String, dynamic>> jsonList) =>
    jsonList.map(Approval.fromJson).toList();

List<Map<String, dynamic>> serializeApprovalList(List<Approval> objects) =>
    objects.map((object) => object.toJson()).toList();
