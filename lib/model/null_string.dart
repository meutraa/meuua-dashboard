import 'package:json_annotation/json_annotation.dart';

part 'null_string.g.dart';

@JsonSerializable(explicitToJson: true)
class NullString {
  @JsonKey(name: 'String', required: true, includeIfNull: false)
  String string;
  @JsonKey(name: 'Valid', required: true, includeIfNull: false)
  bool valid;

  NullString({
    required this.string,
    required this.valid,
  });

  factory NullString.fromJson(Map<String, dynamic> json) => _$NullStringFromJson(json);

  Map<String, dynamic> toJson() => _$NullStringToJson(this);

  @override
  String toString() =>
      'NullString{'
      'string: $string, '
      'valid: $valid'
      '}';

}

const deserializeNullString = NullString.fromJson;

Map<String, dynamic> serializeNullString(NullString object) => object.toJson();

List<NullString> deserializeNullStringList(List<Map<String, dynamic>> jsonList)
    => jsonList.map(NullString.fromJson).toList();

List<Map<String, dynamic>> serializeNullStringList(List<NullString> objects)
    => objects.map((object) => object.toJson()).toList();
