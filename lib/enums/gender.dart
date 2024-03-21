import 'package:flutter/material.dart';

enum Gender {
  MALE('Ragazzo', Icons.male),
  FEMALE('Ragazza', Icons.female),
  OTHER('Altro', Icons.question_mark);

  final String title;
  final IconData icon;

  const Gender(this.title, this.icon);
}
