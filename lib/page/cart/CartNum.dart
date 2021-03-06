import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_jdshop/utils/ScreenAdapter.dart';

class CartNum extends StatefulWidget {
  CartNum({Key key}) : super(key: key);

  _CartNumState createState() => _CartNumState();
}

class _CartNumState extends State<CartNum> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenAdapter.setWidth(254),
      decoration:
      BoxDecoration(border: Border.all(width: 1, color: Colors.black12)),
      child: Row(
        children: <Widget>[
          _leftBtn(),
          _centerArea(),
          _rightBtn()
        ],
      ),
    );
  }

  //左侧按钮

  Widget _leftBtn() {
    return InkWell(
      onTap: () {},
      child: Container(
        alignment: Alignment.center,
        width: ScreenAdapter.setWidth(75),
        height: ScreenAdapter.setHeight(75),
        child: Text("-"),
      ),
    );
  }

  //右侧按钮
  Widget _rightBtn() {
    return InkWell(
      onTap: (){


      },
      child: Container(
        alignment: Alignment.center,
        width: ScreenAdapter.setWidth(75),
        height: ScreenAdapter.setHeight(75),
        child: Text("+"),
      ),
    );
  }

//中间
  Widget _centerArea() {
    return Container(
      alignment: Alignment.center,
      width: ScreenAdapter.setWidth(90),
      decoration: BoxDecoration(
          border: Border(
            left: BorderSide(width: 1, color: Colors.black12),
            right: BorderSide(width: 1, color: Colors.black12),
          )),
      height: ScreenAdapter.setHeight(75),
      child: Text("1"),
    );
  }
}
