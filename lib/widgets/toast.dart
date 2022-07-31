import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class DisplayToast {
  void showToast(String message, Color color) => Fluttertoast.showToast(
        msg: message,
        backgroundColor: color,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
      );
}
