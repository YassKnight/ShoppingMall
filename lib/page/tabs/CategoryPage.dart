import 'package:flutter/material.dart';
import 'package:flutter_jdshop/model/CateModel.dart';
import '../../utils/ScreenAdapter.dart';
import 'package:dio/dio.dart';
import '../../config/Config.dart';

class CategoryPage extends StatefulWidget {
  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage>
    with AutomaticKeepAliveClientMixin {
  List _cateItemModels = [];
  List _cateRightItemModels = [];
  var leftItemwidth = ScreenAdapter.getWidthPx() / 4;
  var cIndex = 0;

  @override
  void initState() {
    super.initState();
    _getLeftCategoryData();
  }

  _getLeftCategoryData() async {
    var result = await Dio().get('${Config.domain}api/pcate');
    var cateModel = CateModel.fromJson(result.data);

    setState(() {
      this._cateItemModels = cateModel.result;
    });
    _getRightCategoryData(cateModel.result[0].sId);
  }

  _getRightCategoryData(pid) async {
    var api = '${Config.domain}api/pcate?pid=${pid}';
    var result = await Dio().get(api);
    var rightCateList = new CateModel.fromJson(result.data);
    setState(() {
      this._cateRightItemModels = rightCateList.result;
    });
  }

  @override
  Widget build(BuildContext context) {
    ScreenAdapter.init(context);
    return SafeArea(child:  Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.center_focus_weak, size: 28, color: Colors.black),
            onPressed: null),
        title: InkWell(
          child: Container(
            child: Row(
              children: <Widget>[
                Icon(Icons.search,
                    size: ScreenAdapter.setHeight(52), color: Colors.black54),
                Text("笔记本", style: TextStyle(fontSize: ScreenAdapter.size(48)))
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
      body: Row(
        children: [
          //左侧类别
          _leftWidget(),
          //右侧视图
          _rightWidget(),
        ],
      ),
    ),minimum: EdgeInsets.fromLTRB(0, ScreenAdapter.setHeight(170), 0, 0),);
  }

  //左侧类别
  Widget _leftWidget() {
    if (_cateItemModels.length > 0) {
      return Container(
        width: leftItemwidth,
        height: double.infinity,
        child: ListView.builder(
            itemCount: _cateItemModels.length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  InkWell(
                    onTap: () {
                      setState(() {
                        cIndex = index;
                        _getRightCategoryData(this._cateItemModels[index].sId);
                      });
                    },
                    child: Container(
                      width: double.infinity,
                      height: ScreenAdapter.setHeight(158),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: cIndex == index
                              ? Color.fromRGBO(240, 246, 246, 0.9)
                              : Colors.white),
                      child: Text(
                        '${_cateItemModels[index].title}',
                        style: TextStyle(
                            color: cIndex == index
                                ? Colors.redAccent
                                : Colors.black),
                      ),
                    ),
                  ),
                  Divider(
                    height: 1,
                  ),
                ],
              );
            }),
      );
    } else {
      return Text('正在加载...');
    }
  }

  //右侧视图
  Widget _rightWidget() {
    var _rightItemWidth = (ScreenAdapter.getWidthPx() - 40) / 3;
    var _rightItemHeight = _rightItemWidth + ScreenAdapter.setHeight(78);
    if (this._cateRightItemModels.length > 0) {
      return Expanded(
        flex: 1,
        child: Container(
          padding: EdgeInsets.all(ScreenAdapter.setWidth(20)),
          height: double.infinity,
          width: double.infinity,
          color: Color.fromRGBO(240, 246, 246, 0.9),
          child: GridView.builder(
              itemCount: this._cateRightItemModels.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  childAspectRatio: 1 / 1.2),
              itemBuilder: (context, index) {
                var pic = this._cateRightItemModels[index].pic;
                pic = pic.replaceAll('\\', '/');
                return InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, '/productlist', arguments: {
                      'cid': this._cateRightItemModels[index].sId
                    });
                  },
                  child: Container(
                    width: _rightItemWidth,
                    height: _rightItemHeight,
                    child: Column(
                      children: [
                        AspectRatio(
                          aspectRatio: 1 / 1,
                          child: Image.network('${Config.domain}${pic}'),
                        ),
                        Container(
                          height: ScreenAdapter.setHeight(68),
                          child:
                              Text('${this._cateRightItemModels[index].title}'),
                        )
                      ],
                    ),
                  ),
                );
              }),
        ),
      );
    } else {
      return Text('正在加载...');
    }
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
