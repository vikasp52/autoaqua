import 'package:autoaqua/UI/ControllerDetails/ControllerDetails.dart';
import 'package:flutter/material.dart';

class TimerPage extends StatefulWidget {

  static Route<dynamic> route(int controllerId) {
    return ControllerDetailsPageRoute(
      pageId: ControllerDetailsPageId.TIMER,
      builder: (context) => TimerPage(
        controllerId: controllerId,
      ),
    );
  }

  const TimerPage({
    Key key,
    @required this.controllerId,
  }) : super(key: key);

  final int controllerId;

  @override
  _TimerPageState createState() => _TimerPageState();
}

class _TimerPageState extends State<TimerPage> {
  @override
  Widget build(BuildContext context) {
    final int maxIndex = 3;
    return ControllerDetailsPageFrame(
      child: ListView.builder(
        itemCount: maxIndex,
        itemBuilder: (BuildContext context, int index){
          return ListTile(
            title: Card(
                color: Colors.lightBlueAccent.shade100,
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Text("PROGRAM ${index+1}", style: TextStyle(
                      //fontWeight: FontWeight.bold,
                      fontSize: 20.0
                  ),),
                )
            ),
            onTap: () => Navigator.of(context).push(
               _TimerOption.route(widget.controllerId, index, maxIndex),
            ),
          );
        },
      ),
    );
  }
}

class _TimerOption extends StatefulWidget {

  static Route<dynamic> route(int controllerId, int timerIndex, int maxIndex) {
    return MaterialPageRoute(
      builder: (context) => _TimerOption(
        controllerId: controllerId,
        timerIndex: timerIndex,
        maxIndex: maxIndex,
      ),
    );
  }

  const _TimerOption({
    Key key,
    @required this.controllerId,
    @required this.timerIndex,
    @required this.maxIndex,
  }) : super(key: key);

  final int controllerId;
  final int timerIndex;
  final int maxIndex;

  @override
  _TimerOptionState createState() => _TimerOptionState();
}

class _TimerOptionState extends State<_TimerOption> {

  bool checkboxIntegrationDat_Mon = true;
  bool checkboxIntegrationDat_Tues = true;
  bool checkboxIntegrationDat_Wed = true;
  bool checkboxIntegrationDat_Thurs = true;
  bool checkboxIntegrationDat_Friday = true;
  bool checkboxIntegrationDat_Sat = true;
  bool checkboxIntegrationDat_Sun = true;

  bool checkboxFertDay_Mon = true;
  bool checkboxFertDay_Tues = true;
  bool checkboxFertDay_Wed = true;
  bool checkboxFertDay_Thurs = true;
  bool checkboxFertDay_Fri = true;
  bool checkboxFertDay_Sat = true;
  bool checkboxFertDay_Sun = true;

