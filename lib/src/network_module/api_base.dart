
import 'package:flutter/foundation.dart';

class APIBase {
  static String get baseURL {
    if (kReleaseMode) {
      return "";
    } else {
      return "";
    }
  }

  //https://api.dang-app.com/api/v1/
  //Dev
  //https://dev.dang-app.com/api/v1/

}