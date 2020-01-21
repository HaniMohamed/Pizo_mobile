import 'package:flutter/material.dart';
import 'package:pizo/models/job.dart';
import 'package:pizo/resources/apis/jobs_api_provider.dart';
import 'package:pizo/resources/sharedprefs.dart';
import 'package:pizo/ui/widgets/lists/jobs_list.dart';

class JobsTab extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _JobsTab();
  }
}

class _JobsTab extends State<JobsTab> {
  List<Job> jobs = new List();
  String token, email;

  Future<bool> getDate() {
    SharedPrefs().getSharedToken().then((token) {
      JobsAPI().getJobs(token).then((jbs) {
        setState(() {
          jobs = jbs;
        });
      });
    });
    return null;
  }

  @override
  void initState() {
    super.initState();
    getDate();

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
    return ListView(
      padding: EdgeInsets.all(0),
      shrinkWrap: true,
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(top: 10, bottom: 10),
          child: Row(
            children: <Widget>[
              Text(
                "Jobs offers",
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
        Container(
          child: jobs != null && jobs.length > 0
              ? JobsList(
                  jobs,
                  jobs.length,
                )
              : Container(),
        ),
      ],
    );
  }
}