  @override
  Widget build(BuildContext context) {
    return ControllerDetailsPageFrame(
      title: "Timer",
      child: ListView(
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 18.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      //color: Color.fromRGBO(0, 84, 179, 1.0),
                      decoration: ShapeDecoration(shape: StadiumBorder(), color: Color.fromRGBO(0, 84, 179, 1.0)),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(25.0, 8.0, 8.0, 8.0),
                        child: Text("Program No: ${widget.timerIndex+1}", style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold
                        ),),
                      ),

                    )
                  ],
                ),
              ),
              SizedBox(height: 20.0,),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text("Start time.",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: 50.0,
                    child: TextFormField(
                      style: TextStyle(fontSize: 20.0,
                          color: Colors.black),
                      decoration: InputDecoration(
                          labelText: 'Hrs'
                      ),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(":", style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold
                    ),),
                  ),
                  Container(
                    width: 50.0,
                    child: TextFormField(
                      style: TextStyle(fontSize: 20.0,
                          color: Colors.black),
                      decoration: InputDecoration(
                          labelText: 'Min'
                      ),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text("AM", style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold
                    ),),
                  ),
                ],
              ),
              SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("Integration Days",
                    style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: 150.0,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Checkbox(
                              value: checkboxIntegrationDat_Sun,
                              onChanged: (bool value) {
                                setState(() {
                                  checkboxIntegrationDat_Sun= value;
                                });
                              },
                            ),
                            Text("Sun")
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Checkbox(
                              value: checkboxIntegrationDat_Mon,
                              onChanged: (bool value) {
                                setState(() {
                                  checkboxIntegrationDat_Mon = value;
                                });
                              },
                            ),
                            Text("Mon")
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Checkbox(
                              value: checkboxIntegrationDat_Tues,
                              onChanged: (bool value) {
                                setState(() {
                                  checkboxIntegrationDat_Tues = value;
                                });
                              },
                            ),
                            Text("Tue")
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Checkbox(
                              value: checkboxIntegrationDat_Wed,
                              onChanged: (bool value) {
                                setState(() {
                                  checkboxIntegrationDat_Wed = value;
                                });
                              },
                            ),
                            Text("Wed")
                          ],
                        ),
                      ],
                    ),
                  ),
                  Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Checkbox(
                            value: checkboxIntegrationDat_Thurs,
                            onChanged: (bool value) {
                              setState(() {
                                checkboxIntegrationDat_Thurs= value;
                              });
                            },
                          ),
                          Text("Thu")
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Checkbox(
                            value: checkboxIntegrationDat_Friday,
                            onChanged: (bool value) {
                              setState(() {
                                checkboxIntegrationDat_Friday = value;
                              });
                            },
                          ),
                          Text("Fri")
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Checkbox(
                            value: checkboxIntegrationDat_Sat,
                            onChanged: (bool value) {
                              setState(() {
                                checkboxIntegrationDat_Sat= value;
                              });
                            },
                          ),
                          Text("Sat")
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("Fert Days",
                    style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: 150.0,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Checkbox(
                              value: checkboxFertDay_Sun,
                              onChanged: (bool value) {
                                setState(() {
                                  checkboxFertDay_Sun= value;
                                });
                              },
                            ),
                            Text("Sun")
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Checkbox(
                              value: checkboxFertDay_Mon,
                              onChanged: (bool value) {
                                setState(() {
                                  checkboxFertDay_Mon = value;
                                });
                              },
                            ),
                            Text("Mon")
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Checkbox(
                              value: checkboxFertDay_Tues,
                              onChanged: (bool value) {
                                setState(() {
                                  checkboxFertDay_Tues = value;
                                });
                              },
                            ),
                            Text("Tue")
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Checkbox(
                              value: checkboxFertDay_Wed,
                              onChanged: (bool value) {
                                setState(() {
                                  checkboxFertDay_Wed = value;
                                });
                              },
                            ),
                            Text("Wed")
                          ],
                        ),
                      ],
                    ),
                  ),
                  Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Checkbox(
                            value: checkboxFertDay_Thurs,
                            onChanged: (bool value) {
                              setState(() {
                                checkboxFertDay_Thurs= value;
                              });
                            },
                          ),
                          Text("Thu")
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Checkbox(
                            value: checkboxFertDay_Fri,
                            onChanged: (bool value) {
                              setState(() {
                                checkboxFertDay_Fri = value;
                              });
                            },
                          ),
                          Text("Fri")
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Checkbox(
                            value: checkboxFertDay_Sat,
                            onChanged: (bool value) {
                              setState(() {
                                checkboxFertDay_Sat= value;
                              });
                            },
                          ),
                          Text("Sat")
                        ],
                      ),
                    ],
                  ),
                ],
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  RawMaterialButton(
                    onPressed: (){
                      int nextIndex = widget.timerIndex + 1;
                      if(nextIndex < widget.maxIndex){
                        Navigator.of(context).pushReplacement(
                          _TimerOption.route(widget.controllerId,
                              nextIndex, widget.maxIndex),
                        );
                      }else{
                        ControllerDetails.navigateToPage(context, ControllerDetailsPageId.TIMER.nextPageId);
                      }
                    },
                    fillColor: Colors.indigo,
                    splashColor: Colors.white,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15.0),
                      child: Text("SAVE",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    shape: const StadiumBorder(),
                  ),
                  SizedBox.fromSize(
                    size: Size(10.0, 10.0),
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
