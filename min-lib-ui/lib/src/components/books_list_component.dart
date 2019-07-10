import 'dart:async';

import 'package:angular/angular.dart';
import 'package:angular_app/src/models/book.dart';
import 'package:angular_app/src/services/book_service.dart';
import 'package:angular_components/angular_components.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:angular_router/angular_router.dart';
import 'package:stream_transform/stream_transform.dart' as transform;
import '../models/author.dart';
import '../route_path.dart';

@Component(
  selector: 'books-list-component',
  templateUrl: '../templates/books_list_component.html',
  directives: [
    MaterialListComponent,
    MaterialListItemComponent,
    formDirectives,
    coreDirectives,
  ],
  providers: [
    materialProviders,
  ],
  styleUrls: [
    '../styles/books_list_component.css',
  ],
  pipes: [commonPipes],
)
class BooksListComponent implements OnInit, OnActivate {
  Stream<List<Book>> books;

  BookService _bookService;
  final Router _router;

  StreamController<String> _searchTerms = StreamController<String>.broadcast(); 

  BooksListComponent(this._bookService, this._router);

  void search(String term)  => _searchTerms.add(term.trim());

  @override
  void ngOnInit() async {

    books = _searchTerms.stream
                .transform(transform.debounce(Duration(milliseconds: 300)))
                .distinct()
                .transform(transform.switchMap((term) => term.isEmpty ?
                    _bookService.getAll().asStream() :
                    _bookService.search(BooksFilter()..titleMatch = term).asStream()
                    ))
                .handleError((e) => {
                  print(e)
                });
  }

  @override
  void onActivate(RouterState previous, RouterState current) {
    _searchTerms.add('');    
  }

  Future<NavigationResult> goToAuthor(Author author) {
    return _router.navigate(RoutePaths.author.toUrl(parameters: {'id' : '${author?.id ?? 1}'}));
  }
}

