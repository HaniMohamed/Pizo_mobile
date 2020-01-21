import 'package:flutter/material.dart';
import 'package:pizo/models/conversation.dart';
import 'package:pizo/ui/screens/chat_screen.dart';

class ConvItem extends StatelessWidget {
  Conversation conv;

  ConvItem(Conversation conv) {
    this.conv = conv;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChatScreen(
                conv.getID(),
                conv.getTitle(),
              ),
            ));
      },
      child: Container(
        height: 60,
        margin: EdgeInsets.all(2),
        child: Card(
          semanticContainer: false,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                width: 60,
                height: 60,
                color: Colors.cyan,
                padding: EdgeInsets.all(10),
                child: Icon(
                  Icons.person_pin,
                  color: Colors.white,
                  size: 30,
                ),
              ),
              Center(
                  child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(left: 10),
                    child: Text(conv.getTitle(),
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.bold)),
                  )
                ],
              )),
            ],
          ),
          elevation: 2,
        ),
      ),
    );
  }
}
