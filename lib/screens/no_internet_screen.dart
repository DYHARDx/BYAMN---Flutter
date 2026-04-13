import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants/assets_path.dart';
import '../core/image_configuration/image_tools.dart';
import '../core/theme/app_text_style.dart';

class NoInternetScreen extends StatelessWidget {
  const NoInternetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ImageTools.setSvgIconWidget(
                assetPath: AssetsPath.noInternetSVG,
                height: 100.h,
                width: 100.w),
            const SizedBox(height: 20),
            Text(
              'No Internet Connection',
              style: tStyleBold(),
            ),
            const SizedBox(height: 10),
            Text(
              'Please check your connection and try again.',
              style: tStyleRegular(),
            ),
          ],
        ),
      ),
    );
  }
}
