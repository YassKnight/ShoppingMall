import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_jdshop/model/FocusModel.dart';
import 'package:flutter_jdshop/model/ProductModel.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import '../../utils/ScreenAdapter.dart';
import '../../utils/SimulationData.dart';
import '../../config/Config.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  List _focusItemData = new List<FocusItemModel>();
  List _productHotItemDta = List<ProductItemModel>();
  List _productBestItemDta = List<ProductItemModel>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getFocusData('${Config.domain}api/focus');
    _getProductHotData('${Config.domain}api/plist?is_hot=1');
    _getProductBestData('${Config.domain}api/plist?is_best=1');
  }

  //获取轮播图数据
  _getFocusData(String url) async {
    var response = await Dio().get(url);
    var _focusData = FocusModel.fromJson(response.data);

    setState(() {
      this._focusItemData = _focusData.result;
    });
  }

  //获取‘猜你喜欢’数据
  _getProductHotData(String url) async {
    var response = await Dio().get(url);
    var _productData = ProductModel.fromJson(response.data);

    setState(() {
      this._productHotItemDta = _productData.result;
      print(this._productHotItemDta.length);
    });
  }

  //获取‘热门推荐’数据
  _getProductBestData(String url) async {
    var response = await Dio().get(url);
    var _productData = ProductModel.fromJson(response.data);

    setState(() {
      this._productBestItemDta = _productData.result;
      print(this._productBestItemDta.length);
    });
  }

  @override
  Widget build(BuildContext context) {
    ScreenAdapter.init(context);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
              icon:
                  Icon(Icons.center_focus_weak, size: 28, color: Colors.black),
              onPressed: null),
          title: InkWell(
            child: Container(
              child: Row(
                children: <Widget>[
                  Icon(Icons.search,
                      size: ScreenAdapter.setHeight(52), color: Colors.black54),
                  Text("笔记本",
                      style: TextStyle(fontSize: ScreenAdapter.size(48)))
                ],
              ),
              height: ScreenAdapter.setHeight(122),
              width: double.infinity,
              padding: EdgeInsets.fromLTRB(ScreenAdapter.setWidth(28), 0, 0, 0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Color.fromRGBO(233, 233, 233, 0.9),
              ),
            ),
            onTap: () {
              Navigator.pushNamed(context, '/search');
            },
          ),
          actions: <Widget>[
            Stack(
              alignment: AlignmentDirectional.center,
              children: <Widget>[
                IconButton(
                    icon: Icon(Icons.message, size: 28, color: Colors.black),
                    onPressed: null)
              ],
            ),
            Text(" ")
          ],
        ),
        body: ListView(
          children: [
            swiperWidget(_focusItemData),
            SizedBox(
              height: ScreenAdapter.setHeight(20),
            ),
            titleWidget("猜你喜欢"),
            SizedBox(height: ScreenAdapter.setHeight(20)),
            hrizontalView(_productHotItemDta),
            SizedBox(height: ScreenAdapter.setHeight(20)),
            titleWidget("热门推荐"),
            SizedBox(height: ScreenAdapter.setHeight(20)),
            hotShopWidget(_productBestItemDta, context)
          ],
        ),
      ),
      top: true,
      bottom: false,
      left: false,
      right: false,
      minimum: EdgeInsets.fromLTRB(0, ScreenAdapter.setHeight(170), 0, 0),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

/**
 * 轮播图
 */
Widget swiperWidget(List focusItemData) {
  var _photoList = focusItemData;
  if (_photoList.length > 0) {
    return AspectRatio(
        aspectRatio: 2 / 1,
        child: Swiper(
          itemCount: 3,
          autoplay: true,
          //自动播放
          loop: true,
          //循环播放
          pagination: SwiperPagination(),
          itemBuilder: (BuildContext context, int index) {
            String pic = focusItemData[index].pic;
            return new Image.network(
              "${Config.domain}${pic.replaceAll('\\', '/')}",
              fit: BoxFit.fill,
            );
          },
        ));
  } else {
    return Text('加载中...');
  }
}

/**
 * 标题栏
 */
