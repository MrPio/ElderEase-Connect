import 'package:elder_care/enums/fonts.dart';
import 'package:elder_care/extension/function/context_extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:elder_care/view/partials/rounded_button.dart';
import 'package:flutter/widgets.dart';
import '../../enums/palette.dart';
import '../../managers/account_manager.dart';

class LoginFragment extends StatefulWidget {
  final void Function(int) setIndex;

  LoginFragment({required this.setIndex});

  @override
  State<LoginFragment> createState() => _LoginFragmentState();
}

class _LoginFragmentState extends State<LoginFragment> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final paddingH = 20.0;
  String errorText = '';

  Future<void> _login() async {
    String email = _emailController.text;
    String password = _passwordController.text;
    try {
      await AccountManager().login(email, password);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Palette.scheme.primary,
          content: Text(
              "Login effettuato con successo! Bentornato ${AccountManager().user.name}!"),
        ),
      );
      Navigator.of(context).popAndPushNamed("/main");
    } catch (e) {
      context.popup('Per favore riprova',
          message: 'Le credenziali inserite non erano corrette');
    }
  }

  void updateText(String newText) {
    setState(() {
      errorText = newText;
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(fit: StackFit.expand, children: [
      // BG
      Container(
        decoration: BoxDecoration(
          color: Palette.scheme.primaryContainer,
        ),
      ),
      Stack(
        fit: StackFit.expand,
        children: [
          // Fields Email and Password
          SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 80),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text(
                      "Ciao, bentornato!",
                      style: Fonts.black(
                          size: 30, color: Palette.scheme.secondary),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20.0, 30.0, 20.0, 10.0),
                    child: Text(
                      "Email",
                      style: Fonts.bold(color: Palette.scheme.secondary),
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    color: Palette.scheme.onPrimary,
                    borderRadius: BorderRadius.circular(999),
                  ),
                  height: 44,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: TextField(
                      style: Fonts.regular(
                          size: 20, color: Palette.scheme.onPrimaryContainer),
                      maxLines: 1,
                      controller: _emailController,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20.0, 30.0, 20.0, 10.0),
                    child: Text(
                      "Password",
                      style: Fonts.bold(color: Palette.scheme.secondary),
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    color: Palette.scheme.onPrimary,
                    borderRadius: BorderRadius.circular(999),
                  ),
                  height: 44,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: TextField(
                      style: Fonts.regular(
                          size: 20, color: Palette.scheme.onPrimaryContainer),
                      maxLines: 1,
                      controller: _passwordController,
                      obscureText: true,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                Text(
                  'Password dimenticata?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Palette.scheme.onPrimaryContainer,
                    fontFamily: 'lato',
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ],
            ),
          ),
          // Bottom button
          Align(
            alignment: Alignment.bottomCenter,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: ElevatedButton(
                      onPressed: () async {
                        await _login();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Palette.scheme.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(999),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Text(
                          'Entra',
                          textAlign: TextAlign.center,
                          style: Fonts.regular(color: Palette.scheme.onPrimary),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                GestureDetector(
                  onTap: () => widget.setIndex(2),
                  child: Text(
                    'Non hai un account? Registrati ora!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Palette.scheme.onPrimaryContainer,
                      fontFamily: 'lato',
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
              ],
            ),
          ),
        ],
      )
    ]);
  }
}
