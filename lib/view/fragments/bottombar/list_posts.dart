import 'package:elder_care/managers/data_manager.dart';
import 'package:elder_care/model/post.dart';
import 'package:elder_care/view/partials/post_view.dart';
import 'package:flutter/material.dart';

class ListPost extends StatefulWidget {
  const ListPost({super.key});

  @override
  State<ListPost> createState() => _ListPostState();
}

class _ListPostState extends State<ListPost> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: DataManager().posts.length,
      itemBuilder: (context, i) => PostView(DataManager().posts[i]),
      padding: const EdgeInsets.only(bottom: 120),
    );
  }
}
