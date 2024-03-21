import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:elder_care/managers/io_manager.dart';
import 'package:elder_care/model/user.dart';
import 'data_manager.dart';

class AccountManager {
  static final AccountManager _instance = AccountManager._();

  factory AccountManager() => _instance;

  AccountManager._();

  late User user;

  Future<bool> cacheLogin() async {
    String? uid = await IOManager().getCacheData("uid");
    if (uid == null) return false;
    user = await DataManager().loadUser(uid, force: true);
    return true;
  }

  Future<void> login(emailAddress, password) async {
    try {
      final credential = await auth.FirebaseAuth.instance
          .signInWithEmailAndPassword(email: emailAddress, password: password);
      await IOManager().setCacheData("uid", credential.user!.uid);
      user = await DataManager().loadUser(credential.user?.uid, force: true);
    } catch (e) {
      // Username o password errati
      throw (e.toString());
    }
  }

  Future<void> signUp(email, password, User newUser) async {
    try {
      final credential =
          await auth.FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      newUser.uid = credential.user!.uid;
      await IOManager().setCacheData("uid", credential.user!.uid);
    } on auth.FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw ('La password è troppo debole');
      } else if (e.code == 'email-already-in-use') {
        throw ('Account già esistente');
      }
    } catch (e) {
      throw (e.toString());
    }
    await DataManager().save(newUser);
    user = newUser;
  }

  Future<void> logout() async {
    await IOManager().removeCacheData("uid");
    //await auth.FirebaseAuth.instance.signOut();
  }

  bool isEmailValid(String email) {
    final emailRegex = RegExp(r'^\w+([.-]?\w+)*@\w+([.-]?\w+)*(\.\w{2,3})+$');
    return emailRegex.hasMatch(email);
  }
}
