import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';

REQUEST_PRINT({required var body, required var url}) {
  PRINT_LOGS('REQUEST_PARAM>>>', jsonEncode(body));
  PRINT_LOGS('URL>>>', url);
}

PRINT_LOGS(String title, String msg) {
  bool isLog = kReleaseMode ? false : true;
  if (kIsWeb) {
    title = title;
    msg = msg;
  } else if (Platform.isIOS) {
    title = title;
    msg = msg;
  } else {
    title = '\x1B[32m $title\x1B[0m';
    msg = '\x1B[34m$msg\x1B[0m';
  }
  if (isLog) {
    printLongString('$title--->>> $msg');
  }
}

/// Print Long String...
void printLongString(String text) {
  final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
  pattern.allMatches(text).forEach((match) => print(match.group(0)));
}