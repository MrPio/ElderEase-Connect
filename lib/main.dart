import 'package:elder_care/enums/palette.dart';
import 'package:elder_care/managers/api_manager.dart';
import 'package:elder_care/view/fragments/add_post.dart';
import 'package:elder_care/view/main_page.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../enums/strings.dart';
import 'view/first_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    Palette.theme = ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      useMaterial3: true,
    );

    return MaterialApp(
      title: appTitle,
      theme: Palette.theme,
      routes: <String, WidgetBuilder>{
        '/': (context) => const FirstPage(),
        '/main': ( context) => const MainPage(),
        // '/add_post': ( context) => const AddPost(),
      },
    );
  }
}