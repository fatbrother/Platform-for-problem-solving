// When we are adding a new page, we need to add it to the routes map.

import 'package:flutter/cupertino.dart';
import '../pages/home_page.dart';
// import pages here
// import 'pages/[page file name].dart';

class Routes {
  static const String home = '/index';
  // add routes here
  // static const String [route name] = '/[route name]';

  final Map<String, WidgetBuilder> _routes = {
    home: (context) => const HomePage(),
    // add routes here
    // [route name]: (context) => const [page name](),
  };

  static Map<String, WidgetBuilder> get routes => Routes()._routes;
}