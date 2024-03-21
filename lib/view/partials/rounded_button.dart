import 'package:elder_care/enums/palette.dart';
import 'package:flutter/material.dart';
import 'package:elder_care/enums/fonts.dart';
import 'package:elder_care/enums/palette.dart';

class RoundedButton extends StatelessWidget {
  const RoundedButton(this.text, {super.key, this.invertStyle = false, required this.onTap});

  final bool invertStyle;
  final String text;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 30),
        backgroundColor: invertStyle
            ? Palette.scheme.background
            : Palette.scheme.onSecondary,
        shape: RoundedRectangleBorder(
          side: invertStyle
              ? BorderSide(color: Palette.scheme.onSecondary, width: 2)
              : BorderSide.none,
          borderRadius: BorderRadius.circular(999),
        ),
      ),
      onPressed: onTap,
      child: Text(
        text,
        style: Fonts.regular(
            color: invertStyle
                ? Palette.scheme.onSecondary
                : Palette.scheme.onPrimary,
            size: 16),
      ),
    );
  }
}
