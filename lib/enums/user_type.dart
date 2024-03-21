import 'package:flutter/material.dart';

enum UserType {
  STUDENT("Offrire assistenza"),
  ELDER("Chiedere assistenza");

  final String title;

  const UserType(this.title);
}
