import 'package:json_annotation/json_annotation.dart';

part 'author.g.dart';

@JsonSerializable()
class Author {
  @JsonKey(name:'id')
  final int id;

  @JsonKey(name:'name')
  String name;
  
  @JsonKey(name:'surname')
  String surname;

  String get fullName => '$name $surname';

  Author(this.id, this.name, this.surname);

  factory Author.fromJson(Map<String, dynamic> json) => _$AuthorFromJson(json);

  Map<String, dynamic> toJson() => _$AuthorToJson(this);
}