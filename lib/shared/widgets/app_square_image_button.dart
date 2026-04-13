import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SquareImageButton extends StatelessWidget {
  final String assetPath; // path to the icon image (e.g. 'assets/google.png')
  final VoidCallback onTap;
  final String tooltip;

  const SquareImageButton({
    super.key,
    required this.assetPath,
    required this.onTap,
    required this.tooltip,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(4),
      child: Ink(
        width: 58.h,
        height: 58.h,
        decoration: BoxDecoration(
          // color: Colors.white,
          borderRadius: BorderRadius.circular(4),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Tooltip(
          message: tooltip,
          child: Center(
            child: Image.asset(
              assetPath,
              width: 24,
              height: 24,
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }
}
