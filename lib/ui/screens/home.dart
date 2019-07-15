import 'package:flutter/material.dart';
import 'package:pizo/ui/home_tabs/dashboard_tab.dart';
import 'package:pizo/ui/home_tabs/devices_tab.dart';
import 'package:pizo/ui/home_tabs/events_tab.dart';
import 'package:pizo/ui/home_tabs/material_tab.dart';
import 'package:pizo/widgets/app_header.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  TabController _tabController;
  List<String> titles = [
    "Pizo app",
    "Buy",
    "Sell",
    "Maintenance",
    "Job offers",
    "Marketing",
    "Events"
  ];

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(length: 6, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        color: Colors.grey.shade200,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Stack(              
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    AppHeader(titles),
                    Container(
                      color: Colors.indigo,
                      margin: EdgeInsets.only(top: 70),
                      child: TabBar(                      
                        unselectedLabelColor: Colors.white.withAlpha(100),
                        labelColor: Colors.white,
                        indicatorColor: Colors.white,
                        isScrollable: true,
                        tabs: <Widget>[
                          new Tab(
                            text: "Home",
                          ),
                          new Tab(
                            text: "Devices",
                          ),
                          new Tab(
                            text: "Material",
                          ),
                          new Tab(
                            text: "Events",
                          ),
                          new Tab(
                            text: "Job Offers",
                          ),
                          new Tab(
                            text: "Dental Companies",
                          ),
                        ],
                        controller: _tabController,
                      ),
                    )
                  ],
                )
              ],
            ),
            Expanded(
              child: TabBarView(              
                children: [
                  DashboardTab(),
                  DevicesTab(),
                  MaterialTab(),
                  EventsTab(),
                  new Text("This is notification Tab View"),
                  new Text("This is chat Tab View"),
                ],
                controller: _tabController,
              ),
            )
          ],
        ));
  }
}

class HomeTab {
}
