import 'package:json_annotation/json_annotation.dart';

part 'null_date_time.g.dart';

@JsonSerializable(explicitToJson: true)
class NullDateTime {
  @JsonKey(name: 'Time', required: true, includeIfNull: false)
  final DateTime time;
  @JsonKey(name: 'Valid', required: true, includeIfNull: false)
  final bool valid;

  const NullDateTime({
    required this.time,
    required this.valid,
  });

  factory NullDateTime.fromJson(Map<String, dynamic> json) => _$NullDateTimeFromJson(json);

  Map<String, dynamic> toJson() => _$NullDateTimeToJson(this);

  @override
  String toString() =>
      'NullDateTime{'
      'time: $time, '
      'valid: $valid'
      '}';

}

const deserializeNullDateTime = NullDateTime.fromJson;

Map<String, dynamic> serializeNullDateTime(NullDateTime object) => object.toJson();

List<NullDateTime> deserializeNullDateTimeList(List<Map<String, dynamic>> jsonList)
    => jsonList.map(NullDateTime.fromJson).toList();

List<Map<String, dynamic>> serializeNullDateTimeList(List<NullDateTime> objects)
    => objects.map((object) => object.toJson()).toList();
