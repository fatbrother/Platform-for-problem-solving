import 'package:flutter/cupertino.dart';
import '../pages/home_page.dart';
// import pages here
// import 'pages/[page file name].dart';

class Routes {
  static const String _home = '/index';
  // add routes here
  // static const String _[route name] = '/[route name]';

  static Map<String, WidgetBuilder> get routes => {
        _home: (context) => const HomePage(),
        // add routes here
        // '/[route name]': (context) => const [page name](),
      };

  static String get home => _home;
}