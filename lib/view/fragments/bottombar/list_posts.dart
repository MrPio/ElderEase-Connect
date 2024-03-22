import 'package:elder_care/enums/fonts.dart';
import 'package:elder_care/enums/palette.dart';
import 'package:elder_care/managers/data_manager.dart';
import 'package:elder_care/model/post.dart';
import 'package:elder_care/view/partials/post_view.dart';
import 'package:flutter/material.dart';

class ListPost extends StatelessWidget {
  final List<Post> posts;
  final String title;
  final void Function() refresh;
  const ListPost(this.posts, this.title,this.refresh, {super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 16.0, bottom: 16, top: 50),
              child: Text(
                title,
                style: Fonts.black(color: Palette.scheme.onPrimaryContainer),
              ),
            ),
          ),
          ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: posts.length,
            itemBuilder: (context, i) => PostView(posts[i], refresh),
            padding: const EdgeInsets.only(bottom: 120),
          ),
        ],
      ),
    );
  }
}
