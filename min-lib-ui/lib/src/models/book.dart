import 'package:angular_app/src/models/models.dart';
import 'package:json_annotation/json_annotation.dart';

part 'book.g.dart';

@JsonSerializable()
class Book {
  @JsonKey(name: 'id')
  final int id;

  @JsonKey(name: 'imageUrl')
  final String imageUrl;

  @JsonKey(name: 'title')
  final String title;

  @JsonKey(name: 'authors')
  List<Author> authors;

  @JsonKey(name: 'position')
  Position position;

  @JsonKey(name: 'category')
  Category category;

  @JsonKey(name: 'publisher')
  Publisher publisher;

  Book(this.id, this.title, this.authors, this.category, this.publisher, this.imageUrl);

  factory Book.fromJson(Map<String, dynamic> json) => _$BookFromJson(json);

  Map<String, dynamic> toJson() => _$BookToJson(this);
}

final _mockAuthors = <Author>[
  Author(1, 'Adam', 'Mickiewicz'),
  Author(2, 'J. K.', 'Rowling'),
  Author(3, 'Wiliam', 'Shakespeare')
];

final mockBooks = <Book>[
  Book(1, 'Anna Karenina', _mockAuthors, Category(1, 'Fantasy'), Publisher(1, 'Sosnowo'), 'https://ecsmedia.pl/c/anna-karenina-w-iext43878953.jpg'),
  Book(3, 'Madame Bovary', _mockAuthors, Category(2, 'Horror'), Publisher(1, 'Sosnowo'), 'https://ssl-gfx.filmweb.pl/po/14/36/651436/7813038.3.jpg'),
  Book(4, 'War and Peace', _mockAuthors, Category(3, 'Fiarytale'), Publisher(1, 'Sosnowo'), 'https://upload.wikimedia.org/wikipedia/commons/thumb/a/af/Tolstoy_-_War_and_Peace_-_first_edition%2C_1869.jpg/220px-Tolstoy_-_War_and_Peace_-_first_edition%2C_1869.jpg'),
  Book(2, 'The Adventures of Huckleberry Finn', _mockAuthors, Category(4, 'Detective'), Publisher(1, 'Sosnowo'), 'https://www-tc.pbs.org/wgbh/americanexperience/media/filer_public_thumbnails/filer_public/d9/27/d9276988-95ca-44d4-9ef4-83d01619ee90/banned-huckfinn-feature.jpg__350x494_q85_crop_subsampling-2_upscale.jpg'),
];