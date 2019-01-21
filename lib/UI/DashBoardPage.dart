import 'dart:ui';

import 'package:autoaqua/Utils/Database_Client.dart';
import 'package:flutter/material.dart';

class DashboardPage extends StatefulWidget {
  List<String> _HUName = <String>[];
  List<String> _ControllerName = <String>[];
  List<String> _ControllerName1 = ["1","2","3"];
  String selectedHU;
  String selectedController;
  int _selectedHUIndex;
  int _selectedControllerIndex;

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final db = new DataBaseHelper();
  int otherData = 0;

  Future<void> _loadHUData() async {
    var HUdata = await db.getHUDataAsString();
    var ControllerData = await db.getControllerDataAsString(widget._selectedHUIndex.toString());
    if(mounted){
      setState(() {
        widget._HUName = HUdata;
        widget._ControllerName = ControllerData;
      });
    }
  }

  Future _loadControllerData(int HUid) async {
    var ControllerData = await db.getControllerDataAsString(HUid.toString());
    if (ControllerData != null) {
      if(mounted){
        setState(() {
          widget._ControllerName = ControllerData;
        });
      }
    }
  }

  Future _loadOtherData(int ctrlId)async{
    var valveData = await db.getValvesLtrCount(ctrlId);
    if(valveData != null){
      setState(() {
        otherData = valveData;
        print("Other data is $otherData");
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _loadHUData();
    // _loadControllerData(1);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          image: new DecorationImage(
            image: new AssetImage("Images/dashboardbackgroung.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: ListView(
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    DropdownButton<String>(
                      hint: Text(
                        "Select HeadUnit",
                        style: TextStyle(color: Colors.white, fontSize: 15.0),
                      ),
                      style: TextStyle(
                        color: Colors.black,
                      ),
                      value: widget.selectedHU,
                      items: widget._HUName.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value,textAlign: TextAlign.center,),
                        );
                      }).toList(),
                      onChanged: (String hu) {
                        setState(() {
                          widget.selectedHU = hu;
                          widget._selectedHUIndex = widget._HUName.indexOf(hu) + 1;
                          _loadControllerData(widget._selectedHUIndex);
                          print("Slected option is ${widget._selectedHUIndex}");
                        });
                      },
                    ),
                    DropdownButton<String>(
                      hint: Text(
                        "Select Controller",
                        style: TextStyle(color: Colors.white, fontSize: 15.0),
                      ),
                      style: TextStyle(
                        color: Colors.black,
                      ),
                      value: widget.selectedController,
                      items: widget._ControllerName.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (String hu) {
                        setState(() {
                          widget.selectedController = hu;
                          widget._selectedControllerIndex = widget._ControllerName.indexOf(hu) + 1;
                          _loadOtherData(1);
                          print("Slected Controller index is ${widget._selectedControllerIndex}");
                        });
                      },
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                          color: Color.fromRGBO(0, 84, 179, 1.0),
                          borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(40.0),
                            topRight: Radius.circular(40.0),
                          )),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(25.0, 8.0, 8.0, 8.0),
                        child: Text(
                          "CONTROLLER STATUS",
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 10.0,
                ),
                Center(
                  child: Text(
                    "Status",
                    style: TextStyle(
                      fontSize: 30.0,
                      color: Colors.blue,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Container(
                            width: 70.0,
                            height: 70.0,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  '$otherData',
                                  style: TextStyle(color: Colors.brown, fontSize: 20.0),
                                ),
                                Text(
                                  '(mins)',
                                  style: TextStyle(color: Colors.blueAccent, fontSize: 10.0),
                                ),
                              ],
                            ),
                            padding: const EdgeInsets.all(2.0), // borde width
                            decoration: new BoxDecoration(
                                color: Colors.transparent, // border color
                                shape: BoxShape.rectangle,
                                border: new Border.all(color: Colors.blueAccent, width: 2.0, style: BorderStyle.solid),
                                borderRadius: BorderRadius.all(Radius.circular(20.0)))),
                        Text(
                          'Remaining \n Time',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.blueAccent, fontSize: 15.0),
                        ),
                      ],
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
                          'Remaining \n Volume',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.blueAccent, fontSize: 15.0),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 10.0,
                ),
                Container(
                  width: 180.0,
                  //color: Color.fromRGBO(0, 84, 179, 1.0),
                  decoration: BoxDecoration(
                      color: Color.fromRGBO(0, 84, 179, 1.0),
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(40.0),
                        topRight: Radius.circular(40.0),
                      )),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(65.0, 8.0, 8.0, 8.0),
                    child: Text(
                      "OBSERVATION",
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
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
                                  '08.50',
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
                                borderRadius: BorderRadius.all(Radius.circular(20.0)))),
                      ],
                    ),
                    Image.asset(
                      "Images/ec2.png",
                      height: 60.0,
                      width: 60.0,
                    ),
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
                                  'Current',
                                  style: TextStyle(color: Colors.blueAccent, fontSize: 10.0),
                                ),
                              ],
                            ),
                            padding: const EdgeInsets.all(2.0), // borde width
                            decoration: new BoxDecoration(
                                shape: BoxShape.rectangle,
                                border: new Border.all(color: Colors.blueAccent, width: 2.0, style: BorderStyle.solid),
                                borderRadius: BorderRadius.all(Radius.circular(20.0)))),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 20.0,
                ),
                Divider(
                  height: 2.0,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Text(
                            "Lux",
                            style: TextStyle(color: Colors.blueAccent, fontSize: 20.0),
                          ),
                          Container(
                              height: 70.0,
                              width: 70.0,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    '080',
                                    style: TextStyle(color: Colors.brown, fontSize: 20.0),
                                  ),
                                  Text(
                                    'k/lux',
                                    style: TextStyle(color: Colors.blueAccent, fontSize: 10.0),
                                  ),
                                ],
                              ),
                              padding: const EdgeInsets.all(2.0), // borde width
                              decoration: new BoxDecoration(
                                  shape: BoxShape.rectangle,
                                  border:
                                      new Border.all(color: Colors.blueAccent, width: 2.0, style: BorderStyle.solid),
                                  borderRadius: BorderRadius.all(Radius.circular(20.0)))),
                        ],
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      Image.asset(
                        "Images/ec3.png",
                        height: 60.0,
                        width: 60.0,
                      ),
                      Column(
                        children: <Widget>[
                          Text(
                            "Soil Moisture",
                            style: TextStyle(color: Colors.blueAccent, fontSize: 20.0),
                          ),
                          Container(
                              height: 70.0,
                              width: 70.0,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    '35.00',
                                    style: TextStyle(color: Colors.brown, fontSize: 20.0),
                                  ),
                                  Text(
                                    '%',
                                    style: TextStyle(color: Colors.blueAccent, fontSize: 10.0),
                                  ),
                                ],
                              ),
                              padding: const EdgeInsets.all(2.0), // borde width
                              decoration: new BoxDecoration(
                                  shape: BoxShape.rectangle,
                                  border:
                                      new Border.all(color: Colors.blueAccent, width: 2.0, style: BorderStyle.solid),
                                  borderRadius: BorderRadius.all(Radius.circular(20.0)))),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            )
          ],
        ));
  }
}
