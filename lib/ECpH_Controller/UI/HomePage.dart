import 'dart:async';
import 'dart:io';
import 'dart:ui';
import 'package:autoaqua/ECpH_Controller/UI/ClockTime_Page.dart';
import 'package:autoaqua/ECpH_Controller/UI/ECpH_Page.dart';
import 'package:autoaqua/ECpH_Controller/UI/SP_Page.dart';
import 'package:autoaqua/ECpH_Controller/UI/Schedule_Page.dart';
import 'package:autoaqua/ECpH_Controller/UI/SetMobNo_Page.dart';
import 'package:autoaqua/ECpH_Controller/UI/Status_Page.dart';
import 'package:autoaqua/UI/TopLevel/HomePage.dart';
import 'package:autoaqua/UI/TopLevel/LoginPage.dart';
import 'package:autoaqua/UI/Widgets/HeroAppBar.dart';
import 'package:autoaqua/Utils/APICallMethods.dart';
import 'package:autoaqua/Utils/CommonlyUserMethod.dart';
import 'package:autoaqua/Utils/Database_Client.dart';
import 'package:flutter/material.dart';


class ECpHome extends StatefulWidget {

  static Route<dynamic> route() {
    return MaterialPageRoute(
      builder: (context) => ECpHome(),
    );
  }

  @override
  _ECpHomeState createState() => _ECpHomeState();
}

class _ECpHomeState extends State<ECpHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Welcome Vikas!"),
        backgroundColor: Color.fromRGBO(0, 84, 179, 1.0),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.exit_to_app,color: Colors.white,),
              onPressed: (){
                //SharedPref().clearUserStatus();
                //SharedPref().setUserStatus(false);
                Navigator.of(context).pushReplacement(Login.route());
              }
          ),
        ],
      ),
      body: Container(
        decoration: new BoxDecoration(
          image: new DecorationImage(
            image: new AssetImage("Images/dashboardbackgroung.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,

          children: <Widget>[
            SizedBox(height: 10.0,),
            Expanded(
              flex: 8,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 18.0, horizontal: 8.0),
                child: GridView.count(
                  crossAxisSpacing: 60.0,
                  //mainAxisSpacing: 1.0,
                  crossAxisCount: 2,
                  children: <Widget>[
                    GridButtons(
                      'Images/recycle.png',
                      'SET EC/pH',
                      ECpH_Page(),
                    ),
                    GridButtons(
                      'Images/scheduler_icon.png',
                      'SCHEDULE',
                      Schedule_Page(),
                    ),
                    GridButtons(
                      'Images/flag.png',
                      'STATUS',
                      StatusPage(),
                    ),
                    GridButtons(
                      'Images/irrstop.png',
                      'IRR STOP',
                      StopPausePage(),
                    ),
                    GridButtons(
                      'Images/changenumber_icon.png',
                      'SET NUMBER',
                      SetMobNo(),
                    ),
                    GridButtons(
                      'Images/setclock.png',
                      'SET TIME',
                      SetClockTime(),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(flex: 2,child: Padding(
              padding: const EdgeInsets.fromLTRB(70.0, 30.0, 70.0, 50.0),
              child: RawMaterialButton(
                onPressed: () {
                  //_showDialog();
                  /*//Navigator.of(context).pop();
              //msgString.getDataforConfiguration(1);
              //getFoggerData();
              //Navigator.of(context).push(MaterialPageRoute(builder: (_)=> MyAppSMS()));
              apiMethods.onOffPouseController(
                widget.controllerID,
                "1"
              );
              print("Controller Id is ${widget.controllerID}");*/
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "SEND",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                fillColor: Color.fromRGBO(0, 84, 179, 1.0),
                shape: StadiumBorder(),
              ),
            ),)
          ],
        ),
      ),
    );
  }

  Widget GridButtons(String iconsPath,String text, Widget route){
    return MaterialButton(
      //color: Colors.lightBlueAccent,
      //shape: CircleBorder(),
      //padding: EdgeInsets.zero,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Expanded(
            //flex: 8,
            child: Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Color.fromRGBO(0, 84, 179, 1.0), width: 2.0, style: BorderStyle.solid),
                    shape: BoxShape.circle,
                    color: Colors.transparent //Color.fromRGBO(0, 84, 179, 1.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: ImageIcon(
                    AssetImage(iconsPath),
                    color: Color.fromRGBO(0, 84, 179, 1.0),
                    size: 40.0,
                  ),
                )),
          ),
          //SizedBox(height: 2.0),
          Expanded(
            //flex: 2,
            child: Text(
              text,
              style: TextStyle(fontSize: 20.0),
              textAlign: TextAlign.center,
              textScaleFactor: 0.85,
            ),
          )
        ],
      ),
      onPressed:(){
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => route),
        );
      }
    );
  }

}







