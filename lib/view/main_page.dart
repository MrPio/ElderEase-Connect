import 'package:flutter/material.dart';
import 'package:elder_care/managers/account_manager.dart';

import '../../enums/palette.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;
  double _offsetY = 0;

  changeIndex(int index) {
    changeBottomBarOffsetY(0);
    setState(() => _currentIndex = index);
  }

  changeBottomBarOffsetY(double offsetY) => setState(() => _offsetY = offsetY);

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      // HomeFragment(changeIndex),
      // AddPostFragment(changeIndex,changeBottomBarOffsetY),
      // AccountFragment(changeIndex,changeBottomBarOffsetY, user: AccountManager().user,),
      // SettingsFragment(changeIndex),
    ];
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            // Current fragment
            pages[_currentIndex],

            // Navigation bar
            Transform.translate(
              offset: Offset(0, _offsetY),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  decoration: BoxDecoration(
                    color: Palette.red,
                    borderRadius: BorderRadius.circular(999),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.4),
                        offset: const Offset(0, 6),
                        blurRadius: 16,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  margin: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 30),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 11.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
/*                        BottomBarIcon(
                          icon: Icons.home_outlined,
                          active: _currentIndex == 0,
                          onTap: () => changeIndex(0),
                        ),
                        BottomBarIcon(
                          icon: Icons.add_circle_outline,
                          active: _currentIndex == 1,
                          onTap: () => changeIndex(1),
                        ),
                        BottomBarIcon(
                          icon: Icons.person_outline,
                          active: _currentIndex == 2,
                          onTap: () => changeIndex(2),
                        ),*/
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
