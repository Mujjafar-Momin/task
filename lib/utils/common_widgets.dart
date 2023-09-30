import 'package:flutter/material.dart';

import 'alert_bar.dart';

class Utils {
    Utils._();

  static final Utils _instance = Utils._();
  static Utils get widget => _instance;

  static void CustomAlertBar(
      {required context,
      required String title,
      required String description,
      Color? color}) {
    return AlertBar.show(context,
        title: title, description: description, backgroundColor: color);
  }
}
