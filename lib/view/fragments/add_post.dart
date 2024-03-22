import 'dart:async';

import 'package:elder_care/managers/api_manager.dart';
import 'package:elder_care/managers/data_manager.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class AddPost extends StatefulWidget {
  void Function() refresh;
  AddPost(this.refresh, {super.key});

  @override
  State<AddPost> createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  late Timer _timer;
  final webController = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..setBackgroundColor(const Color(0x00000000))
    ..loadRequest(Uri.parse(
        'https://mediafiles.botpress.cloud/e1176464-6a4a-4b5d-995e-f78c4d3ed241/webchat/bot.html'));

  @override
  Widget build(BuildContext context) {
    return WebViewWidget(controller: webController);
  }

  @override
  void initState() {
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) async {
      var post = await APIManager().getMessages();
      if(post != null){
        DataManager().save(post,SaveMode.POST);
        // Navigator.of(context).pop();
        widget.refresh();
      }
    });
    super.initState();
  }
  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
}
