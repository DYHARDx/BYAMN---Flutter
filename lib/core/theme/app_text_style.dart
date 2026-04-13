import 'package:byamn/constants/app_constants.dart';
import 'package:flutter/material.dart';

import 'app_color.dart';
import 'app_string_dimensions.dart';

/// font style
tStyleBold({color, weight, fontSize, spacing}) {
  return TextStyle(
    fontSize: fontSize ?? Dimen.FONT_SIZE_MEDIUM,
    color: color ?? kTextBlack,
    fontFamily: AppConstants.TitilliumWebBold,
    letterSpacing: spacing ?? 0.14,
    fontWeight: weight ?? FontWeight.w700, // default weight for bold is 700
  );
}

tStyleSemiBold({color, weight, fontSize, spacing, height}) {
  return TextStyle(
    fontSize: fontSize ?? Dimen.FONT_SIZE_MEDIUM,
    color: color ?? kTextBlack,
    height: height ?? 1.0,

    fontFamily: AppConstants.TitilliumWebSemiBold,
    letterSpacing: spacing ?? 0.14,
    fontWeight: weight ?? FontWeight.w600, // default weight for bold is 600
  );
}

tStyleExtraLight({color, weight, fontSize, spacing, height}) {
  return TextStyle(
    fontSize: fontSize ?? Dimen.FONT_SIZE_MEDIUM,
    letterSpacing: spacing ?? 0.14,
    color: color ?? kTextBlack,
    fontFamily: AppConstants.TitilliumWebExtraLight,
    height: height ?? 1,
    fontWeight: weight ?? FontWeight.w100, //
    // default weight for medium is 500
  );
}

tStyleRegular({color, weight, fontSize}) {
  return TextStyle(
    letterSpacing: 0.14,
    fontSize: fontSize ?? Dimen.FONT_SIZE_MEDIUM,
    color: color ?? kTextBlack,
    decoration: TextDecoration.none,

    fontFamily: AppConstants.TitilliumWebRegular,
    fontWeight:
        weight ?? FontWeight.normal, // default weight for reguler is normal
  );
}

///

// Text("The Lazy dog jump over the great wall."),
// Text("The Lazy dog jump over the great wall.",style: tStyleExtraLight(),),
// Text("The Lazy dog jump over the great wall.",style: tStyleRegular(),),
// Text("The Lazy dog jump over the great wall.",style: tStyleBold(),),
// Text("The Lazy dog jump over the great wall.",style: tStyleSemiBold(),),
// Text("The Lazy dog jump over the great wall.",style: tStyleExtraLight(),),
