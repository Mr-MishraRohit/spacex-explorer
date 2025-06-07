import 'dart:developer';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:spacex_explorer/app/strings/string_constant.dart';

const DEBUG = kDebugMode;

class Utils {
  static Future<bool> isInternetConnected() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        Debug.setLog(StringConstant.connected);
        return true;
      } else {
        return false;
      }
    } on SocketException catch (_) {
      Debug.setLog(StringConstant.noInternetConnectionMessage);
      return false;
    }
  }
}

extension SizeExt on num {
  double get h => this * Get.height / 100;

  double get w => this * Get.width / 100;
}

class Debug {
  static void setLog(String msg) {
    if (DEBUG) log(msg);
  }
}
