import 'package:autoaqua/Model/TimerModel.dart';
import 'package:autoaqua/UI/ControllerDetails/ControllerDetails.dart';
import 'package:autoaqua/UI/ControllerDetails/ProgramPage.dart';
import 'package:autoaqua/Utils/Database_Client.dart';
import 'package:autoaqua/Utils/DateFormatter.dart';
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
  var _maxProgram;
  Future _loading;
  DataBaseHelper dbh = DataBaseHelper();

  @override
  void initState() {
    super.initState();
    _loading = dbh.getConfigDataForController(widget.controllerId).then((config) {
      //_oldConfig = config;
      if (config != null) {
        setState(() {
          _maxProgram = int.parse(config.configMaxProg); //TextEditingValue(text: config.configMaxProg);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ControllerDetailsPageFrame(
      child: ListView.builder(
        itemCount: _maxProgram,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Card(
                color: Colors.lightBlueAccent.shade100,
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Text(
                    "PROGRAM ${index + 1}",
                    style: TextStyle(
                        //fontWeight: FontWeight.bold,
                        fontSize: 20.0),
                  ),
                )),
            onTap: () => Navigator.of(context).push(
                  _TimerOption.route(widget.controllerId, index, _maxProgram),
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
  final TextEditingController _hrsController = new TextEditingController();
  final TextEditingController _minController = new TextEditingController();

  bool checkboxIntegrationDay_Mon = true;
  bool checkboxIntegrationDay_Tues = true;
  bool checkboxIntegrationDay_Wed = true;
  bool checkboxIntegrationDay_Thurs = true;
  bool checkboxIntegrationDay_Friday = true;
  bool checkboxIntegrationDay_Sat = true;
  bool checkboxIntegrationDay_Sun = true;

  bool checkboxFertDay_Mon = true;
  bool checkboxFertDay_Tues = true;
  bool checkboxFertDay_Wed = true;
  bool checkboxFertDay_Thurs = true;
  bool checkboxFertDay_Fri = true;
  bool checkboxFertDay_Sat = true;
  bool checkboxFertDay_Sun = true;

  TimerModel _oldTimerData;
  DataBaseHelper db = new DataBaseHelper();
  Future loading;

  @override
  void initState() {
    super.initState();
    print("THis is database table for Configuration ${db.getProgramItems()}");

    loading = db.getTimerData(widget.controllerId, widget.timerIndex).then((timerData) {
      _oldTimerData = timerData;
      if (timerData != null) {
        setState(() {
          _hrsController.value = TextEditingValue(text: timerData.timer_StartTimer_Hrs);
          _minController.value = TextEditingValue(text: timerData.timer_StartTimer_Min);
          checkboxIntegrationDay_Mon = timerData.timer_IntegrationDay_Mon == 'true' ? true : false;
          checkboxIntegrationDay_Tues = timerData.timer_IntegrationDay_Tue == 'true' ? true : false;
          checkboxIntegrationDay_Wed = timerData.timer_IntegrationDay_Wed == 'true' ? true : false;
          checkboxIntegrationDay_Thurs = timerData.timer_IntegrationDay_Thur == 'true' ? true : false;
          checkboxIntegrationDay_Friday = timerData.timer_IntegrationDay_Fri == 'true' ? true : false;
          checkboxIntegrationDay_Sat = timerData.timer_IntegrationDay_Sat == 'true' ? true : false;
          checkboxIntegrationDay_Sun = timerData.timer_IntegrationDay_Sun == 'true' ? true : false;
          checkboxFertDay_Mon = timerData.timer_FertDay_Mon == 'true' ? true : false;
          checkboxFertDay_Tues = timerData.timer_FertDay_Tue == 'true' ? true : false;
          checkboxFertDay_Wed = timerData.timer_FertDay_Wed== 'true' ? true : false;
          checkboxFertDay_Thurs = timerData.timer_FertDay_Thurs == 'true' ? true : false;
          checkboxFertDay_Fri = timerData.timer_FertDay_Fri == 'true' ? true : false;
          checkboxFertDay_Sat = timerData.timer_FertDay_Sat == 'true' ? true : false;
          checkboxFertDay_Sun = timerData.timer_FertDay_Sun == 'true' ? true : false;
        });
      }
    });
  }

  Future<void> _saveTimerData() async {
    if (_oldTimerData == null) {
      TimerModel submitTimerData = new TimerModel(
        widget.controllerId,
        widget.timerIndex+1,
        _hrsController.text,
        _minController.text,
        checkboxIntegrationDay_Mon.toString(),
        checkboxIntegrationDay_Tues.toString(),
        checkboxIntegrationDay_Wed.toString(),
        checkboxIntegrationDay_Thurs.toString(),
        checkboxIntegrationDay_Friday.toString(),
        checkboxIntegrationDay_Sat.toString(),
        checkboxIntegrationDay_Sun.toString(),
        checkboxFertDay_Mon.toString(),
        checkboxFertDay_Tues.toString(),
        checkboxFertDay_Wed.toString(),
        checkboxFertDay_Thurs.toString(),
        checkboxFertDay_Fri.toString(),
        checkboxFertDay_Sat.toString(),
        checkboxFertDay_Sun.toString(),
        dateFormatted(),
      );
      await db.saveTimerData(submitTimerData);
      await db.getTimerData(widget.controllerId, widget.timerIndex);
    } else {
      TimerModel updateTimerData = new TimerModel(
          widget.controllerId,
          widget.timerIndex+1,
          _hrsController.text,
          _minController.text,
          checkboxIntegrationDay_Mon.toString(),
          checkboxIntegrationDay_Tues.toString(),
          checkboxIntegrationDay_Wed.toString(),
          checkboxIntegrationDay_Thurs.toString(),
          checkboxIntegrationDay_Friday.toString(),
          checkboxIntegrationDay_Sat.toString(),
          checkboxIntegrationDay_Sun.toString(),
          checkboxFertDay_Mon.toString(),
          checkboxFertDay_Tues.toString(),
          checkboxFertDay_Wed.toString(),
          checkboxFertDay_Thurs.toString(),
          checkboxFertDay_Fri.toString(),
          checkboxFertDay_Sat.toString(),
          checkboxFertDay_Sun.toString(),
          dateFormatted(),
          _oldTimerData.timerId);
      await db.updateTimerData(updateTimerData);
      await db.getTimerData(widget.controllerId, widget.timerIndex);
    }
  }

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
                        child: Text(
                          "Program No: ${widget.timerIndex + 1}",
                          style: TextStyle(color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.bold),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                  "Start time.",
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
                      controller: _hrsController,
                      style: TextStyle(fontSize: 20.0, color: Colors.black),
                      decoration: InputDecoration(labelText: 'Hrs'),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(
                      ":",
                      style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    width: 50.0,
                    child: TextFormField(
                      controller: _minController,
                      style: TextStyle(fontSize: 20.0, color: Colors.black),
                      decoration: InputDecoration(labelText: 'Min'),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Integration Days",
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
                              value: checkboxIntegrationDay_Sun,
                              onChanged: (bool value) {
                                setState(() {
                                  checkboxIntegrationDay_Sun = value;
                                });
                              },
                            ),
                            Text("Sun")
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Checkbox(
                              value: checkboxIntegrationDay_Mon,
                              onChanged: (bool value) {
                                setState(() {
                                  checkboxIntegrationDay_Mon = value;
                                });
                              },
                            ),
                            Text("Mon")
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Checkbox(
                              value: checkboxIntegrationDay_Tues,
                              onChanged: (bool value) {
                                setState(() {
                                  checkboxIntegrationDay_Tues = value;
                                });
                              },
                            ),
                            Text("Tue")
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Checkbox(
                              value: checkboxIntegrationDay_Wed,
                              onChanged: (bool value) {
                                setState(() {
                                  checkboxIntegrationDay_Wed = value;
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
                            value: checkboxIntegrationDay_Thurs,
                            onChanged: (bool value) {
                              setState(() {
                                checkboxIntegrationDay_Thurs = value;
                              });
                            },
                          ),
                          Text("Thu")
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Checkbox(
                            value: checkboxIntegrationDay_Friday,
                            onChanged: (bool value) {
                              setState(() {
                                checkboxIntegrationDay_Friday = value;
                              });
                            },
                          ),
                          Text("Fri")
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Checkbox(
                            value: checkboxIntegrationDay_Sat,
                            onChanged: (bool value) {
                              setState(() {
                                checkboxIntegrationDay_Sat = value;
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
                  Text(
                    "Fert Days",
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
                                  checkboxFertDay_Sun = value;
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
                                checkboxFertDay_Thurs = value;
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
                                checkboxFertDay_Sat = value;
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
                    onPressed: () {
                      _saveTimerData();
                      int nextIndex = widget.timerIndex + 1;
                      if (nextIndex < widget.maxIndex) {
                        Navigator.of(context).pushReplacement(
                          _TimerOption.route(widget.controllerId, nextIndex, widget.maxIndex),
                        );
                      } else {
                        ControllerDetails.navigateToPage(context, ControllerDetailsPageId.TIMER.nextPageId);
                      }
                    },
                    fillColor: Colors.indigo,
                    splashColor: Colors.white,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15.0),
                      child: Text(
                        _oldTimerData != null? "Update & Next": "Save & Next",
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
