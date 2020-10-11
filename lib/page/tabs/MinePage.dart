import 'package:flutter/material.dart';
import '../../utils/ScreenAdapter.dart';

class MinePage extends StatefulWidget {
  @override
  _MinePageState createState() => _MinePageState();
}

class _MinePageState extends State<MinePage> {
  @override
  Widget build(BuildContext context) {
    ScreenAdapter.init(context);
    return SafeArea(
      child: Scaffold(
        body: Container(
          color: Colors.redAccent,
        ),
      ),
      minimum: EdgeInsets.fromLTRB(0, ScreenAdapter.setHeight(170), 0, 0),
    );
  }
}
