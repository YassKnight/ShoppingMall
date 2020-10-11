import 'package:flutter/material.dart';
import 'page/tabs/Tabs.dart';
import 'routes/Routes.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, //关闭debug横幅显示
      theme: ThemeData(
          bottomNavigationBarTheme:
              BottomNavigationBarThemeData(backgroundColor: Colors.white),primaryColor: Colors.white),
//      home: Tabs(),
      initialRoute: '/',
      onGenerateRoute: onGenerateRoute,
    );
  }
}
