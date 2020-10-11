import 'package:flutter/material.dart';
import 'package:flutter_jdshop/page/cart/CartItem.dart';
import '../../utils/ScreenAdapter.dart';

class ShopCartPage extends StatefulWidget {
  @override
  _ShopCartPageState createState() => _ShopCartPageState();
}

class _ShopCartPageState extends State<ShopCartPage> {
  @override
  Widget build(BuildContext context) {
    ScreenAdapter.init(context);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("购物车"),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.launch),
              onPressed: null,
            )
          ],
        ),
        body: Stack(
          children: <Widget>[
            ListView(
              children: <Widget>[CartItem(), CartItem(), CartItem()],
            ),
            Positioned(
              bottom: 0,
              width: ScreenAdapter.setWidth(1440),
              height: ScreenAdapter.setHeight(218),
              child: Container(
                decoration: BoxDecoration(
                  border:
                      Border(top: BorderSide(width: 1, color: Colors.black12)),
                  color: Colors.white,
                ),
                width: ScreenAdapter.setWidth(1440),
                height: ScreenAdapter.setHeight(218),
                child: Stack(
                  children: <Widget>[
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Row(
                        children: <Widget>[
                          Container(
                            width: ScreenAdapter.setWidth(160),
                            child: Checkbox(
                              value: true,
                              activeColor: Colors.pink,
                              onChanged: (val) {},
                            ),
                          ),
                          Text("全选")
                        ],
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(0, 0, ScreenAdapter.setWidth(40), 0),
                        child: RaisedButton(
                          child:
                              Text("结算", style: TextStyle(color: Colors.white)),
                          color: Colors.red,
                          onPressed: () {},
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
      minimum: EdgeInsets.fromLTRB(0, ScreenAdapter.setHeight(170), 0, 0),
    );
  }
}
