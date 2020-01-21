import 'package:flutter/material.dart';
import 'package:pizo/models/conversation.dart';
import 'package:pizo/resources/apis/messages_api_provider.dart';
import 'package:pizo/resources/sharedprefs.dart';
import 'package:pizo/ui/widgets/app_header.dart';
import 'package:pizo/ui/widgets/lists/conversations_list.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MessagesPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _MessagesPage();
  }
}

class _MessagesPage extends State<MessagesPage> {
  List<String> titles = [
    "My Messages",
  ];
  List<Conversation> conversations = new List();

  @override
  void initState() {
    super.initState();
    SharedPrefs().getSharedToken().then((token) {
      if (token.isNotEmpty) {
        MessagesAPI().getConversations(token).then((convs) {
          setState(() {
            this.conversations = convs;
          });

          print("###########" + conversations.length.toString() + "#########");
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey.shade200,
      child: Column(
        children: <Widget>[
          AppHeader(titles),
          Container(
            margin: EdgeInsets.all(10),
            child: Row(
              children: <Widget>[
                Text(
                  "Messages",
                  style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey),
                ),
                Expanded(
                  child: new Container(
                    margin: EdgeInsets.all(5),
                    height: 1.0,
                    color: Colors.grey.withAlpha(50),
                  ),
                ),
              ],
            ),
          ),
          conversations.length > 0
              ? Expanded(
                  child: ConvsList(conversations, conversations.length),
                )
              : Container(),
        ],
      ),
    );
  }
}
