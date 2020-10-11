import 'dart:ui';

import 'package:flutter_screenutil/screenutil.dart';

class ScreenAdapter {
  static init(context) {
    ScreenUtil.init(context,
        designSize: Size(1440, 2960), allowFontScaling: false);
  }

  //设置高度
  static setHeight(double vaule) {
    return ScreenUtil().setHeight(vaule);
  }

  //设置宽度
  static setWidth(double Vaule) {
    return ScreenUtil().setWidth(Vaule);
  }

  static getHeightPx() {
    return ScreenUtil().screenHeightPx;
  }

  static getWidthPx() {
    return ScreenUtil().screenWidth;
  }

  static size(double value) {
    return ScreenUtil().setSp(value);
  }
}
