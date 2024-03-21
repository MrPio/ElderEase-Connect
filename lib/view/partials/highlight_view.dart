import 'package:flutter/material.dart';

class HighlightView extends StatelessWidget {
  const HighlightView({super.key, required this.onTap});

  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: SizedBox.fromSize(
          size: Size.infinite,
          child: InkWell(
            onTap: onTap,
          )),
    );
  }
}
