import 'dart:convert';

import 'package:angular_app/src/models/book.dart';
import 'package:http/http.dart' as http;

class BookService {
  Future<List<Book>> getAll() async => Future.value(mockBooks);

  Future<List<Book>> search(BooksFilter filter) => Future.value(mockBooks.where((h) => h.title.toLowerCase().contains(filter.titleMatch.toLowerCase())).toList());
  
}

class ApiBookService implements BookService{
  @override
  Future<List<Book>> getAll() async => _getFromApi(null);

  @override
  Future<List<Book>> search(BooksFilter filter) async => _getFromApi(filter);


  Future<List<Book>> _getFromApi(BooksFilter filter) async {

    Map<String, String> queryParameters = {
    };

    if (filter?.titleMatch != null) {
      queryParameters['title'] = filter.titleMatch;
    }

    if(filter?.authorId != null) {
      queryParameters['authorId'] = filter.authorId.toString();
    }

    var uri =
      Uri.http('localhost:4567', '/books', queryParameters);

    http.Response response = await http.get(uri);

    if (response.statusCode == 200) {
      return (jsonDecode(response.body) as List).map((json) => Book.fromJson(json)).toList();
    }
    else {
      print('Error during request: ${response.reasonPhrase}' );
      throw Exception('Error request');
    }
  }
}

class BooksFilter {
  String titleMatch;
  int authorId;
}
