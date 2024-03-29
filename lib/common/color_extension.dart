import "package:flutter/material.dart";

class Tcolor {
  static Color get primaryColor1 => const Color(0xff92A3FD);
  static Color get primaryColor2 => const Color(0xff9DCEFF);

  static Color get secondaryColor1 => const Color(0xffC58BF2);
  static Color get secondaryColor2 => const Color(0xffEEA4CE);

  static List<Color> get primaryG => [primaryColor2, primaryColor1];
  static List<Color> get secondaryG => [secondaryColor1, secondaryColor2];

  static Color get black => const Color(0xff1D1617);
  static Color get grey => const Color(0xff7B6F72);
  static Color get white => Colors.white;

  static Color get ligthGrey => const Color(0xffF7f8f8);
}
