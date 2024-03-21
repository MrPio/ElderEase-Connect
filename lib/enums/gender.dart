import 'package:flutter/material.dart';

enum Gender {
  MALE('Uomo', Icons.male),
  FEMALE('Donna', Icons.female),
  OTHER('Altro', Icons.question_mark);

  final String title;
  final IconData icon;

  const Gender(this.title, this.icon);
}
