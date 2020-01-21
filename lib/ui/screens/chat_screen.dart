import 'dart:core';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:pizo/models/message.dart';
import 'package:pizo/resources/apis/messages_api_provider.dart';
import 'package:pizo/resources/sharedprefs.dart';
import 'package:pizo/ui/widgets/message.dart' as mWidget;

String id, title;

class ChatScreen extends StatefulWidget {
  ChatScreen(commingID, commingTitle) {
    id = commingID.toString();
    title = commingTitle.toString();
  }
  @override
  _ChatState createState() => new _ChatState();
}

class _ChatState extends State<ChatScreen> {
  List<Message> messages = new List();
  final List<mWidget.Message> _messages = <mWidget.Message>[];
  String token;

  // Create a text controller. We will use it to retrieve the current value
  // of the TextField!
  final _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    DateTime time = DateTime.now();
    String formattedDate = DateFormat('yyyy-MM-dd hh:mm').format(time);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        title: Text(title),
        actions: <Widget>[
          GestureDetector(
              onTap: () {
                getMessages();
              },
              child: Icon(Icons.refresh))
        ],
      ),
      body: Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.white,
          child: new Container(
            child: new Column(
              children: <Widget>[
                //Chat list
                new Flexible(
                  child: new ListView.builder(
                    padding: new EdgeInsets.all(8.0),
                    reverse: true,
                    itemBuilder: (_, int index) => _messages[index],
                    itemCount: _messages.length,
                  ),
                ),
                new Divider(height: 1.0),
                new Container(
                    padding: EdgeInsets.only(left: 10),
                    decoration:
                        new BoxDecoration(color: Theme.of(context).cardColor),
                    child: new IconTheme(
                        data: new IconThemeData(
                            color: Theme.of(context).accentColor),
                        child: new Container(
                          margin: const EdgeInsets.symmetric(horizontal: 2.0),
                          child: new Row(
                            children: <Widget>[
                              new Flexible(
                                child: new TextField(
                                  controller: _textController,
                                  decoration: new InputDecoration.collapsed(
                                      hintText: "Enter message"),
                                ),
                              ),

                              //right send button

                              new Container(
                                margin:
                                    new EdgeInsets.symmetric(horizontal: 2.0),
                                width: 48.0,
                                height: 48.0,
                                child: new IconButton(
                                    icon: Icon(
                                      Icons.send,
                                      color: Colors.indigo,
                                    ),
                                    onPressed: () => _sndMsg(
                                        _textController.text,
                                        'right',
                                        formattedDate)),
                              ),
                            ],
                          ),
                        ))),
              ],
            ),
          )),
    );
  }

  void _sndMsg(String msg, String messageDirection, String date) {
    if (msg.length == 0) {
      Fluttertoast.showToast(
          msg: "Please Enter Message",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIos: 1,
          fontSize: 12,
          backgroundColor: Colors.blue);
    } else {
      MessagesAPI().sndMessage(token, id, msg).then((error) {
        if (error == "0") {
          _textController.clear();
          getMessages();
        } else if (error == "1") {
          Fluttertoast.showToast(
              msg: "Cannot send, try again",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIos: 1,
              fontSize: 12,
              backgroundColor: Colors.red);
        }
      });
    }
  }

  void _shwMsg(String msg, String messageDirection, String date) {
    mWidget.Message message = new mWidget.Message(
      msg: msg,
      direction: messageDirection,
      dateTime: date,
    );
    setState(() {
      _messages.insert(0, message);
    });
  }

  @override
  void initState() {
    super.initState();
    getMessages();
  }

  getMessages() {
    _messages.clear();
    SharedPrefs().getSharedToken().then((token) {
      this.token = token;
      MessagesAPI().getMessages(token, id).then((messagesList) {
        messages = messagesList;
        SharedPrefs().getSharedID().then((id) {
          for (int i = 0; i < messages.length; i++) {
            print(messages.elementAt(i).getSenderID().toString() +
                "      " +
                id.toString());
            String direction =
                messages.elementAt(i).getSenderID().toString() == id.toString()
                    ? 'right'
                    : 'left';
            _shwMsg(messages.elementAt(i).getMessage(), direction,
                messages.elementAt(i).getDate());
          }
        });
      });
    });
  }

  @override
  void dispose() {
    // Every listener should be canceled, the same should be done with this stream.
    // Clean up the controller when the Widget is disposed
    _textController.dispose();
    super.dispose();
  }
}
