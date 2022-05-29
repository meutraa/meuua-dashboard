// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'approval.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Approval _$ApprovalFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    requiredKeys: const ['ChannelID', 'UserID'],
  );
  return Approval(
    channelId: json['ChannelID'] as String,
    userId: json['UserID'] as String,
  );
}

Map<String, dynamic> _$ApprovalToJson(Approval instance) => <String, dynamic>{
      'ChannelID': instance.channelId,
      'UserID': instance.userId,
    };
