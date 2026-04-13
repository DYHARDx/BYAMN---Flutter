import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppScreenUtil {
  static bool isMobile(BuildContext context) => MediaQuery.sizeOf(context).width < 700;

  static bool isTablet(BuildContext context) {
    final double width = MediaQuery.sizeOf(context).width;
    return width >= 700 && width < 1100;
  }

  static double horizontalPadding(BuildContext context) {
    if (isTablet(context)) return 24.w;
    if (!isMobile(context)) return 40.w;
    return 16.w;
  }

  static int adaptiveGridCount(BuildContext context) {
    if (!isMobile(context) && !isTablet(context)) return 4;
    if (isTablet(context)) return 2;
    return 1;
  }
}
