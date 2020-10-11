import 'package:flutter/material.dart';
import 'package:flutter_jdshop/utils/ScreenAdapter.dart';
import '../utils/ScreenAdapter.dart';
import '../utils/SearchServices.dart';

class SearchPage extends StatefulWidget {
  SearchPage({Key key}) : super(key: key);

  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  var _keyword;
  List _historyListData = [];

  @override
  void initState() {
    super.initState();
    _getHistoryData();
  }

  _getHistoryData() async {
    var historyData = await SearchServices.getHistoryList();
    setState(() {
      this._historyListData = historyData;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          child: TextField(
            autofocus: false,
            decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none)),
            onChanged: (vaule) {
              this._keyword = vaule;
            },
          ),
          height: ScreenAdapter.setHeight(118),
          width: ScreenAdapter.getWidthPx() - ScreenAdapter.setWidth(440),
          decoration: BoxDecoration(
              color: Color.fromRGBO(233, 233, 233, 0.8),
              borderRadius: BorderRadius.circular(30)),
        ),
        actions: <Widget>[
          InkWell(
            child: Container(
              height: ScreenAdapter.setHeight(118),
              width: ScreenAdapter.setWidth(220),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  IconButton(
                      icon: Icon(Icons.search, size: 28, color: Colors.black),
                      onPressed: null)
                ],
              ),
            ),
            onTap: () {
              SearchServices.setHistoryData(this._keyword);
              Navigator.pushReplacementNamed(context, '/productlist',
                  arguments: {'keyword': this._keyword});
            },
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: ListView(
          children: <Widget>[
            Container(
              child: Text("热搜", style: Theme.of(context).textTheme.title),
            ),
            Divider(),
            Wrap(
              children: <Widget>[
                InkWell(
                  onTap: () {
                    SearchServices.setHistoryData("女装");
                    Navigator.pushReplacementNamed(context, '/productlist',
                        arguments: {'keyword': '女装'});
                  },
                  child: Container(
                    padding: EdgeInsets.all(10),
                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: Color.fromRGBO(233, 233, 233, 0.9),
                        borderRadius: BorderRadius.circular(10)),
                    child: Text("女装"),
                  ),
                ),
                InkWell(
                  onTap: () {
                    SearchServices.setHistoryData("男装");
                    Navigator.pushReplacementNamed(context, '/productlist',
                        arguments: {'keyword': '男装'});
                  },
                  child: Container(
                    padding: EdgeInsets.all(10),
                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: Color.fromRGBO(233, 233, 233, 0.9),
                        borderRadius: BorderRadius.circular(10)),
                    child: Text("男装"),
                  ),
                ),
                InkWell(
                  onTap: () {
                    SearchServices.setHistoryData("笔记本电脑");
                    Navigator.pushReplacementNamed(context, '/productlist',
                        arguments: {'keyword': '笔记本电脑'});
                  },
                  child: Container(
                    padding: EdgeInsets.all(10),
                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: Color.fromRGBO(233, 233, 233, 0.9),
                        borderRadius: BorderRadius.circular(10)),
                    child: Text("笔记本电脑"),
                  ),
                ),
                InkWell(
                  onTap: () {
                    SearchServices.setHistoryData("鞋子");
                    Navigator.pushReplacementNamed(context, '/productlist',
                        arguments: {'keyword': '鞋子'});
                  },
                  child: Container(
                    padding: EdgeInsets.all(10),
                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: Color.fromRGBO(233, 233, 233, 0.9),
                        borderRadius: BorderRadius.circular(10)),
                    child: Text("鞋子"),
                  ),
                ),
                InkWell(
                  onTap: () {
                    SearchServices.setHistoryData("袜子");
                    Navigator.pushReplacementNamed(context, '/productlist',
                        arguments: {'keyword': '袜子'});
                  },
                  child: Container(
                    padding: EdgeInsets.all(10),
                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: Color.fromRGBO(233, 233, 233, 0.9),
                        borderRadius: BorderRadius.circular(10)),
                    child: Text("袜子"),
                  ),
                ),
                InkWell(
                  onTap: () {
                    SearchServices.setHistoryData("化妆品");
                    Navigator.pushReplacementNamed(context, '/productlist',
                        arguments: {'keyword': '化妆品'});
                  },
                  child: Container(
                    padding: EdgeInsets.all(10),
                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: Color.fromRGBO(233, 233, 233, 0.9),
                        borderRadius: BorderRadius.circular(10)),
                    child: Text("化妆品"),
                  ),
                ),
                InkWell(
                    onTap: () {
                      SearchServices.setHistoryData('手机');
                      Navigator.pushReplacementNamed(context, '/productlist',
                          arguments: {'keyword': '手机'});
                    },
                    child: Container(
                      padding: EdgeInsets.all(10),
                      margin: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: Color.fromRGBO(233, 233, 233, 0.9),
                          borderRadius: BorderRadius.circular(10)),
                      child: Text("手机"),
                    )),
              ],
            ),
            SizedBox(height: 10),
            _historyListWidget(),
            SizedBox(height: 70),
          ],
        ),
      ),
    );
  }

  _showAlertDialog(keywords) async {
    var result = await showDialog(
        barrierDismissible: false, //表示点击灰色背景的时候是否消失弹出框
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("提示信息!"),
            content: Text("您确定要删除吗?"),
            actions: <Widget>[
              FlatButton(
                child: Text("取消"),
                onPressed: () {
                  print("取消");
                  Navigator.pop(context, 'Cancle');
                },
              ),
              FlatButton(
                child: Text("确定"),
                onPressed: () async {
                  //注意异步
                  await SearchServices.removeHistoryData(keywords);
                  this._getHistoryData();
                  Navigator.pop(context, "Ok");
                },
              )
            ],
          );
        });

    //  print(result);
  }

  Widget _historyListWidget() {
    if (_historyListData.length > 0) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            child: Text("历史记录", style: Theme.of(context).textTheme.title),
          ),
          Divider(),
          Column(
            children: this._historyListData.map((value) {
              return Column(
                children: <Widget>[
                  ListTile(
                    title: Text("${value}"),
                    onLongPress: () {
                      this._showAlertDialog("${value}");
                    },
                  ),
                  Divider()
                ],
              );
            }).toList(),
          ),
          SizedBox(height: 100),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              InkWell(
                onTap: () {
                  SearchServices.clearHistoryList();
                  this._getHistoryData();
                },
                child: Container(
                  width: ScreenAdapter.setWidth(800),
                  height: ScreenAdapter.setHeight(124),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black45, width: 1),
                      borderRadius: BorderRadius.circular(15)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[Icon(Icons.delete), Text("清空历史记录")],
                  ),
                ),
              )
            ],
          )
        ],
      );
    } else {
      return Text("");
    }
  }
}
