/* Flutter Imports */
import 'package:flutter/material.dart';

class Palette {
  static const Color primary = Color.fromARGB(255, 3, 165, 60);
  static const Color secondary = Color.fromARGB(255, 6, 189, 123);
  static const Color background = Color.fromARGB(255, 255, 255, 255);

  static const Color primaryDark = Color.fromARGB(255, 3, 165, 60);
  static const Color secondaryDark = Color.fromRGBO(6, 189, 123, 1);
  static const Color backgroundDark = Color.fromARGB(255, 39, 61, 65);

  static const Map<int, Color> gradient = {
    1: Color.fromRGBO(3, 165, 60, 1),
    2: Color.fromRGBO(6, 189, 123, 1),
    3: Color.fromRGBO(3, 165, 60, 1),
    4: Color.fromRGBO(6, 189, 123, 1),
    5: Color.fromRGBO(3, 165, 60, 1),
    6: Color.fromRGBO(6, 189, 123, 1),
    7: Color.fromRGBO(3, 165, 60, 1),
    8: Color.fromRGBO(6, 189, 123, 1),
  };

  static const Color black = Color.fromARGB(255, 39, 61, 65);
  static const Color white = Color.fromARGB(255, 242, 242, 242);
  static const Color placeholder = Color.fromARGB(255, 255, 247, 255);

  static const Color error = Color.fromARGB(255, 233, 60, 59);
  static const Color success = Color.fromARGB(255, 110, 156, 54);
  static const Color warning = Color.fromARGB(255, 239, 197, 20);
  static const Color info = Color.fromARGB(255, 1, 126, 255);

  static const Color border = Color.fromARGB(255, 224, 224, 224);
  static const Color shadow = Color.fromARGB(255, 0, 0, 0);
  static const Color disabled = Color.fromARGB(255, 140, 163, 186);
  static const Color divider = Color(0xFFe0e0e0);

  static const Color transparent = Color(0x00000000);

  static Color getColor(int color) {
    return gradient[color] ?? Colors.transparent;
  }

  static const Color textColor = Color.fromARGB(255, 39, 61, 65);
  static const Color textDarkColor = Color.fromARGB(255, 255, 255, 255);

  static const Color textLinkColor = Color.fromARGB(255, 3, 165, 60);
  static const Color textDescriptionColor = Color.fromARGB(255, 140, 163, 186);
}
