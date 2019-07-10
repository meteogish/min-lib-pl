import 'package:angular/angular.dart';
import 'package:angular_app/src/services/book_service.dart';
import 'package:angular_router/angular_router.dart';
import 'package:angular_app/src/app_component.template.dart' as entrypoint;

import 'main.template.dart' as self;

@GenerateInjector(
  [
    routerProvidersHash,
    ClassProvider(BookService, useClass: ApiBookService)
  ]
)
final InjectorFactory injector = self.injector$Injector;

void main() {
  runApp(entrypoint.AppComponentNgFactory, createInjector: injector);
}