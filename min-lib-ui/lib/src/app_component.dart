import 'package:angular/angular.dart';
import './route_path.dart';
import './routes.dart';
import 'package:angular_router/angular_router.dart';

@Component(
  selector: 'my-app',
  directives: [routerDirectives],
  templateUrl: 'app_component.html',
  exports: [
    Routes,
    RoutePaths,
  ],
  styleUrls: [
    'app_component.css'
  ]
)
class AppComponent {
  var   title = 'Tour of Heroes';
}