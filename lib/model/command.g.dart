// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'command.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Command _$CommandFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    requiredKeys: const ['Name', 'Template'],
  );
  return Command(
    name: json['Name'] as String,
    template: json['Template'] as String,
  );
}

Map<String, dynamic> _$CommandToJson(Command instance) => <String, dynamic>{
      'Name': instance.name,
      'Template': instance.template,
    };
