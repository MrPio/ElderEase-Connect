import 'package:flutter/material.dart';
import 'package:elder_care/enums/palette.dart';

class LoadingView extends StatefulWidget {
  const LoadingView({this.visible = true, super.key});

  final bool visible;

  @override
  State<LoadingView> createState() => _LoadingViewState();
}

class _LoadingViewState extends State<LoadingView> {
  @override
  Widget build(BuildContext context) {
    return Visibility(
        visible: widget.visible,
        child: Container(
          color: Palette.overlayBlack,
          child: const Center(
            child: CircularProgressIndicator(
              color: Palette.white,
            ),
          ),
        ));
  }
}
