import 'package:flutter/material.dart';
import 'package:pizo/models/job.dart';
import 'package:pizo/ui/widgets/lists_item/job_item.dart';

class JobsList extends StatelessWidget {
  List<Job> jobs;
  int count;

  JobsList(List<Job> jobs, int count) {
    this.jobs = jobs;
    this.count = count;
  }
  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      padding: EdgeInsets.only(left: 10, right: 10),
      children: jobsWidgets(),
    );
  }

  List<Widget> jobsWidgets() {
    List<Widget> widgets = new List();
    for (int i = 0; i < count; i++) {
      widgets.add(JobItem(jobs.elementAt(i)));
    }
    return widgets;
  }
}
