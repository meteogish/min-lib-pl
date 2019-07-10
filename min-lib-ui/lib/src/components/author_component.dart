import 'package:angular/angular.dart';
import 'package:angular_app/src/models/book.dart';
import 'package:angular_app/src/services/book_service.dart';
import 'package:angular_components/material_list/material_list.dart';
import 'package:angular_components/material_list/material_list_item.dart';
import 'package:angular_router/angular_router.dart';
import 'package:angular_forms/angular_forms.dart';

@Component(
  selector: 'author-component',
  templateUrl: '../templates/author_component.html',
  directives: [
    MaterialListComponent,
    MaterialListItemComponent,
    formDirectives,
    coreDirectives,
  ],
  styleUrls: [
    '../styles/books_list_component.css',
  ],
)
class AuthorComponent implements OnActivate {
  final BookService _bookService;
  List<Book> books = null;

  AuthorComponent(this._bookService);

  @override
  Future onActivate(_, RouterState current) async {
    final id = _getId(current.parameters);
    if(id != null) {
      books = await _bookService.search(BooksFilter()..authorId = id);
    }
  }

  int _getId(Map<String, String> parameters){
    final id = parameters['id'];
    return id == null ? null : int.tryParse(id);
  }
  
}
