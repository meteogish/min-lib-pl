import 'dart:convert';

import 'package:angular_app/src/models/models.dart';
import 'package:angular_app/src/services/book_service.dart';
import 'package:test/test.dart';

void main() {
  test('book serialization test', () {
    String jsonString = '''
      {
    "id": 16,
    "title": "War and Peace",
    "imageUrl": "https://upload.wikimedia.org/wikipedia/commons/thumb/a/af/Tolstoy_-_War_and_Peace_-_first_edition%2C_1869.jpg/220px-Tolstoy_-_War_and_Peace_-_first_edition%2C_1869.jpg",
    "category": {
      "id": 1002,
      "name": "Drama"
    },
    "position": {
      "id": 1,
      "description": "lewa pulka"
    },
    "publisher": {
      "id": 3,
      "name": "Wolters Kluwer"
    },
    "authors": [
      {
        "id": 1004,
        "name": "Leo",
        "surname": "Tolstoy"
      }
    ]
  }''';

    Map json = jsonDecode(jsonString);

    Book book = Book.fromJson(json);

    expect(book.id, 16);

  });

  test('from api test', () async {
    var service = ApiBookService();

    var books = await service.search(BooksFilter()..titleMatch='anna');

    expect(books.length, 1);

  });
}