Widget titleWidget(String title) {
  return Container(
    margin: EdgeInsets.only(
        left: ScreenAdapter.setWidth(20),
        top: ScreenAdapter.setHeight(20),
        bottom: ScreenAdapter.setHeight(20)),
    padding: EdgeInsets.only(left: ScreenAdapter.setWidth(20)),
    decoration: BoxDecoration(
        border: Border(
            left: BorderSide(
                color: Colors.red, width: ScreenAdapter.setWidth(8)))),
    child: Text(
      title,
      style: TextStyle(color: Colors.grey),
    ),
  );
}

/**
 *‘猜你喜欢’横向滚动布局
 */
Widget hrizontalView(List productHotItemDta) {
  var _dataList = DataUtil.userLikeList;
  if (productHotItemDta.length > 0) {
    return Container(
      margin: EdgeInsets.fromLTRB(
          ScreenAdapter.setWidth(21), 0, ScreenAdapter.setWidth(21), 0),
      height: ScreenAdapter.setWidth(400),
      width: double.infinity,
      child: ListView.builder(
          itemCount: productHotItemDta.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            String pic = productHotItemDta[index].sPic;
            pic = '${Config.domain}${pic.replaceAll('\\', '/')}';
            return Column(
              children: [
                Container(
                  height: ScreenAdapter.setHeight(240),
                  width: ScreenAdapter.setWidth(240),
                  margin: EdgeInsets.only(right: ScreenAdapter.setWidth(21)),
                  child: Image.network(pic, fit: BoxFit.cover),
                ),
                Container(
                  padding: EdgeInsets.only(top: ScreenAdapter.setHeight(20)),
                  height: ScreenAdapter.setHeight(80),
                  child: Text(
                    "${productHotItemDta[index].price}",
                    style: TextStyle(color: Colors.redAccent),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: ScreenAdapter.setHeight(20)),
                  height: ScreenAdapter.setHeight(80),
                  child: Text(
                    "${productHotItemDta[index].oldPrice}",
                    style: TextStyle(
                        color: Colors.grey,
                        decoration: TextDecoration.lineThrough),
                  ),
                ),
              ],
            );
          }),
    );
  } else {
    return Text('加载数据中...');
  }
}

/**
 * ‘热门推荐’竖向滚动布局
 */
Widget hotShopWidget(List productBestItemDta, BuildContext context) {
  if (productBestItemDta.length > 0) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(
          ScreenAdapter.setWidth(20), 0, ScreenAdapter.setWidth(10), 0),
      child: Wrap(
        runSpacing: 10,
        spacing: 10,
        children: productBestItemDta.map((value) {
          return hotShopItemWidget(
              '${Config.domain}${(value.sPic).replaceAll('\\', '/')}',
              value.title,
              '${value.price}',
              value.oldPrice,
              context,
              value.sId);
        }).toList(),
      ),
    );
  } else {
    return Text('加载数据中...');
  }
}

Widget hotShopItemWidget(String imgUrl, String describe, String price,
    String originalPrice, BuildContext context, var sId) {
  var itemWidth = (ScreenAdapter.getWidthPx() - 20) / 2;

  return InkWell(
    onTap: () {
      Navigator.pushNamed(context, '/productContent', arguments: {'id': sId});
    },
    child: Container(
      width: itemWidth,
      padding: EdgeInsets.all(ScreenAdapter.setWidth(24)),
      decoration: BoxDecoration(
          border:
              Border.all(color: Color.fromRGBO(233, 233, 233, 0.9), width: 1)),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            child: AspectRatio(
              //防止服务器返回的图片大小不一致导致高度不一致问题
              aspectRatio: 1 / 1,
              child: Image.network(
                "${imgUrl}",
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
              padding: EdgeInsets.all(
                ScreenAdapter.setWidth(10),
              ),
              child: Text(
                "${describe}",
                style: TextStyle(
                  color: Colors.black54,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              )),
          Padding(
              padding: EdgeInsets.all(
                ScreenAdapter.setWidth(10),
              ),
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      '¥' + price,
                      style: TextStyle(color: Colors.redAccent),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      '¥' + originalPrice,
                      style: TextStyle(
                        color: Colors.black54,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                  ),
                ],
              ))
        ],
      ),
    ),
  );
}
