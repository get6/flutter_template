import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'dart:io' show Platform;

class PlatformWidget {
  Widget platformProgressIndicator() {
    if (isMobile()) {
      return whichMobile()
          ? CircularProgressIndicator()
          : CupertinoActivityIndicator();
    }
    return LinearProgressIndicator();
  }

  bool whichOS() {
    return Platform.isWindows;
  }

  bool isMobile() {
    return Platform.isAndroid || Platform.isIOS;
  }

  bool isOS() {
    return Platform.isWindows ||
        Platform.isFuchsia ||
        Platform.isLinux ||
        Platform.isMacOS;
  }

  bool whichMobile() {
    return Platform.isAndroid;
  }
}
