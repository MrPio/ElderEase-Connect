import 'package:elder_care/managers/account_manager.dart';
import 'package:elder_care/managers/data_manager.dart';
import 'package:elder_care/model/user.dart';
import 'package:elder_care/view/fragments/first_fragment.dart';
import 'package:elder_care/view/partials/loading_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';

import '../enums/strings.dart';
import 'fragments/login_fragment.dart';
import 'fragments/signup_fragment.dart';
import '../../firebase_options.dart';

class FirstPage extends StatefulWidget {
  const FirstPage({Key? key}) : super(key: key);

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  int _currentPageIndex = 0;
  late List<Widget> _pages;
  bool isLoading = true;

  void setFragmentIndex(int index) {
    setState(() {
      _currentPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          _pages[_currentPageIndex],
          LoadingView(visible: isLoading)
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    _pages = [
      FirstFragment(setIndex: setFragmentIndex),
      LoginFragment(setIndex: setFragmentIndex),
      SignupFragment(setIndex: setFragmentIndex),
    ];

    // Ensure the navigation to occur after the state is built
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
      await initialize();
    });
  }

  initialize() async {
    Navigator.popUntil(context, (route) => route.isFirst);
    if (await AccountManager().cacheLogin()) {
      Navigator.of(context).popAndPushNamed("/main");
    }
    setState(() => isLoading = false);
  }
}
