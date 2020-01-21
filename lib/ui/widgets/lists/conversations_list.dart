import 'package:flutter/material.dart';
import 'package:pizo/models/conversation.dart';
import 'package:pizo/ui/widgets/lists_item/conversation_item.dart';

class ConvsList extends StatelessWidget {
  List<Conversation> convs;
  int count;

  ConvsList(List<Conversation> convs, int count) {
    this.convs = convs;
    this.count = count;
  }
  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      padding: EdgeInsets.only(left: 10, right: 10),
      children: convsWidgets(),
    );
  }

  List<Widget> convsWidgets() {
    List<Widget> widgets = new List();
    for (int i = 0; i < count; i++) {
      widgets.add(ConvItem(convs.elementAt(i)));
    }
    return widgets;
  }
}
