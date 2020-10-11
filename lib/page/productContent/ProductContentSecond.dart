import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

import '../../config/Config.dart';

class ProductContentSecond extends StatefulWidget {
  final List _productContentList;

  ProductContentSecond(this._productContentList, {Key key}) : super(key: key);

  @override
  _ProductContentSecondState createState() => _ProductContentSecondState();
}

class _ProductContentSecondState extends State<ProductContentSecond>
    with AutomaticKeepAliveClientMixin {
  var _id;

  @override
  void initState() {
    super.initState();
    this._id = widget._productContentList[0].sId;
    print("${Config.domain}pcontent?id=${_id}");
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Expanded(
            child: InAppWebView(
              initialUrl: "${Config.domain}pcontent?id=${_id}",
//              initialHeaders: {},
//              initialOptions: InAppWebViewGroupOptions(
//                  crossPlatform: InAppWebViewOptions(
//                debuggingEnabled: true,
//              )),
              onProgressChanged:
                  (InAppWebViewController controller, int progress) {
                setState(() {});
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
