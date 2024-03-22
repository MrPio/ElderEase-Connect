import 'dart:ffi';
import 'dart:math';

import 'package:elder_care/enums/palette.dart';
import 'package:elder_care/enums/user_type.dart';
import 'package:elder_care/extension/function/context_extensions.dart';
import 'package:elder_care/extension/function/date_time_extensions.dart';
import 'package:elder_care/managers/account_manager.dart';
import 'package:elder_care/managers/data_manager.dart';
import 'package:elder_care/model/post.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../enums/fonts.dart';
import '../../enums/gender.dart';

class PostView extends StatelessWidget {
  final Post post;
  final void Function() refresh;

  const PostView(this.post, this.refresh, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 2.0),
      child: Card(
        color: Palette.scheme.primaryContainer,
        child: ListTile(
          leading: Icon(post.postType.icon),
          title: Text("${post.author?.name} ${post.author?.surname}",
              style: Fonts.bold(color: Palette.scheme.onPrimaryContainer)),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Data: ${post.date.toShortDateHourStr()}',
                  style:
                      Fonts.regular(color: Palette.scheme.onPrimaryContainer)),
              Text('Indirizzo: ${post.address ?? ''}',
                  style:
                      Fonts.regular(color: Palette.scheme.onPrimaryContainer)),
              Text('Cellulare: ${post.author?.cellNumber ?? ''}',
                  style:
                      Fonts.regular(color: Palette.scheme.onPrimaryContainer)),
              Text('Genere: ${post.author?.gender.title ?? ''}',
                  style:
                      Fonts.regular(color: Palette.scheme.onPrimaryContainer)),
              Text('Descrizione: ${post.description}',
                  style:
                      Fonts.regular(color: Palette.scheme.onPrimaryContainer)),
              // Text('Stato: ${post.getStatus()}', style: Fonts.regular(color: Palette.scheme.onPrimaryContainer)),
              !post.isValid || post.hasBeenAccepted || AccountManager().user.userType == UserType.ELDER
                  ? Container()
                  : Container(
                      margin: const EdgeInsets.only(top: 10),
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () async {
                          context.popup('Accetti il lavoro?',
                              message:
                                  'Sei sicuro di voler accettare il lavoro?',
                              positiveText: 'Si',
                              negativeText: 'No', positiveCallback: () async {
                            post.acceptedUserUID = AccountManager().user.uid;
                            await DataManager().save(post);
                            refresh();
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Palette.scheme.primary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(999),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Accetta',
                            textAlign: TextAlign.center,
                            style:
                                Fonts.regular(color: Palette.scheme.onPrimary),
                          ),
                        ),
                      ),
                    ),
            ],
          ),
          trailing: Text(
            '${Random().nextInt(5)} km',
            style: Fonts.bold(color: Palette.scheme.onPrimaryContainer),
          ),
          isThreeLine: true,
        ),
      ),
    );
  }
}
