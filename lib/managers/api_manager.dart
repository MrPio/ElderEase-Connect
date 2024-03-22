import 'dart:convert';

import 'package:elder_care/enums/post_type.dart';
import 'package:elder_care/managers/account_manager.dart';
import 'package:elder_care/model/post.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:elder_care/managers/io_manager.dart';
import 'package:elder_care/model/user.dart';
import 'package:intl/intl.dart';
import 'data_manager.dart';
import 'package:http/http.dart';

class APIManager {
  static final APIManager _instance = APIManager._();

  factory APIManager() => _instance;

  APIManager._();

  Future<Post?> getMessages() async {
    var headers = {
      'Authorization': 'Bearer bp_pat_zvBz4olNICAKgfZR8vr43CYamzlmetmhljuX',
      'x-bot-id': 'e1176464-6a4a-4b5d-995e-f78c4d3ed241',
      'x-integration-id': '87b01760-ede8-49d5-afc6-6afc0d0d1bdb'
    };
    var request = Request(
        'GET', Uri.parse('https://api.botpress.cloud/v1/chat/messages'));

    request.headers.addAll(headers);

    StreamedResponse response = await request.send();

    Post? post;
    if (response.statusCode == 200) {
      var answer = await response.stream.bytesToString();
      Map<String, dynamic> data = jsonDecode(answer);
      bool confirmed=false;
      for (var message in data['messages']) {
        if (message['direction'] == 'outgoing') {
          var date = DateTime.parse(message['createdAt']);
              // .add(const Duration(hours: 1));
          String text = message['payload']['text'];
          if (text.contains('Ottimo!') &&
              DateTime.now().difference(date).inSeconds < 30) {
            print(DateTime.now().difference(date).inSeconds);
            confirmed=true;
          }
          if (text.contains('Riepilogo:') &&
              DateTime.now().difference(date).inSeconds < 40 && confirmed) {
            post = Post();
            var summary = text
                .replaceAll('`', '')
                .split('Riepilogo:')[1]
                .split('\n')
                .where((part) => part.isNotEmpty)
                .toList();
            Map<String, String> dict = {};
            for (var field in summary) {
              dict[field.split(':')[0]] = field.split(':')[1].trimLeft();
            }
            if (dict['Data']!.contains('YYYY')) {
              dict['Data'] = dict['Data']!
                  .replaceAll('YYYY', DateTime.now().year.toString());
            }
            post.timestamp = DateFormat('dd/MM/yyyy').parse(dict['Data']!.trim())
                .add(Duration(hours: int.parse(dict['Ora']!)))
                .millisecondsSinceEpoch;
            post.hours = double.parse(dict['Numero ore']!);
            post.address = dict['Indirizzo']! == 'casa'
                ? AccountManager().user.address
                : dict['Indirizzo']!;
            post.postType = dict['Servizio']!.contains('Assistenza')
                ? PostType.HOME
                : PostType.TRANSPORT;
            post.description = dict['Specifica']??'';
            post.authorUID=AccountManager().user.uid;
            break;
          }
        }
      }
    } else {
      // print(response.reasonPhrase);
    }
    return post;
  }
}
