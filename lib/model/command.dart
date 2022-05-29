import 'package:json_annotation/json_annotation.dart';

part 'command.g.dart';

@JsonSerializable(explicitToJson: true)
class Command {
  @JsonKey(name: 'Name', required: true, includeIfNull: false)
  final String name;
  @JsonKey(name: 'Template', required: true, includeIfNull: false)
  final String template;

  const Command({
    required this.name,
    required this.template,
  });

  factory Command.fromJson(Map<String, dynamic> json) =>
      _$CommandFromJson(json);

  Map<String, dynamic> toJson() => _$CommandToJson(this);

  @override
  String toString() => 'Command{'
      'name: $name, '
      'template: $template'
      '}';
}

const deserializeCommand = Command.fromJson;

Map<String, dynamic> serializeCommand(Command object) => object.toJson();

List<Command> deserializeCommandList(List<Map<String, dynamic>> jsonList) =>
    jsonList.map(Command.fromJson).toList();

List<Map<String, dynamic>> serializeCommandList(List<Command> objects) =>
    objects.map((object) => object.toJson()).toList();
