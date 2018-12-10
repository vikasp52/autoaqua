import 'package:autoaqua/UI/Controller.dart';
import 'package:autoaqua/UI/DashBoardPage.dart';
import 'package:autoaqua/UI/TopLevel/LoginPage.dart';
import 'package:autoaqua/Utils/CommonlyUserMethod.dart';
import 'package:autoaqua/Utils/sharedPref.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';

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
  Controller two;
  Profile three;
  List<Widget> pages;
  Widget currentPage;

  @override
  void initState() {
    one = DashboardPage();
    two = Controller();
    three = Profile();
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
            iconTheme: new IconThemeData(color: Color.fromRGBO(0, 84, 179, 1.0)),
            title: new Text(
              "Welcome",
              textAlign: TextAlign.left,
              style: TextStyle(fontWeight: FontWeight.bold, color: Color.fromRGBO(0, 84, 179, 1.0)),
            ),
            backgroundColor: Colors.white,
            actions: <Widget>[
              IconButton(
                icon: Image.asset(
                  "Images/notify.png",
                  width: 25.0,
                ),
                onPressed: null,
                color: Colors.blueAccent,
              ),
              IconButton(
                icon: Image.asset(
                  "Images/exit.png",
                  width: 25.0,
                ),
                onPressed: (){
                  SharedPref().clearUserStatus();
                  //SharedPref().setUserStatus(false);
                  Navigator.of(context).pushReplacement(Login.route());
                }
              ),
            ],
          ),
          drawer: new Drawer(
            elevation: 3.0,
            child: new ListView(
              children: <Widget>[
                UserAccountsDrawerHeader(
                  accountName: Text("Welcome to AutoAqua",
                      style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20.0)),
                  decoration: BoxDecoration(color: Colors.cyan),
                  accountEmail: Text(
                    "vikasp613@gmail.com",
                    style: TextStyle(color: Colors.black, fontStyle: FontStyle.italic),
                  ),
                  currentAccountPicture: CircleAvatar(
                    child: Icon(Icons.person),
                  ),
                ),
                ListTile(
                  title: Text("How to use"),
                  leading: Icon(Icons.call_split),
                  onTap: () {
                    Navigator.of(context).pop();
                    showDialog(
                      context: context,
                      builder: (_) => new AlertDialog(
                            content: Container(
                              //color: Colors.cyan,
                              decoration: BoxDecoration(
                                  //color: Colors.cyan,
                                  borderRadius: BorderRadius.all(
                                Radius.circular(0.0),
                              )),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    new Text(
                                      "Step 1:",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20.0,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 8.0,
                                    ),
                                    Text(
                                      "Click on Add Button at the bottom. Dialog will appear then add your task and save it. \n",
                                      style: TextStyle(
                                        fontSize: 15.0,
                                      ),
                                    ),
                                    new Text(
                                      "Step 2:",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20.0,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 8.0,
                                    ),
                                    Text(
                                      "By mistake, entered wrong details. No problem. long press the task, then pop up will appear. Update it and save again. \n",
                                      style: TextStyle(
                                        fontSize: 15.0,
                                      ),
                                    ),
                                    new Text(
                                      "Step 3:",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20.0,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 8.0,
                                    ),
                                    Text(
                                      "Done with task, delete it by pressing delete icon in that task. \n",
                                      style: TextStyle(
                                        fontSize: 15.0,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                    );
                  },
                ),
                ListTile(
                  title: Text("Share"),
                  leading: Icon(Icons.share),
                  onTap: () {},
                ),
                ListTile(
                  title: Text("Rate us"),
                  leading: Icon(Icons.stars),
                  onTap: () {},
                ),
                ListTile(
                  title: Text("About us"),
                  leading: Icon(Icons.account_box),
                  onTap: () {
                    Navigator.of(context).pop();
                    showDialog(
                      context: context,
                      builder: (_) => new AlertDialog(
                            title: new Text("About us"),
                            content: Container(
                              //color: Colors.cyan,
                              decoration: BoxDecoration(
                                  //color: Colors.cyan,
                                  borderRadius: BorderRadius.all(
                                Radius.circular(0.0),
                              )),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    new Text(
                                      "MyTask",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20.0,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 8.0,
                                    ),
                                    Text(
                                      "This is a simple mobile application to manage your day to day task. \n"
                                          "You can add you task one by one and delete it once you are done with that task. \n"
                                          "You can also update it by long press on that task. \n"
                                          "\n"
                                          "Write us: vikasp613@gmail.com \n"
                                          "\n"
                                          "Regards \nVikas Pandey",
                                      style: TextStyle(
                                        fontSize: 15.0,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                    );
                  },
                ),
                ListTile(
                  title: Text("Close"),
                  leading: Icon(Icons.close),
                  onTap: () => Navigator.of(context).pop(),
                )
              ],
            ),
          ),
          body: currentPage,
          bottomNavigationBar: new Theme(
            data: Theme.of(context).copyWith(
                // sets the background color of the `BottomNavigationBar`
                canvasColor: Color.fromRGBO(0, 73, 186, 1.0),
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
                    icon: new Icon(Icons.dashboard), title: new Text('Dashboard'), backgroundColor: Colors.blue),
                BottomNavigationBarItem(
                  icon: new Icon(Icons.control_point_duplicate),
                  title: new Text('Controller'),
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
    return Padding(
      padding: EdgeInsets.all(18.0),
      child: Container(
        color: Colors.green,
        child: Center(
          child: Text(
            "Under Development",
            style: TextStyle(fontSize: 30.0),
          ),
        ),
      ),
    );
  }
}
