import '../app_constants/enums/index.dart';

class APIPathHelper {
  static String getValue(APIPath path) {
    switch (path) {
      case APIPath.products:
        return "/products";
      default:
        return "";
    }
  }
}