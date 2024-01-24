import 'dart:convert';
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  ChatUser myself = ChatUser(id: '1', firstName: 'sudeep');
  ChatUser bot = ChatUser(id: '2', firstName: 'Gemini Pro');

  List<ChatMessage> allMessages = [];
  List<ChatUser> typing = [];

  final oururl =
      'https://generativelanguage.googleapis.com/v1beta/models/gemini-pro:generateContent?key=AIzaSyDwknguKutEz75biVA_qnAjLbpr41FRQ1o';

  final header = {'Content-Type': 'application/json'};

  getdata(ChatMessage m) async {
    typing.add(bot);
    allMessages.insert(0, m);
    setState(() {});
    var data = {
      "contents": [
        {
          "parts": [
            {"text": m.text}
          ]
        }
      ]
    };
    await http
        .post(Uri.parse(oururl), headers: header, body: jsonEncode(data))
        .then((value){
          if(value.statusCode == 200){
            var result = jsonDecode(value.body);
            debugPrint(result['candidates'][0]['content']['parts'][0]['text']);
            ChatMessage m1 = ChatMessage(
              text: result['candidates'][0]['content']['parts'][0]['text'],
              user: bot, 
              createdAt: DateTime.now()
            );

            allMessages.insert(0, m1);
            // setState(() {
              
            // });
          }

          else
          {
            debugPrint("Error Occured");
            debugPrint("e");
          }

        })
        .catchError((e) {});
        typing.remove(bot);
        setState(() {
              
            });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DashChat(
        typingUsers: typing,
          currentUser: myself,
          onSend: (ChatMessage m) {
            getdata(m);
          },
          messages: allMessages),
    );
  }
}
//AIzaSyCVrDK1UpyPXlAbul9YMSfbUwE4pyLAn9M
// curl \
//   -H 'Content-Type: application/json' \
//   -d '{"contents":[{"parts":[{"text":"Write a story about a magic backpack"}]}]}' \
//   -X POST https://generativelanguage.googleapis.com/v1beta/models/gemini-pro:generateContent?key=YOUR_API_KEY

//AIzaSyDwknguKutEz75biVA_qnAjLbpr41FRQ1o
// curl \
//   -H 'Content-Type: application/json' \
//   -d '{"contents":[{"parts":[{"text":"Write a story about a magic backpack"}]}]}' \
//   -X POST https://generativelanguage.googleapis.com/v1beta/models/gemini-pro:generateContent?key=YOUR_API_KEY.
// import 'dart:convert';
// import 'package:dash_chat_2/dash_chat_2.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;