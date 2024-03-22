import 'dart:math';

import 'package:elder_care/enums/fonts.dart';
import 'package:elder_care/enums/palette.dart';
import 'package:flutter/material.dart';

import '../../enums/company.dart';

class CouponView extends StatelessWidget {
  final Company company;
  const CouponView(this.company, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Palette.scheme.onPrimary,
        borderRadius: BorderRadius.circular(20),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          Container(
            height: 110,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(company.path),
                fit: BoxFit.fitWidth,
              ),
            ),
          ),
          Container(
            color: Palette.scheme.onPrimary,
            child: Column(
              children: [
                Text('-${(Random().nextInt(15)+1)*10} punti', style: Fonts.regular(color: Palette.scheme.onSurface)),
                Text('Buono da ${(Random().nextInt(3)+1)*5}€', style: Fonts.bold(color: Palette.scheme.onSurface)),
              ],
            ),
          )
        ],
      ),
    );
  }
}
