import 'package:flutter/material.dart';
import '../page/tabs/Tabs.dart';
import '../page/tabs/HomePage.dart';
import '../page/tabs/CategoryPage.dart';
import '../page/tabs/MinePage.dart';
import '../page/tabs/ShopCartPage.dart';
import '../page/ProductListPage.dart';
import '../page/SearchPage.dart';
import '../page/productContent/ProductContentPage.dart';

//配置路由
final routes = {
  '/': (context) => Tabs(),
  '/home': (context) => HomePage(),
  '/category': (context) => CategoryPage(),
  '/shopcart': (context) => ShopCartPage(),
  '/mine': (context) => MinePage(),
  '/search': (context) => SearchPage(),
  '/productlist': (context, {arguments}) =>
      ProductListPage(arguments: arguments),
  '/productContent': (context, {arguments}) =>
      ProductContentPage(arguments: arguments),
};

//固定写法
var onGenerateRoute = (RouteSettings settings) {
// 统一处理
  final String name = settings.name;
  final Function pageContentBuilder = routes[name];
  if (pageContentBuilder != null) {
    if (settings.arguments != null) {
      final Route route = MaterialPageRoute(
          builder: (context) =>
              pageContentBuilder(context, arguments: settings.arguments));
      return route;
    } else {
      final Route route =
          MaterialPageRoute(builder: (context) => pageContentBuilder(context));
      return route;
    }
  }
};
