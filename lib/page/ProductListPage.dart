import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_jdshop/config/Config.dart';
import 'package:flutter_jdshop/model/ProductModel.dart';
import '../utils/ScreenAdapter.dart';
import '../widget/LoadingWidget.dart';

class ProductListPage extends StatefulWidget {
  Map arguments;

  @override
  _ProductListPageState createState() => _ProductListPageState();

  ProductListPage({this.arguments});
}

class _ProductListPageState extends State<ProductListPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  ScrollController _controller = new ScrollController();
  List _productItemModels = [];

  //页数
  int _page = 1;

  //每页个数
  int _pagesize = 8;

  //排序 ：价格升序 sort=price_1 价格降序 sort=price_-1 销量升序 sort=salecount_1 销量降序 sort=salecount_-1
  String _sort = "";

  //避免重复请求数据
  bool _getDataFlag = true;

  //判断是否还有数据
  bool _hasMore = true;

  //二级导航数据
  List _subHeaderList = [
    {"id": 1, "title": "综合", "fileds": "all", "sort": -1},
    {"id": 2, "title": "销量", "fileds": 'salecount', "sort": -1},
    {"id": 3, "title": "价格", "fileds": 'price', "sort": -1},
//    {"id": 4, "title": "筛选"}
  ];

  //二级导航选中判断
  int _selectHeaderId = 1;

  @override
  void initState() {
    _getProductData();

    _controller.addListener(() {
      //_controller.position.pixels //获取滚动条滚动的高度
      //_controller.position.maxScrollExtent  //获取页面高度
      if (_controller.position.pixels >
          _controller.position.maxScrollExtent - 20) {
        if (this._getDataFlag && this._hasMore) {
          _getProductData();
        }
      }
    });
  }

  _getProductData() async {
    setState(() {
      this._getDataFlag = false;
    });
    var api;
    if(widget.arguments['keyword']==null) {
       api =
          '${Config.domain}api/plist?cid=${widget
          .arguments['cid']}&page=${_page}&pagesize=${_pagesize}&sort=${_sort}';
    }else{
      api =
      '${Config.domain}api/plist?search=${widget
          .arguments['keyword']}&page=${_page}&pagesize=${_pagesize}&sort=${_sort}';
    }
    print(api);
    var result = await Dio().get(api);
    var productlist = ProductModel.fromJson(result.data);

    if (productlist.result.length < this._pagesize) {
      setState(() {
        this._productItemModels.addAll(productlist.result);
        _page++;
        _hasMore = false;
        this._getDataFlag = true;
      });
    } else {
      setState(() {
        this._productItemModels.addAll(productlist.result);
        _page++;
        this._getDataFlag = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    ScreenAdapter.init(context);
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('商品列表'),
        actions: [
          Text(''),
        ],
      ),
      endDrawer: Drawer(
        child: Text('data'),
      ),
      body: productListWidget(),
    );
  }

  //顶部二级菜单
  Widget subHeadWidget() {
    return Positioned(
        top: 0,
        height: ScreenAdapter.setHeight(180),
        width: ScreenAdapter.setWidth(1440),
        child: Container(
          decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(
                      width: 1, color: Color.fromRGBO(233, 233, 233, 0.9)))),
          height: ScreenAdapter.setHeight(180),
          width: double.infinity,
          child: Row(
            children: this._subHeaderList.map((element) {
              return Expanded(
                flex: 1,
                child: InkWell(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(0, ScreenAdapter.setHeight(46),
                        0, ScreenAdapter.setHeight(46)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "${element['title']}",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: (this._selectHeaderId == element["id"])
                                  ? Colors.redAccent
                                  : Colors.black54),
                        ),
                        _showIcon(element['id'])
                      ],
                    ),
                  ),
                  onTap: () {
                    _subHeaderChange(element['id']);
                  },
                ),
              );
            }).toList(),
          ),
        ));
