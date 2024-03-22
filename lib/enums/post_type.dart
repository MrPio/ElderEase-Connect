import 'package:flutter/material.dart';

enum PostType {
  HOME("Assistenza a casa",Icons.home),
  TRANSPORT("Accompagnamento",Icons.directions_bus);

  final String title;
  final IconData icon;

  const PostType(this.title, this.icon);
}
