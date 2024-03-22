import 'package:elder_care/enums/palette.dart';
import 'package:elder_care/managers/account_manager.dart';
import 'package:elder_care/managers/io_manager.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'coupons_fragment.dart';

class ProfileFragment extends StatelessWidget {
  final User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        UserAccountsDrawerHeader(
          accountName: Text("${AccountManager().user.name} ${AccountManager().user.surname}" ?? 'Nome utente'),
          accountEmail: Text(user?.email ?? 'Email utente'),
          currentAccountPicture: const CircleAvatar(
            backgroundImage: NetworkImage('https://firebasestorage.googleapis.com/v0/b/spotted-f3589.appspot.com/o/src%2Fanonymous.png?alt=media&token=82e2acd1-a7fa-49f3-a659-4692b5b98293'),
          ),
          decoration: BoxDecoration(
            color: Palette.scheme.primary, // Change the color here
          ),
        ),
        ListTile(
          leading: const Icon(Icons.edit),
          title: const Text('Modifica profilo'),
          onTap: () {
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(builder: (context) => const ModifyProfileFragment()),
            // );
          },
        ),
        ListTile(
          leading: const Icon(Icons.lock),
          title: const Text('Cambia password'),
          onTap: () {
            // Non implementato per ora
          },
        ),
        ListTile(
          leading: const Icon(Icons.book),
          title: const Text('Termini di utilizzo'),
          onTap: () {
            // Non implementato per ora
          },
        ),
        ListTile(
          leading: const Icon(Icons.card_giftcard),
          title: const Text('Punti e coupon'),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const CouponsFragment()),
            );
          },
        ),
        ListTile(
          leading: const Icon(Icons.notifications),
          title: const Text('Notifiche'),
          onTap: () {
            // Non implementato per ora
          },
        ),
        ListTile(
          leading: const Icon(Icons.exit_to_app),
          title: const Text('Esci'),
          onTap: () {
            IOManager().removeCacheData('uid');
            Navigator.of(context).popAndPushNamed('/');
          },
        ),
      ],
    );
  }
}
