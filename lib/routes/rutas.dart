import 'package:flutter/material.dart';
import 'package:users_test/pages/home_page.dart';
import 'package:users_test/pages/user_post.dart';

Map<String, WidgetBuilder> generateRoutes() {
  return {
    // 'home': (BuildContext context) => Home(),
    'home': (BuildContext context) => const HomePage(),
    'userPost': (BuildContext context) => UserPost(),
  };
}
