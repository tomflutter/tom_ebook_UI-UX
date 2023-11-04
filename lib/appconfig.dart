import 'package:flutter/material.dart';

class AppConfig {
  BuildContext context;
  double? height;
  double? width;
  double? heightPadding;
  double? widthPadding;
  

  AppConfig(this.context) {
    MediaQueryData _queryData = MediaQuery.of(context);
    height = _queryData.size.height / 100.0;
    width = _queryData.size.width / 100.0;
    heightPadding = height! -
        ((_queryData.padding.top + _queryData.padding.bottom) / 100.0);
    widthPadding =
        width! - (_queryData.padding.left + _queryData.padding.right) / 100.0;
  }

  double rH(double v) {
    return height! * v;
  }

  double rW(double v) {
    return width! * v;
  }

  double rHP(double v) {
    return heightPadding! * v;
  }

  double rWP(double v) {
    return widthPadding! * v;
  }
}
