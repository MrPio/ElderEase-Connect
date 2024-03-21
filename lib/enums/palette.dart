import 'package:flutter/material.dart';

class Palette {
  static late ThemeData theme;
  static ColorScheme get scheme =>theme.colorScheme;

  static const red = Color(0xFFf15450);
  static const white = Color(0xFFffffff);
  static const grey = Color(0xFFefefef);
  static const black = Color(0xFF303030);
  static const darkBlack = Color(0xFF181818);
  static const overlayBlack = Color(0x60000000);
  static const overlayWhite = Color(0x22ffffff);
}
