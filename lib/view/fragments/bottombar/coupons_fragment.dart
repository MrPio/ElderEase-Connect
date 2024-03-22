import 'package:elder_care/enums/company.dart';
import 'package:elder_care/enums/fonts.dart';
import 'package:elder_care/enums/palette.dart';
import 'package:elder_care/view/partials/coupon_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CouponsFragment extends StatelessWidget {
  const CouponsFragment({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.scheme.primaryContainer,
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 20),
              // Title
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Icon(
                        Icons.arrow_back,
                        color: Palette.scheme.onSurface,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: Text(
                      'Punti e coupon',
                      style: Fonts.bold(color: Palette.scheme.onSurface),
                    ),
                  )
                ],
              ),
              // I tuoi punti
              const SizedBox(height: 40),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Palette.scheme.onPrimary,
                  borderRadius: BorderRadius.circular(26),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 16.0, bottom: 8.0),
                      child: Text(
                        'I tuoi punti:',
                        style: Fonts.bold(color: Palette.scheme.onSurface),
                      ),
                    ),
                    Text(
                      '23',
                      style: Fonts.black(color: Palette.scheme.primary, size: 36),
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
              const SizedBox(height: 40),
              GridView.builder(
                padding: const EdgeInsets.symmetric(vertical: 20),
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate:
                const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                  childAspectRatio: 1,
                ),
                itemCount: 6,
                itemBuilder: (_, i) {
                  return CouponView(Company.values[i%Company.values.length]);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
