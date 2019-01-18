import 'package:flutter/material.dart';
import 'package:autoaqua/Utils/CommonlyUserMethod.dart';

class StatusPage extends StatefulWidget {
  @override
  _StatusPageState createState() => _StatusPageState();
}

class _StatusPageState extends State<StatusPage> {
  @override
  Widget build(BuildContext context) {
    return CommonBodyStrecture(
      text: "STATUS",
      child: Form(
          child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 10.0,
            ),
            Text("Last Sync date is 15 Jan 2018 13:22"),
            commonDivider(),
            Text(
              "MOTOR IS ON/OFF:",
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10.0,
            ),
            CircleAvatar(
              radius: 45.0,
              backgroundColor: Colors.lightGreen.withOpacity(0.7),
              child: Icon(
                Icons.done,
                color: Colors.white,
                size: 50.0,
              ),
            ),
            commonDivider(),
            Column(
              children: <Widget>[
                Container(
                    height: 70.0,
                    width: 70.0,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          '500',
                          style: TextStyle(color: Colors.brown, fontSize: 20.0),
                        ),
                        Text(
                          '(liters)',
                          style: TextStyle(color: Colors.blueAccent, fontSize: 10.0),
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.all(2.0), // borde width
                    decoration: new BoxDecoration(
                      //color: Colors.blueAccent, // border color
                      shape: BoxShape.rectangle,
                      border: new Border.all(color: Colors.blueAccent, width: 2.0, style: BorderStyle.solid),
                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                    )),
                Text(
                  'Remaining \n Time',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.blueAccent, fontSize: 15.0),
                ),
                commonDivider(),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Text(
                      "EC",
                      style: TextStyle(color: Colors.blueAccent, fontSize: 30.0),
                    ),
                    Container(
                        height: 70.0,
                        width: 70.0,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              '07.50',
                              style: TextStyle(color: Colors.brown, fontSize: 20.0),
                            ),
                            Text(
                              'mS/Cm',
                              style: TextStyle(color: Colors.blueAccent, fontSize: 10.0),
                            ),
                          ],
                        ),
                        padding: const EdgeInsets.all(2.0), // borde width
                        decoration: new BoxDecoration(
                            shape: BoxShape.rectangle,
                            border: new Border.all(color: Colors.blueAccent, width: 2.0, style: BorderStyle.solid),
                            borderRadius: BorderRadius.all(Radius.circular(20.0)))
                    ),
                    SizedBox(height: 20.0,),
                  ],
                ),
                Column(
                  children: <Widget>[
                    Text(
                      "pH",
                      style: TextStyle(color: Colors.blueAccent, fontSize: 30.0),
                    ),
                    Container(
                        height: 70.0,
                        width: 70.0,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              '07.50',
                              style: TextStyle(color: Colors.brown, fontSize: 20.0),
                            ),
                            Text(
                              'pH',
                              style: TextStyle(color: Colors.blueAccent, fontSize: 10.0),
                            ),
                          ],
                        ),
                        padding: const EdgeInsets.all(2.0), // borde width
                        decoration: new BoxDecoration(
                            shape: BoxShape.rectangle,
                            border: new Border.all(color: Colors.blueAccent, width: 2.0, style: BorderStyle.solid),
                            borderRadius: BorderRadius.all(Radius.circular(20.0))
                        )
                    ),
                    SizedBox(height: 20.0,),
                  ],
                ),
              ],
            ),
          ],
        ),
      )),
    );
  }
}
