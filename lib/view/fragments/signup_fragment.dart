import 'package:elder_care/enums/fonts.dart';
import 'package:elder_care/enums/user_type.dart';
import 'package:elder_care/extension/function/context_extensions.dart';
import 'package:elder_care/extension/function/date_time_extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:elder_care/view/partials/rounded_button.dart';
import 'package:flutter/widgets.dart';

import '../../enums/gender.dart';
import '../../enums/palette.dart';
import '../../managers/account_manager.dart';
import '../../model/user.dart';

class SignupFragment extends StatefulWidget {
  final void Function(int) setIndex;

  const SignupFragment({super.key, required this.setIndex});

  @override
  State<SignupFragment> createState() => _SignupFragmentState();
}

class _SignupFragmentState extends State<SignupFragment> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _surnameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  DateTime? _birthDate;
  UserType selectedUserType = UserType.ELDER;
  Gender selectedGender = Gender.MALE;
  String errorText = '';

  Future<void> _signUp() async {
    String email = _emailController.text;
    if (!AccountManager().isEmailValid(email)) {
      context.popup('Errore nella compilazione',
          message: 'Per favore specifica un\'email valida');
      return;
    }
    String password = _passwordController.text;
    if (password.length < 6) {
      context.popup('Errore nella compilazione',
          message:
              'Per favore specifica una password di lunghezza maggiore di 5');
      return;
    }
    String name = _nameController.text;
    if (name == '') {
      context.popup('Errore nella compilazione',
          message: 'Per favore specifica un nome');
      return;
    }
    String surname = _surnameController.text;
    if (surname == '') {
      context.popup('Errore nella compilazione',
          message: 'Per favore specifica un cognome');
      return;
    }
    if (_birthDate == null) {
      context.popup('Errore nella compilazione',
          message: 'Per favore specifica la tua data di nascita');
      return;
    }
    String address = _addressController.text;
    if (selectedUserType == UserType.ELDER && address == '') {
      context.popup('Errore nella compilazione',
          message: 'Per favore specifica un indirizzo valido');
      return;
    }
    String? phone = _phoneController.text;
    if (phone == '') {
      context.popup('Errore nella compilazione',
          message: 'Per favore specifica un numero di cellulare');
      return;
    }
    try {
      await AccountManager().signUp(
          email,
          password,
          User(
            name: name,
            surname: surname,
            address: address,
            cellNumber: phone,
            gender: selectedGender,
            userType: selectedUserType,
            birthDateTimestamp: _birthDate!.millisecondsSinceEpoch,
          ));
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content:
              Text("L'account è stato creato con successo! Benvenuto ${name}!"),
        ),
      );
      Navigator.of(context).popAndPushNamed("/main");
    } catch (e) {
      if (e == 'Account già esistente') {
        context.popup('Per favore riprova',
            message:
                'L\'email inserita è già associata ad un account. Per favore riprova con un\'altra email');
      } else {
        context.popup('Per favore riprova', message: 'Errore generico');
      }
    }
  }

  void updateText(String newText) {
    setState(() {
      errorText = newText;
    });
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
      SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 50),
            // Title
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  "Benvenuto!\nDicci di più di te",
                  style: Fonts.black(size: 30, color: Palette.scheme.onPrimaryContainer),
                ),
              ),
            ),
            const SizedBox(height: 10),
            // UserType
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20.0, 30.0, 20.0, 10.0),
                child: Text(
                  "Cosa vorresti fare?",
                  style: Fonts.bold(color: Palette.scheme.onPrimaryContainer),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Wrap(
                children: [
                  Row(
                    children: [
                      Radio(
                        value: UserType.ELDER,
                        groupValue: selectedUserType,
                        onChanged: (value) {
                          setState(() {
                            selectedUserType = value!;
                          });
                        },
                      ),
                      Text(
                        UserType.ELDER.title,
                        style: Fonts.regular(
                            color: Palette.scheme.onPrimaryContainer),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Radio(
                        value: UserType.STUDENT,
                        groupValue: selectedUserType,
                        onChanged: (value) {
                          setState(() {
                            selectedUserType = value!;
                          });
                        },
                      ),
                      Text(
                        UserType.STUDENT.title,
                        style: Fonts.regular(
                            color: Palette.scheme.onPrimaryContainer),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // Email
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20.0, 30.0, 20.0, 10.0),
                child: Text(
                  "Email",
                  style: Fonts.bold(color: Palette.scheme.onPrimaryContainer),
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
            // Password
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20.0, 30.0, 20.0, 10.0),
                child: Text(
                  "Password",
                  style: Fonts.bold(color: Palette.scheme.onPrimaryContainer),
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
            // Name
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20.0, 30.0, 20.0, 10.0),
                child: Text(
                  "Nome",
                  style: Fonts.bold(color: Palette.scheme.onPrimaryContainer),
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
                  controller: _nameController,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
            // Surname
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20.0, 30.0, 20.0, 10.0),
                child: Text(
                  "Cognome",
                  style: Fonts.bold(color: Palette.scheme.onPrimaryContainer),
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
                  controller: _surnameController,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
            // Birth
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20.0, 30.0, 20.0, 10.0),
                child: Text(
                  "Data di nascita",
                  style: Fonts.bold(color: Palette.scheme.onPrimaryContainer),
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
                child: GestureDetector(
                  onTap: () async {
                    _birthDate =
                        await context.askDate(context, init: _birthDate);
                    setState(() {});
                  },
                  child: Align(
                    child: Text(
                      _birthDate == null
                          ? 'Seleziona la tua data di nascita'
                          : _birthDate!.toDateStr(),
                      style: Fonts.regular(
                          size: 20, color: Palette.scheme.onPrimaryContainer),
                    ),
                  ),
                ),
              ),
            ),
            // Gender
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20.0, 30.0, 20.0, 10.0),
                child: Text(
                  "Genere",
                  style: Fonts.bold(color: Palette.scheme.onPrimaryContainer),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Wrap(
                children: [
                  Row(
                    children: [
                      Radio(
                        value: Gender.MALE,
                        groupValue: selectedGender,
                        onChanged: (value) {
                          setState(() {
                            selectedGender = value!;
                          });
                        },
                      ),
                      Text(
                        'Uomo',
                        style: Fonts.regular(
                            color: Palette.scheme.onPrimaryContainer),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Radio(
                        value: Gender.FEMALE,
                        groupValue: selectedGender,
                        onChanged: (value) {
                          setState(() {
                            selectedGender = value!;
                          });
                        },
                      ),
                      Text(
                        'Donna',
                        style: Fonts.regular(
                            color: Palette.scheme.onPrimaryContainer),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // Address
            selectedUserType == UserType.ELDER
                ? Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding:
                          const EdgeInsets.fromLTRB(20.0, 30.0, 20.0, 10.0),
                      child: Text(
                        "Indirizzo",
                        style: Fonts.bold(color: Palette.scheme.onPrimaryContainer),
                      ),
                    ),
                  )
                : Container(),
            selectedUserType == UserType.ELDER
                ? Container(
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
                        controller: _addressController,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  )
                : Container(),
            // Phone
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20.0, 30.0, 20.0, 10.0),
                child: Text(
                  "Cellullare",
                  style: Fonts.bold(color: Palette.scheme.onPrimaryContainer),
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
                  controller: _phoneController,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
            // Register Button
            const SizedBox(
              height: 60,
            ),
            SizedBox(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: ElevatedButton(
                  onPressed: () async {
                    await _signUp();
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
                      'Registrati',
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
              onTap: () => widget.setIndex(1),
              child: Text(
                'Hai già un account?',
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
              height: 20,
            ),
          ],
        ),
      )
    ]);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _surnameController.dispose();
    _addressController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
