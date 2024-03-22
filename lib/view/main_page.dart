import 'package:elder_care/managers/account_manager.dart';
import 'package:elder_care/managers/data_manager.dart';
import 'package:elder_care/view/fragments/add_post.dart';
import 'package:flutter/material.dart';

import '../../enums/user_type.dart';
import 'fragments/bottombar/list_posts.dart';
import 'fragments/bottombar/profile_fragment.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;

  List<Widget> _screens = [Container(), Container(), Container()];

  UserType get userType => AccountManager().user.userType;

  @override
  void initState() {
    super.initState();
    _screens_elder = [
      const ListPost(),
      AddPost(refresh),
      ProfileFragment(),
    ];
    refresh();
  }

  void refresh() {
    Future.delayed(Duration.zero, () async {
      DataManager().reloadPaginatedData();
      await DataManager().loadMore();
      for (var post
          in DataManager().posts.where((post) => post.author == null)) {
        post.author = await DataManager().loadUser(post.authorUID);
      }
      _screens = [Container(), Container(), Container()];
      _screens = userType == UserType.ELDER ? _screens_elder : _screens_student;
      _currentIndex = 0;
      setState(() {});
    });
  }

  late final List<Widget> _screens_elder;

  final List<Widget> _screens_student = [
    const ListPost(),
    const ListPost(),
    ProfileFragment(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        // backgroundColor: Palette.scheme.primary,
        currentIndex: _currentIndex,
        onTap: (int index) {
          setState(() {
            // if (userType == UserType.ELDER && index == 1) {
            //   Navigator.of(context).pushNamed('/add_post');
            // } else {
            _currentIndex = index;
            // }
          });
        },
        items: [
          const BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Storico',
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.add),
            label: userType == UserType.ELDER ? 'Aggiungi' : 'Lavora',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profilo',
          ),
        ],
      ),
    );
  }
}
