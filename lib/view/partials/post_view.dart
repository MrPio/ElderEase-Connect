import 'dart:ffi';
import 'dart:math';

import 'package:elder_care/enums/palette.dart';
import 'package:elder_care/extension/function/date_time_extensions.dart';
import 'package:elder_care/model/post.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../enums/fonts.dart';
import '../../enums/gender.dart';

class PostView extends StatelessWidget {
  final Post post;

  const PostView(this.post, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 2.0),
      child: Card(
        color: Palette.scheme.primaryContainer,
        child: ListTile(
          leading: Icon(post.postType.icon),
          title: Text("${post.author?.name} ${post.author?.surname}", style: Fonts.bold(color: Palette.scheme.onPrimaryContainer)),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Indirizzo: ${post.date.toShortDateStr()}', style: Fonts.regular(color: Palette.scheme.onPrimaryContainer)),
              Text('Indirizzo: ${post.address ?? ''}', style: Fonts.regular(color: Palette.scheme.onPrimaryContainer)),
              Text('Cellulare: ${post.author?.cellNumber ?? ''}', style: Fonts.regular(color: Palette.scheme.onPrimaryContainer)),
              Text('Genere: ${post.author?.gender.title ?? ''}', style: Fonts.regular(color: Palette.scheme.onPrimaryContainer)),
              Text('Stato: ${post.getStatus()}', style: Fonts.regular(color: Palette.scheme.onPrimaryContainer)),
            ],
          ),
          trailing: Text('${Random().nextInt(5)} km', style: Fonts.bold(color: Palette.scheme.onPrimaryContainer),),
          isThreeLine: true,
        ),
      ),
    );
  }
}
