import 'package:angular_app/src/route_path.dart';
import 'package:angular_router/angular_router.dart';

import 'components/books_list_component.template.dart' as books_list_component;
import 'components/author_component.template.dart' as author_component;

export 'route_path.dart';

class Routes {
  static final books = RouteDefinition(
    routePath: RoutePaths.books,
    component: books_list_component.BooksListComponentNgFactory,
    useAsDefault: true
  );

  static final author = RouteDefinition(
    routePath: RoutePaths.author,
    component: author_component.AuthorComponentNgFactory,
  );

  static final all = <RouteDefinition>[
    books,
    author,
  ];
}