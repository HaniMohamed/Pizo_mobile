import 'package:flutter/material.dart';
import 'package:pizo/ui/screens/chat_screen.dart';
import 'package:pizo/ui/screens/home.dart';
import 'package:pizo/ui/screens/orders_page.dart';


class MainPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _MainPage();
  }

}

class _MainPage extends State<MainPage> with SingleTickerProviderStateMixin{

   TabController _tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = new TabController(length: 4, vsync: this);
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
          body: TabBarView(
            children: [
              Home(),
              OrdersPage(),
              ChatScreen(),
              new Text("This is profile Tab View"),
            ],
            controller: _tabController,
          ),
          bottomNavigationBar: Container(
            color: Colors.grey.shade200,
            child: Card(
              semanticContainer: false,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: TabBar(
                unselectedLabelColor: Colors.grey,
                labelColor: Colors.blue,
                controller: _tabController,
                indicatorSize: TabBarIndicatorSize.tab,
                indicatorWeight: 3.0,
                tabs: <Widget>[
                  Tab(
                    child: Icon(
                      Icons.home,
                      size: 20,
                    ),
                  ),
                  Tab(
                    child: Icon(
                      Icons.settings,
                      size: 20,
                    ),
                  ),
                  Tab(
                    child: Icon(
                      Icons.chat,
                      size: 20,
                    ),
                  ),
                  Tab(
                    child: Icon(
                      Icons.person,
                      size: 20,
                    ),
                  ),
                ],
              ),
            ),
          ),
    );
  }

}