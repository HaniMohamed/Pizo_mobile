import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pizo/models/event.dart';
import 'package:pizo/resources/apis/messages_api_provider.dart';
import 'package:pizo/resources/constants.dart';
import 'package:pizo/resources/sharedprefs.dart';
import 'package:pizo/ui/screens/chat_screen.dart';

Event event;
String heroTag;
Constants cons = new Constants();
String email, token;

class EventDetails extends StatefulWidget {
  EventDetails(Event recievedevent, String recievedTag) {
    event = recievedevent;
    heroTag = recievedTag;
  }

  @override
  State<StatefulWidget> createState() {
    return _EventDetails();
  }
}

class _EventDetails extends State<EventDetails> {
  @override
  void initState() {
    super.initState();

    SharedPrefs().getSharedMail().then((mail) {
      setState(() {
        email = mail;
      });
    });

    SharedPrefs().getSharedToken().then((tok) {
      setState(() {
        token = tok;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanUpdate: (details) {
        if (details.delta.dy > 10) {
          Navigator.pop(context);
        }
      },
      child: Container(
          height: double.infinity,
          color: Colors.grey.shade200,
          child: Column(
            children: <Widget>[
              Container(
                height: 290,
                child: Stack(
                  children: <Widget>[
                    Hero(
                        tag: heroTag,
                        child: Stack(
                          children: <Widget>[
                            CachedNetworkImage(
                              imageUrl: event.getImage(),
                              height: 250,
                              width: double.infinity,
                              fit: BoxFit.cover,
                              errorWidget: (context, url, error) =>
                                  new Container(
                                height: 250,
                                child: Icon(Icons.error),
                              ),
                            ),
                            Positioned.fill(
                              top: 15,
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: Container(
                                    color: Colors.black.withAlpha(120),
                                    padding: EdgeInsets.all(10),
                                    child: Icon(
                                      Icons.arrow_back_ios,
                                      color: Colors.white,
                                      size: 25,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )),
                    Positioned.fill(
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          margin: EdgeInsets.all(5),
                          height: 80,
                          child: Card(
                            color: Colors.black.withAlpha(200),
                            child: Container(
                              padding: EdgeInsets.all(10),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          event.getTitle(),
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: Colors.white),
                                        ),
                                        Text(
                                          event.getOwner(),
                                          style: TextStyle(
                                              fontSize: 12,
                                              color:
                                                  Colors.white.withAlpha(200)),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    child: GestureDetector(
                                      onTap: () {
                                        MessagesAPI()
                                            .createConversation(
                                                token,
                                                event.getOwnerID().toString(),
                                                email + ">" + event.getTitle())
                                            .then((id) {
                                          print(id);
                                          if (id != null) {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      ChatScreen(
                                                    id,
                                                    event.getTitle(),
                                                  ),
                                                ));
                                          }
                                        });
                                      },
                                      child: Card(
                                        elevation: 5,
                                        color: Colors.blue,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                        semanticContainer: false,
                                        clipBehavior:
                                            Clip.antiAliasWithSaveLayer,
                                        child: Container(
                                            padding: EdgeInsets.all(5),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: <Widget>[
                                                Icon(Icons.chat_bubble,
                                                    size: 20,
                                                    color: Colors.white),
                                                Text(
                                                  " Contact",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 14),
                                                )
                                              ],
                                            )),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                  child: Card(
                child: Column(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(top: 10),
                      child: Row(
                        children: <Widget>[
                          Text(
                            "Description",
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
                      padding: EdgeInsets.only(top: 0, left: 10, right: 10),
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                          padding: EdgeInsets.all(10),
                          child: Text(
                            event.getDescribe(),
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 12,
                                fontWeight: FontWeight.normal),
                          )),
                    ),
                  ],
                ),
              ))
            ],
          )),
    );
  }
}
