import 'package:autoaqua/UI/DashBoardPage.dart';
import 'package:autoaqua/UI/HeadUnit.dart';
import 'package:autoaqua/UI/TopLevel/LoginPage.dart';
import 'package:autoaqua/UI/TopLevel/Reports.dart';
import 'package:autoaqua/Utils/CommonlyUserMethod.dart';
import 'package:autoaqua/Utils/sharedPref.dart';
import 'package:flutter/material.dart';

class HomePageRoute extends MaterialPageRoute {
  HomePageRoute()
      : super(
          builder: (context) => HomePage(),
        );
}

class HomePage extends StatefulWidget {
  static Route<dynamic> route() {
    return HomePageRoute();
  }

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currenTab = 0;
  DashboardPage one;
  HeadUnit two;
  MyHomePage three;
  List<Widget> pages;
  Widget currentPage;

  @override
  void initState() {
    one = DashboardPage();
    two = HeadUnit();
    three = MyHomePage();
    pages = [one, two, three];
    currentPage = one;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => willPop(context),
      child: Scaffold(
          appBar: AppBar(
            iconTheme: new IconThemeData(color: Colors.white),
            title: new Text(
              "Welcome",
              textAlign: TextAlign.left,
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
            ),
            backgroundColor: Color.fromRGBO(0, 84, 179, 1.0),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.notifications,color: Colors.white,),
                /*Image.asset(
                  "Images/notify.png",
                  width: 25.0,
                ),*/
                onPressed: null,
                //color: Colors.blueAccent,
              ),
              IconButton(
                icon: Icon(Icons.exit_to_app,color: Colors.white,),
                /*Image.asset(
                  "Images/exit.png",
                  width: 25.0,
                ),*/
                onPressed: (){
                  SharedPref().clearUserStatus();
                  //SharedPref().setUserStatus(false);
                  Navigator.of(context).pushReplacement(Login.route());
                }
              ),
            ],
          ),
          drawer: commonDrawer(),
          body: currentPage,
          bottomNavigationBar: new Theme(
            data: Theme.of(context).copyWith(
                // sets the background color of the `BottomNavigationBar`
                canvasColor: Color.fromRGBO(0, 84, 179, 1.0),
                // sets the active color of the `BottomNavigationBar` if `Brightness` is light
                primaryColor: Colors.green,
                textTheme: Theme.of(context).textTheme.copyWith(
                    caption:
                        new TextStyle(color: Colors.white))), // sets the inactive color of the `BottomNavigationBar`
            child: BottomNavigationBar(
              //fixedColor: Colors.deepOrange,
              currentIndex: currenTab,
              onTap: (int index) {
                setState(() {
                  currenTab = index;
                  currentPage = pages[index];
                });
              },
              items: [
                BottomNavigationBarItem(
                    icon: new Icon(Icons.dashboard), title: new Text('Dashboard'), backgroundColor: Color.fromRGBO(0, 84, 179, 1.0)),
                BottomNavigationBarItem(
                  icon: new Icon(Icons.control_point_duplicate),
                  title: new Text('Head Unit'),
                ),
                BottomNavigationBarItem(
                  icon: new Icon(Icons.repeat_one),
                  title: new Text('Reports'),
                ),
              ],
            ),
          )
      ),
    );
  }

  /*BottomNavigationBar createBottomNavigation() {
    var btm = BottomNavigationBar(
      //fixedColor: Colors.deepOrange,
      currentIndex: currenTab,
      onTap: (int index){
        setState(() {
          currenTab = index;
          currentPage = pages[index];
        });
      },
      items: [
        BottomNavigationBarItem(
          icon: new Icon(Icons.dashboard),
          title: new Text('Dashboard'),
          backgroundColor: Colors.blue
        ),
        BottomNavigationBarItem(
          icon: new Icon(Icons.account_balance_wallet),
          title: new Text('Controller'),
        ),
        BottomNavigationBarItem(
          icon: new Icon(Icons.person),
          title: new Text('Reports'),
        ),
      ],
    );
    return btm;
  }*/
}

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: RaisedButton(
          child: Text("Save"),
            onPressed: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MyHomePage()),
              );
        }),
      ),
    );
  }
}
