

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ImageTools {
  static Widget setSvgIconWidget({required String assetPath, Color? color, double? height, double? width}) {
    final Widget svg;
    svg = SvgPicture.asset(assetPath,
        semanticsLabel: 'Logo',
        colorFilter: color != null ? ColorFilter.mode(color, BlendMode.srcIn) : null,
        height: height,
        width: width);
    return svg;
  }

  /// set gif files
  static Widget setGifWidget({required String assetPath, double? height, double? width}) {
    final Widget gifFile;
    gifFile = Image.asset(
      assetPath,
      height: height,
      width: width,
      fit: BoxFit.cover,
    );
    return gifFile;
  }

  /// set Network Image
  static setCachedNetworkImage(String? imageUrl, {String? plashHolder, BoxFit? boxFit, double? height, double? width}) {
    return CachedNetworkImage(
      imageUrl: imageUrl != null && imageUrl.isNotEmpty ? imageUrl : "",
      fit: boxFit ?? BoxFit.contain,
      width: width,
      height: height,
      placeholder: (context, url) =>
          FittedBox(fit: BoxFit.contain, child: Image.asset(plashHolder ?? 'assets/logo.png')),
      errorWidget: (context, error, stackTrace) {
        return FittedBox(fit: BoxFit.contain, child: Image.asset('assets/logo.png'));
      },
    );
  }
}