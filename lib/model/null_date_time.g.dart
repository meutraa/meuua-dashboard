// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'null_date_time.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NullDateTime _$NullDateTimeFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    requiredKeys: const ['Time', 'Valid'],
  );
  return NullDateTime(
    time: DateTime.parse(json['Time'] as String),
    valid: json['Valid'] as bool,
  );
}

Map<String, dynamic> _$NullDateTimeToJson(NullDateTime instance) =>
    <String, dynamic>{
      'Time': instance.time.toIso8601String(),
      'Valid': instance.valid,
    };
