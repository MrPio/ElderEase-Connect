  import 'package:flutter/material.dart';

  enum UserType {
    STUDENT("Offrire assistenza","Studente"),
    ELDER("Chiedere assistenza", "");

    final String title;
    final String typeName;

    const UserType(this.title, this.typeName);
  }
