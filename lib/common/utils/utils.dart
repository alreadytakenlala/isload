import 'dart:math' as math;

class Utils {
  static String getImgPath(String name, {String format: "png"}) {
    return "assets/images/$name.$format";
  }

  static int getColorByBase7(int base7) {
    return base7+math.pow(16,6)*15+math.pow(16,7)*15;
  }

  static dynamic find(List<dynamic> list, Function callback) {
    for (int i=0; i<list.length; i++) {
      if (callback(list[i])) return list[i];
    }
    return null;
  }
}