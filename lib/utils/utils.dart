import 'package:flutter/material.dart';

class Utils {
  static SnackBar getSnackBar({@required String content}) {
    return SnackBar(
      content: Text(content),
      action: SnackBarAction(label: 'Report', onPressed: () => {}),
    );
  }
}
