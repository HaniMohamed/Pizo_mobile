import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:flutter/material.dart';
import 'package:pizo/widgets/signin.dart';
import 'package:pizo/widgets/signup.dart';

TabController _tabController;

class LoginWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LoginWidget();
  }

  login(var context) {
    print(_tabController.index.toString());
    _tabController.index == 1
        ? SignUp().signUp(context)
        : SignIn().signIn(context);
  }
}

class _LoginWidget extends State<LoginWidget> with TickerProviderStateMixin {
  int tabIndex = 0;
  double _height = 120;
  @override
  void initState() {
    super.initState();
    _tabController = new TabController(length: 2, vsync: this);
    _tabController.addListener(_handleTabSelection);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        TabBar(
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white.withAlpha(100),
          indicatorColor: Colors.white,
          indicator: new BubbleTabIndicator(
            indicatorHeight: 30.0,
            indicatorColor: Colors.white.withAlpha(80),
            tabBarIndicatorSize: TabBarIndicatorSize.tab,
          ),
          tabs: <Widget>[
            Tab(
              child: Text(
                "Sign in",
              ),
            ),
            Tab(
              child: Text(
                "Sign up",
              ),
            ),
          ],
          controller: _tabController,
        ),
        new AnimatedSize(
          curve: Curves.fastOutSlowIn,
          vsync: this,
          duration: new Duration(milliseconds: 1500),
          child: Container(
            height: _height,
            child: TabBarView(
              children: [
                SignIn(),
                SignUp(),
              ],
              controller: _tabController,
            ),
          ),
        ),
      ],
    );
  }

  _handleTabSelection() {
    setState(() {
      tabIndex = _tabController.index;
      _height = tabIndex == 0 ? 120 : 300;
      print("!!!!!!!!!!!!!!11 \n" + tabIndex.toString());
    });
  }
}
