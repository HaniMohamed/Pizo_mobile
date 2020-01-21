import 'package:flutter/material.dart';
import 'package:pizo/models/job.dart';
import 'package:pizo/resources/apis/messages_api_provider.dart';
import 'package:pizo/resources/sharedprefs.dart';
import 'package:pizo/ui/home_tabs/Jobs_tab.dart';
import 'package:pizo/ui/screens/chat_screen.dart';

class JobItem extends StatefulWidget {
  Job job;
  JobItem(Job commingJob) {
    this.job = commingJob;
  }

  @override
  State<StatefulWidget> createState() {
    return _JobItem();
  }
}

class _JobItem extends State<JobItem> with TickerProviderStateMixin {
  double _height = 100;
  Color _cardColor = Colors.white;
  Color _iconColor = Colors.blue;
  Color _textColor = Colors.black;

  @override
  void initState() {
    super.initState();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          if (_height == 100) {
            _height = 250;
            _cardColor = Colors.blue;
            _iconColor = Colors.white;
            _textColor = Colors.white;
          } else {
            _height = 100;
            _cardColor = Colors.white;
            _iconColor = Colors.blue;
            _textColor = Colors.black;
          }
        });
      },
      child: AnimatedContainer(
        duration: new Duration(milliseconds: 500),
        height: _height,
        child: Card(
          color: _cardColor,
          elevation: 1,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                  height: 100,
                  width: 100,
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(10),
                  child: Image.asset(
                    "asset/images/job.png",
                    width: 50,
                    height: 50,
                  )),
              Divider(
                color: Colors.grey,
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        widget.job.getTitle(),
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            fontSize: 18,
                            color: _textColor,
                            fontWeight: FontWeight.w400),
                      ),
                      Text(
                        widget.job.getOwnerName().toString(),
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            fontSize: 12, color: _textColor.withAlpha(150)),
                      ),
                      _height > 100
                          ? Column(
                              children: <Widget>[
                                Container(
                                    height: 120,
                                    child: SingleChildScrollView(
                                      child: Text(
                                        widget.job.getDescription(),
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                            fontSize: 14, color: _textColor),
                                      ),
                                    )),
                                GestureDetector(
                                  onTap: () {
                                    contactJobProvider(widget.job.getOwnerID(),
                                        widget.job.getTitle());
                                  },
                                  child: Card(
                                    margin: EdgeInsets.only(
                                        top: 15, right: 10, left: 10),
                                    elevation: 2,
                                    color: Colors.green,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    semanticContainer: false,
                                    clipBehavior: Clip.antiAliasWithSaveLayer,
                                    child: Container(
                                        padding: EdgeInsets.all(5),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Text(
                                              "  Contact",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 14),
                                            )
                                          ],
                                        )),
                                  ),
                                ),
                              ],
                            )
                          : Container(),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  contactJobProvider(ownerID, title) {
    SharedPrefs().getSharedMail().then((mail) {
      SharedPrefs().getSharedToken().then((token) {
        MessagesAPI()
            .createConversation(token, ownerID.toString(), mail + ">" + title)
            .then((id) {
          print(id);
          if (id != null) {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChatScreen(
                    id,
                    title,
                  ),
                ));
          }
        });
      });
    });
  }
}
