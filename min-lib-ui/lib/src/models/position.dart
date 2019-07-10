import 'package:json_annotation/json_annotation.dart';

part 'position.g.dart';

@JsonSerializable()
class Position {
  @JsonKey(name:'id')
  final int id;
  
  @JsonKey(name:'description')
  String description;

  Position(this.id, this.description);

  factory Position.fromJson(Map<String, dynamic> json) => _$PositionFromJson(json);

  Map<String, dynamic> toJson() => _$PositionToJson(this);
}