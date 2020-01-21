import 'package:flutter/material.dart';
import 'package:pizo/ui/screens/Messages_home_page.dart';
import 'package:pizo/ui/screens/home.dart';
import 'package:pizo/ui/screens/orders_page.dart';
import 'package:pizo/ui/screens/profile_page.dart';
import 'package:pizo/ui/widgets/wavy_header_image.dart';

class MainPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MainPage();
  }
}

class _MainPage extends State<MainPage> with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.all(0),
          children: <Widget>[
            DrawerHeader(
              child: Container(
                alignment: Alignment.center,
                child: Image.asset(
                  "asset/images/logo.png",
                  width: 120,
                ),
              ),
              decoration: BoxDecoration(
                image: new DecorationImage(
                  image: new ExactAssetImage('asset/images/header.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            ListTile(
              title: Row(
                children: <Widget>[
                  Card(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    semanticContainer: false,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: Container(
                      padding: EdgeInsets.all(5),
                      child: Icon(
                        Icons.home,
                        size: 25,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 10),
                    child: Text(
                      "Home",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
              onTap: () {
                _tabController.index = 0;
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Row(
                children: <Widget>[
                  Card(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      semanticContainer: false,
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      child: Container(
                        padding: EdgeInsets.all(5),
                        child: Icon(
                          Icons.settings,
                          size: 25,
                          color: Colors.blue,
                        ),
                      )),
                  Container(
                    margin: EdgeInsets.only(left: 10),
                    child: Text(
                      "Mantainance orders",
                      style: TextStyle(fontSize: 14),
                    ),
                  ),
                ],
              ),
              onTap: () {
                _tabController.index = 1;
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Row(
                children: <Widget>[
                  Card(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      semanticContainer: false,
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      child: Container(
                          padding: EdgeInsets.all(5),
                          child: Icon(
                            Icons.chat,
                            size: 25,
                            color: Colors.blue,
                          ))),
                  Container(
                    margin: EdgeInsets.only(left: 10),
                    child: Text(
                      "Messages",
                      style: TextStyle(fontSize: 14),
                    ),
                  ),
                ],
              ),
              onTap: () {
                _tabController.index = 2;
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Row(
                children: <Widget>[
                  Card(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      semanticContainer: false,
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      child: Container(
                          padding: EdgeInsets.all(5),
                          child: Icon(
                            Icons.person,
                            size: 25,
                            color: Colors.blue,
                          ))),
                  Container(
                    margin: EdgeInsets.only(left: 10),
                    child: Text(
                      "Profile",
                      style: TextStyle(fontSize: 14),
                    ),
                  ),
                ],
              ),
              onTap: () {
                _tabController.index = 3;
                Navigator.pop(context);
              },
            ),
            Divider(
              color: Colors.grey,
            ),
            ListTile(
              title: Row(
                children: <Widget>[
                  Card(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      semanticContainer: false,
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      child: Container(
                          padding: EdgeInsets.all(5),
                          child: Icon(
                            Icons.info,
                            size: 25,
                            color: Colors.grey,
                          ))),
                  Container(
                    margin: EdgeInsets.only(left: 10),
                    child: Text(
                      "About app",
                      style: TextStyle(fontSize: 14),
                    ),
                  ),
                ],
              ),
              onTap: () {},
            ),
            ListTile(
              title: Row(
                children: <Widget>[
                  Card(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      semanticContainer: false,
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      child: Container(
                          padding: EdgeInsets.all(5),
                          child: Icon(
                            Icons.share,
                            size: 25,
                            color: Colors.grey,
                          ))),
                  Container(
                    margin: EdgeInsets.only(left: 10),
                    child: Text(
                      "Share app",
                      style: TextStyle(fontSize: 14),
                    ),
                  ),
                ],
              ),
              onTap: () {},
            ),
            ListTile(
              title: Row(
                children: <Widget>[
                  Card(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      semanticContainer: false,
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      child: Container(
                          padding: EdgeInsets.all(5),
                          child: Icon(
                            Icons.contact_phone,
                            size: 25,
                            color: Colors.grey,
                          ))),
                  Container(
                    margin: EdgeInsets.only(left: 10),
                    child: Text(
                      "Call us",
                      style: TextStyle(fontSize: 14),
                    ),
                  ),
                ],
              ),
              onTap: () {},
            ),
          ],
        ),

        elevation: 30,
      ),
      body: TabBarView(
        children: [
          Home(),
          OrdersPage(),
          MessagesPage(),
          ProfilePage(),
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
