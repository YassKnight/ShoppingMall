import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'HomePage.dart';
import 'CategoryPage.dart';
import 'MinePage.dart';
import 'ShopCartPage.dart';

class Tabs extends StatefulWidget {
  @override
  _TabsState createState() => _TabsState();
}

class _TabsState extends State<Tabs> {
  int _curIndex = 0;
  List<Widget> _pageList = [
    HomePage(),
    CategoryPage(),
    ShopCartPage(),
    MinePage()
  ];
  PageController _pageController;

  @override
  void initState() {
    _pageController = PageController(initialPage: _curIndex);
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context,
        designSize: Size(1440, 2960), allowFontScaling: false);
    return Scaffold(
      body: PageView(
        controller: _pageController,
        children: _pageList,
        onPageChanged: (index){
         setState(() {
           this._curIndex=index;
         });
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        fixedColor: Colors.redAccent,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), title: Text('首页')),
          BottomNavigationBarItem(
              icon: Icon(Icons.category), title: Text('分类')),
//          BottomNavigationBarItem(
//              icon: Icon(Icons.whatshot), title: Text('发现')),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart), title: Text('购物车')),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            title: Text('我的'),
          ),
        ],
        type: BottomNavigationBarType.fixed,
        currentIndex: this._curIndex,
        onTap: (v) {
          setState(() {
            this._curIndex = v;
            this._pageController.jumpToPage(v);
          });
        },
      ),
    );
  }
}
