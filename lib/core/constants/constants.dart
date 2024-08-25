/* Flutter Imports */
import 'package:flutter/material.dart';

/* Project Imports */
import 'package:union/core/themes/palette.dart';

class Constants {
  static const String noConnectionMessage =
      'Não foi possível conectar à internet.';

  static final BoxDecoration backgroundDecoration = BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [Palette.getColor(3), Palette.getColor(4), Palette.getColor(5)],
    ),
  );
}
