import 'package:autoaqua/Model/TimerModel.dart';
import 'package:autoaqua/UI/ControllerDetails/ControllerDetails.dart';
import 'package:autoaqua/UI/ControllerDetails/ProgramPage.dart';
import 'package:autoaqua/Utils/Database_Client.dart';
import 'package:autoaqua/Utils/CommonlyUserMethod.dart';
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
      child: _maxProgram == null || _maxProgram == 0
          ? Center(
          child: Text(
            "No program is added",
            style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
          ))
          : ListView.builder(
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

  bool checkboxFertDay_Mon = false;
  bool checkboxFertDay_Tues = false;
  bool checkboxFertDay_Wed = false;
  bool checkboxFertDay_Thurs = false;
  bool checkboxFertDay_Fri = false;
  bool checkboxFertDay_Sat = false;
  bool checkboxFertDay_Sun = false;

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
          checkboxFertDay_Wed = timerData.timer_FertDay_Wed == 'true' ? true : false;
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
        widget.timerIndex + 1,
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
          widget.timerIndex + 1,
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
                child: Center(
                  child: Container(
                    //color: Color.fromRGBO(0, 84, 179, 1.0),
                    decoration: ShapeDecoration(shape: StadiumBorder(), color: Color.fromRGBO(0, 84, 179, 1.0)),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 8.0),
                      child: Text(
                        "Program No: ${widget.timerIndex + 1}",
                        style: TextStyle(color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Center(
                child: Text(
                  "IRRIGATION START TIME",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
              ),
              Center(
                child: Text(
                  "[24 Hrs Format]",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 15.0,),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(40.0,10.0,40.0,0.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      flex: 5,
                      child: TextFormField(
                        maxLength: 2,
                        textAlign: TextAlign.center,
                        controller: _hrsController,
                        style: TextStyle(fontSize: 20.0, color: Colors.black),
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            suffixText: "Hrs",
                            counterText: ""),
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10.0,0.0,10.0,30.0),
                      child: Text(
                        ":",
                        style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Expanded(
                      flex: 5,
                      child: TextFormField(
                        maxLength: 2,
                        textAlign: TextAlign.center,
                        controller: _minController,
                        style: TextStyle(fontSize: 20.0, color: Colors.black),
                        decoration: InputDecoration(
                            suffixText: "Mins",
                            border: OutlineInputBorder(),
                            counterText: ""),
                        keyboardType: TextInputType.number,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Text(
                    "Irrigation \nSchedules",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "Fertlization \nSchedules",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: 100.0,
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
                            Text("Sun",style: TextStyle(
                              fontSize: 20.0,
                            ),)
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
                            Text("Mon",style: TextStyle(
                              fontSize: 20.0,
                            ),)
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
                            Text("Tue",style: TextStyle(
                              fontSize: 20.0,
                            ),)
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
                            Text("Wed",style: TextStyle(
                              fontSize: 20.0,
                            ),)
                          ],
                        ),
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
                            Text("Thu",style: TextStyle(
                              fontSize: 20.0,
                            ),)
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
                            Text("Fri",style: TextStyle(
                              fontSize: 20.0,
                            ),)
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
                            Text("Sat",style: TextStyle(
                              fontSize: 20.0,
                            ),)
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 70.0,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        width: 100.0,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Checkbox(
                                  value: checkboxIntegrationDay_Sun == false ?false:checkboxFertDay_Sun,
                                  onChanged: checkboxIntegrationDay_Sun == false ?null:(bool value) {
                                    setState(() {
                                      checkboxFertDay_Sun = value;
                                    });
                                  }
                                ),
                                Text("Sun",style: TextStyle(
                                  fontSize: 20.0,
                                ),)
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                Checkbox(
                                  value: checkboxIntegrationDay_Mon == false ?false:checkboxFertDay_Mon,
                                  onChanged: checkboxIntegrationDay_Mon == false ?null:(bool value) {
                                    setState(() {
                                      checkboxFertDay_Mon = value;
                                    });
                                  },
                                ),
                                Text("Mon",style: TextStyle(
                                  fontSize: 20.0,
                                ),)
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                Checkbox(
                                  value: checkboxIntegrationDay_Tues == false ?false:checkboxFertDay_Tues,
                                  onChanged: checkboxIntegrationDay_Tues == false ?null:(bool value) {
                                    setState(() {
                                      checkboxFertDay_Tues = value;
                                    });
                                  },
                                ),
                                Text("Tue",style: TextStyle(
                                  fontSize: 20.0,
                                ),)
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                Checkbox(
                                  value: checkboxIntegrationDay_Wed == false ?false:checkboxFertDay_Wed,
                                  onChanged: checkboxIntegrationDay_Wed == false ?null:(bool value) {
                                    setState(() {
                                      checkboxFertDay_Wed = value;
                                    });
                                  },
                                ),
                                Text("Wed",style: TextStyle(
                                  fontSize: 20.0,
                                ),)
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                Checkbox(
                                  value: checkboxIntegrationDay_Thurs == false ?false:checkboxFertDay_Thurs,
                                  onChanged: checkboxIntegrationDay_Thurs == false ?null:(bool value) {
                                    setState(() {
                                      checkboxFertDay_Thurs = value;
                                    });
                                  },
                                ),
                                Text("Thu",style: TextStyle(
                                  fontSize: 20.0,
                                ),)
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                Checkbox(
                                  value: checkboxIntegrationDay_Friday == false ?false:checkboxFertDay_Fri,
                                  onChanged: checkboxIntegrationDay_Friday == false ?null:(bool value) {
                                    setState(() {
                                      checkboxFertDay_Fri = value;
                                    });
                                  },
                                ),
                                Text("Fri",style: TextStyle(
                                  fontSize: 20.0,
                                ),)
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                Checkbox(
                                  value: checkboxIntegrationDay_Sat == false ?false:checkboxFertDay_Sat,
                                  onChanged: checkboxIntegrationDay_Sat == false ?null:(bool value) {
                                    setState(() {
                                      checkboxFertDay_Sat = value;
                                    });
                                  },
                                ),
                                Text("Sat",style: TextStyle(
                                  fontSize: 20.0,
                                ),)
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 20.0),

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
                    fillColor: Color.fromRGBO(0, 84, 179, 1.0),
                    splashColor: Colors.white,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15.0),
                      child: Text(
                        _oldTimerData != null ? "Update" : "Save",
                        style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold, fontSize: 20.0),
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
