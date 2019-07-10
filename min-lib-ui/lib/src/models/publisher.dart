import 'package:json_annotation/json_annotation.dart';

part 'publisher.g.dart';

@JsonSerializable()
class Publisher {
  @JsonKey(name:'id')
  final int id;
  
  @JsonKey(name:'name')
  String name;

  Publisher(this.id, this.name);

  factory Publisher.fromJson(Map<String, dynamic> json) => _$PublisherFromJson(json);

  Map<String, dynamic> toJson() => _$PublisherToJson(this);
}