//    _scaffoldKey.currentState.openEndDrawer();
  }

  //商品列表
  Widget productListWidget() {
    return Stack(
      children: [
        //顶部二级菜单
        subHeadWidget(),
        Container(
          padding: EdgeInsets.fromLTRB(0, ScreenAdapter.setHeight(180), 0, 0),
          child: ListView.builder(
              controller: _controller,
              itemCount: this._productItemModels.length,
              itemBuilder: (context, index) {
                return productlistItemWidget(index);
              }),
        )
      ],
    );
  }

  //商品列表Item
  Widget productlistItemWidget(index) {
    String pic = this._productItemModels[index].pic;
    pic = Config.domain + pic.replaceAll('\\', '/');
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(
              ScreenAdapter.setHeight(15),
              ScreenAdapter.setHeight(30),
              ScreenAdapter.setHeight(15),
              ScreenAdapter.setHeight(15)),
          child: Container(
            height: 100,
            width: double.infinity,
            child: Row(
              children: [
                AspectRatio(
                  aspectRatio: 1 / 1,
                  child: Image(image: NetworkImage('${pic}')),
                ),
                Expanded(
                    flex: 1,
                    child: Container(
                      padding: EdgeInsets.all(ScreenAdapter.setHeight(10)),
                      width: double.infinity,
                      height: double.infinity,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${this._productItemModels[index].title}',
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            style: TextStyle(fontSize: 15),
                          ),
                          Container(
                            height: ScreenAdapter.setHeight(76),
                            margin: EdgeInsets.only(right: 10),
                            padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Color.fromRGBO(230, 230, 230, 0.9)),
                            child: Text('${index * index + 1}g'),
                          ),
                          Text(
                            '¥2${this._productItemModels[index].price}',
                            style: TextStyle(
                                color: Colors.redAccent, fontSize: 15),
                          )
                        ],
                      ),
                    ))
              ],
            ),
          ),
        ),
        Divider(),
        _showMore(index),
      ],
    );
  }

  //导航改变的时候触发
  _subHeaderChange(id) {
    if (id == 4) {
      _scaffoldKey.currentState.openEndDrawer();
      setState(() {
        this._selectHeaderId = id;
      });
    } else {
      setState(() {
        this._selectHeaderId = id;
        this._sort =
            "${this._subHeaderList[id - 1]["fileds"]}_${this._subHeaderList[id - 1]["sort"]}";

        //重置分页
        this._page = 1;
        //重置数据
        this._productItemModels = [];
        //改变sort排序
        this._subHeaderList[id - 1]['sort'] =
            this._subHeaderList[id - 1]['sort'] * -1;
        //回到顶部
        _controller.jumpTo(0);
        //重置_hasMore
        this._hasMore = true;
        //重新请求
        this._getProductData();
      });
    }
  }

//显示header Icon
  Widget _showIcon(id) {
    if (id == 2 || id == 3) {
      if (this._subHeaderList[id - 1]["sort"] == 1 &&
          id == this._selectHeaderId) {
        return Icon(
          Icons.arrow_drop_down,
          color: Colors.redAccent,
        );
      } else if (this._subHeaderList[id - 1]["sort"] == 1 &&
          id != this._selectHeaderId) {
        return Icon(
          Icons.arrow_drop_down,
          color: Colors.black54,
        );
      }
      if (this._subHeaderList[id - 1]["sort"] == -1 &&
          id == this._selectHeaderId) {
        return Icon(
          Icons.arrow_drop_up,
          color: Colors.redAccent,
        );
      } else if (this._subHeaderList[id - 1]["sort"] == -1 &&
          id != this._selectHeaderId) {
        return Icon(
          Icons.arrow_drop_up,
          color: Colors.black54,
        );
      }
    }
    return Text("");
  }

  //显示加载中的圈圈
  Widget _showMore(index) {
    if (this._hasMore) {
      return (index == this._productItemModels.length - 1)
          ? LoadingWidget()
          : Text("");
    } else {
      return (index == this._productItemModels.length - 1)
          ? Text("--没有数据了--")
          : Text("");
    }
  }
}
