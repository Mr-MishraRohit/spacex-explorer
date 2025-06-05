import 'dart:developer';
import 'dart:io';

import 'package:flutter/foundation.dart';

const DEBUG = kDebugMode;
class Utils{

  static Future<bool> isInternetConnected() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        Debug.setLog('connected');
        return true;
      } else {
        return false;
      }
    } on SocketException catch (_) {
      Debug.setLog('not connected');
      return false;
    }
  }
}


class Debug {
  static void setLog(String msg) {
    if (DEBUG) log(msg);

  }
}