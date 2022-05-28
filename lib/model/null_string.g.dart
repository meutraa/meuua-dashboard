// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'null_string.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NullString _$NullStringFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    requiredKeys: const ['String', 'Valid'],
  );
  return NullString(
    string: json['String'] as String,
    valid: json['Valid'] as bool,
  );
}

Map<String, dynamic> _$NullStringToJson(NullString instance) =>
    <String, dynamic>{
      'String': instance.string,
      'Valid': instance.valid,
    };
