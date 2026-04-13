import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

showCustomToastError(context, text) {
  var fToast = FToast();
  String textToShow = text;
  fToast.init(context);
  Widget toast = Container(
    padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(25.0),
      color: Colors.redAccent,
    ),
    child: Text(textToShow, style: const TextStyle(color: Colors.white)),
  );

  fToast.showToast(
    child: toast,
    gravity: ToastGravity.TOP,
    toastDuration: const Duration(seconds: 3),
  );
}

showCustomToastSuccess(context, text) {
  var fToast = FToast();
  String textToShow = text;
  fToast.init(context);
  Widget toast = Container(
    padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(25.0),
      color: const Color.fromARGB(255, 0, 130, 9),
    ),
    child: Text(textToShow, style: const TextStyle(color: Colors.white)),
  );

  fToast.showToast(
    child: toast,
    gravity: ToastGravity.TOP,
    toastDuration: const Duration(seconds: 3),
  );
}
