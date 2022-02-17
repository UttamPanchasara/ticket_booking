import 'package:flutter/foundation.dart';

class LogsUtil {
  LogsUtil._privateConstructor();

  static final LogsUtil instance = LogsUtil._privateConstructor();

  void printLog(String log) {
    if (kDebugMode) {
      print(log);
    }
  }
}
