import 'package:flutter/material.dart';


class ProductContentThird extends StatefulWidget {
  @override
  _ProductContentThirdState createState() => _ProductContentThirdState();
}

class _ProductContentThirdState extends State<ProductContentThird> with AutomaticKeepAliveClientMixin{
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
