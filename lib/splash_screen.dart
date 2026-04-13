import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'constants/assets_path.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(AssetsPath.logoImagePath, height: 120.h),
            SizedBox(height: 16.h),
            Text(
              'BYAMN',
              style: TextStyle(fontSize: 28.h, fontWeight: FontWeight.w800),
            ),
            SizedBox(height: 12.h),
            SizedBox(
              width: 160.w,
              child: const LinearProgressIndicator(),
            ),
          ],
        ),
      ),
    );
  }
}
