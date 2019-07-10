import 'package:angular_router/angular_router.dart';

const idParam = 'id';

class RoutePaths {
  static final books = RoutePath(path: 'books');
  static final author = RoutePath(path: 'author/:id');

}