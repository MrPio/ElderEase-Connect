import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:elder_care/enums/fonts.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../enums/palette.dart';
import '../../enums/strings.dart';

class FirstFragment extends StatefulWidget {
  final void Function(int) setIndex;

  FirstFragment({super.key, required this.setIndex});

  @override
  State<FirstFragment> createState() => _FirstFragmentState();
}

class _FirstFragmentState extends State<FirstFragment> {
  @override
  Widget build(BuildContext context) {
    return Stack(fit: StackFit.expand, children: [
      // BG
      Container(
        decoration: BoxDecoration(
          color: Palette.scheme.primary,
        ),
      ),
      // App top Title
      Align(
        alignment: Alignment.topCenter,
        child: Container(
          margin: const EdgeInsets.all(16.0),
          child: Padding(
            padding: const EdgeInsets.only(top: 56.0),
            child: Text(
              appTitle,
              style: GoogleFonts.clickerScript(
                fontSize: 44,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
      Container(
        color: Colors.transparent,
        margin: const EdgeInsets.only(bottom: 60),
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 220,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/entry.png"),
                  fit: BoxFit.scaleDown,
                ),
              ),
            ),
            SizedBox.fromSize(size: const Size.fromHeight(30)),
            Text(
              introTitle,
              style: Fonts.black(color: Palette.white, size: 32),
            ),
            const SizedBox(height: 10),
            Text(
              introSubTitle,
              style: Fonts.light(color: Palette.white, size: 20),
            ),
            const SizedBox(height: 54),
            ElevatedButton(
              onPressed: () {
                widget.setIndex(1);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Palette.scheme.onPrimary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(999),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      child: Text(
                        start,
                        textAlign: TextAlign.center,
                        style: Fonts.regular(
                            color: Palette.scheme.primary, size: 16),
                      ),
                    ),
                  ),
                  Icon(Icons.arrow_forward, color: Palette.scheme.primary),
                ],
              ),
            ),
          ],
        ),
      ),
    ]);
  }
}
