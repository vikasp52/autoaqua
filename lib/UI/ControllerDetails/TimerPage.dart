import 'package:autoaqua/Model/TimerModel.dart';
import 'package:autoaqua/UI/ControllerDetails/ControllerDetails.dart';
import 'package:autoaqua/UI/ControllerDetails/ProgramPage.dart';
import 'package:autoaqua/Utils/APICallMethods.dart';
import 'package:autoaqua/Utils/Database_Client.dart';
import 'package:autoaqua/Utils/CommonlyUserMethod.dart';
import 'package:flutter/material.dart';

class TimerPage extends StatefulWidget {
  static Route<dynamic> route(int controllerId, String controllerName) {
    return ControllerDetailsPageRoute(
      pageId: ControllerDetailsPageId.TIMER,
      builder: (context) => TimerPage(controllerId: controllerId, controllerName: controllerName),
    );
  }

  const TimerPage({
    Key key,
    @required this.controllerId,
    @required this.controllerName,
  }) : super(key: key);

  final int controllerId;
  final String controllerName;

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
      child: Column(
        children: <Widget>[
          controllerName(widget.controllerName),
          Expanded(
            flex: 9,
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
                        title: CommonList(index),
                        onTap: () => Navigator.of(context).push(
                              _TimerOption.route(widget.controllerId, index, _maxProgram, widget.controllerName),
                            ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

class _TimerOption extends StatefulWidget {
  static Route<dynamic> route(int controllerId, int timerIndex, int maxIndex, String controllerName) {
    return MaterialPageRoute(
      builder: (context) => _TimerOption(
            controllerId: controllerId,
            timerIndex: timerIndex,
            maxIndex: maxIndex,
            controllerName: controllerName,
          ),
    );
  }

  const _TimerOption({
    Key key,
    @required this.controllerId,
    @required this.timerIndex,
    @required this.maxIndex,
    @required this.controllerName,
  }) : super(key: key);

  final int controllerId;
  final int timerIndex;
  final int maxIndex;
  final String controllerName;

  @override
  _TimerOptionState createState() => _TimerOptionState();
}

class _TimerOptionState extends State<_TimerOption> {
  final TextEditingController _hrsController = new TextEditingController();
  final TextEditingController _minController = new TextEditingController();

  static bool checkboxIntegrationDay_Mon = true;
  static bool checkboxIntegrationDay_Tues = true;
  static bool checkboxIntegrationDay_Wed = true;
  static bool checkboxIntegrationDay_Thurs = true;
  static bool checkboxIntegrationDay_Friday = true;
  static bool checkboxIntegrationDay_Sat = true;
  static bool checkboxIntegrationDay_Sun = true;

  static bool checkboxFertDay_Mon = false;
  static bool checkboxFertDay_Tues = false;
  static bool checkboxFertDay_Wed = false;
  static bool checkboxFertDay_Thurs = false;
  static bool checkboxFertDay_Fri = false;
  static bool checkboxFertDay_Sat = false;
  static bool checkboxFertDay_Sun = false;

  final scheduleForm = GlobalKey<FormState>();

  bool errorMsg = false;

  String iDay;
  String fday;
  String timerString;

  TimerModel _oldTimerData;
  DataBaseHelper db = new DataBaseHelper();
  Future loading;

  APIMethods apiMethods = new APIMethods();

  @override
  void initState() {
    super.initState();

    print("THis is database table for Configuration ${db.getProgramItems()}");

    loading = db.getTimerData(widget.controllerId, widget.timerIndex).then((timerData) {
      _oldTimerData = timerData;
      if (timerData != null) {
        setState(() {
          _hrsController.value = TextEditingValue(text: AppendZero(timerData.timer_StartTimer_Hrs));
          _minController.value = TextEditingValue(text: AppendZero(timerData.timer_StartTimer_Min));
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

  void _validate() {
    if (_hrsController.text.isNotEmpty
        ? int.parse(_hrsController.text) > 23
        : false || _minController.text.isNotEmpty ? int.parse(_minController.text) > 59 : false) {
      setState(() {
        errorMsg = true;
      });
    } else if ((_hrsController.text.isNotEmpty ? int.parse(_hrsController.text) == 00 : false) &&
        (_minController.text.isNotEmpty ? int.parse(_minController.text) == 00 : false)) {
      setState(() {
        errorMsg = true;
      });
    } else {
      setState(() {
        errorMsg = false;
      });
    }
  }

  //String Generation
  Future<void> _stringForSchedule() async {
    iDay =
        "${(checkboxIntegrationDay_Sun == true ? 64 : 0) + (checkboxIntegrationDay_Mon == true ? 1 : 0) + (checkboxIntegrationDay_Tues == true ? 2 : 0) + (checkboxIntegrationDay_Wed == true ? 4 : 0) + (checkboxIntegrationDay_Thurs == true ? 8 : 0) + (checkboxIntegrationDay_Friday == true ? 16 : 0) + (checkboxIntegrationDay_Sat == true ? 32 : 0)}";
    fday =
        "${(checkboxFertDay_Sun == true ? 64 : 0) + (checkboxFertDay_Mon == true ? 1 : 0) + (checkboxFertDay_Tues == true ? 2 : 0) + (checkboxFertDay_Wed == true ? 4 : 0) + (checkboxFertDay_Thurs == true ? 8 : 0) + (checkboxFertDay_Fri == true ? 16 : 0) + (checkboxFertDay_Sat == true ? 32 : 0)}";
    timerString =
        "QS${AppendZero(_hrsController.text)}${AppendZero(_minController.text)}${AppendThreeDigit(iDay)}${AppendThreeDigit(fday)}>";
    print("Time String: $timerString");
    print("Hrs: ${AppendZero(_hrsController.text)}");
    print("Hrs: ${AppendZero(_minController.text)}");
    print("IRRDAY: ${AppendThreeDigit(iDay)}");
    print("FERTDAY: ${AppendThreeDigit(fday)}");
  }

  Future<void> _saveTimerData() async {
    iDay =
        "${(checkboxIntegrationDay_Sun == true ? 64 : 0) + (checkboxIntegrationDay_Mon == true ? 1 : 0) + (checkboxIntegrationDay_Tues == true ? 2 : 0) + (checkboxIntegrationDay_Wed == true ? 4 : 0) + (checkboxIntegrationDay_Thurs == true ? 8 : 0) + (checkboxIntegrationDay_Friday == true ? 16 : 0) + (checkboxIntegrationDay_Sat == true ? 32 : 0)}";
    fday =
        "${(checkboxFertDay_Sun == true ? 64 : 0) + (checkboxFertDay_Mon == true ? 1 : 0) + (checkboxFertDay_Tues == true ? 2 : 0) + (checkboxFertDay_Wed == true ? 4 : 0) + (checkboxFertDay_Thurs == true ? 8 : 0) + (checkboxFertDay_Fri == true ? 16 : 0) + (checkboxFertDay_Sat == true ? 32 : 0)}";
    timerString =
        "QS${AppendZero(_hrsController.text)}${AppendZero(_minController.text)}${AppendThreeDigit(iDay)}${AppendThreeDigit(fday)}>";

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
        timerString,
        dateFormatted(),
      );
      await db.saveTimerData(submitTimerData);
      await db.getTimerData(widget.controllerId, widget.timerIndex);
      saveStringData(widget.controllerId, "SCHEDULE", '${widget.timerIndex}', '0', timerString);
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
          timerString,
          dateFormatted(),
          _oldTimerData.timerId);
      await db.updateTimerData(updateTimerData);
      await db.getTimerData(widget.controllerId, widget.timerIndex);
      updateStringData(widget.controllerId, "SCHEDULE", '${widget.timerIndex}', '0', timerString);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: scheduleForm,
      child: ControllerDetailsPageFrame(
        title: "Timer",
        child: ListView(
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      widget.controllerName.toUpperCase(),
                      style: TextStyle(fontSize: 30.0, color: Color.fromRGBO(0, 84, 179, 1.0), fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                commonDivider(),
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
                    style: TextStyle(
                      fontSize: 15.0,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(40.0, 10.0, 40.0, 0.0),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        flex: 5,
                        child: CommonTextField(
                          _hrsController,
                          (value) {
                            if (value.isEmpty) {
                              return ""; //showSnackBar(context, "Please enter the Max program");
                            } else if (int.parse(value) > 23) {
                              return "";
                            }
                          },
                          TextAlign.center,
                          "Hrs",
                        ),
                        /*TextFormField(
                          maxLength: 2,
                          textAlign: TextAlign.center,
                          controller: _hrsController,
                          validator: (values){
                            if(int.parse(values) > 23){
                              return"";
                            }
                          },
                          style: TextStyle(fontSize: 20.0, color: Colors.black),
                          decoration: InputDecoration(border: OutlineInputBorder(), suffixText: "Hrs", counterText: ""),
                          keyboardType: TextInputType.number,
                        ),*/
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 30.0),
                        child: Text(
                          ":",
                          style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Expanded(
                        flex: 5,
                        child: CommonTextField(
                          _minController,
                          (value) {
                            if (value.isEmpty) {
                              return ""; //showSnackBar(context, "Please enter the Max program");
                            } else if (int.parse(value) > 59) {
                              return "";
                            }
                          },
                          TextAlign.center,
                          "Mins",
                        ),

                        /*TextFormField(
                          maxLength: 2,
                          textAlign: TextAlign.center,
                          controller: _minController,
                          validator: (values){
                            if(int.parse(values) > 59){
                              return"";
                            }
                          },
                          style: TextStyle(fontSize: 20.0, color: Colors.black),
                          decoration: InputDecoration(suffixText: "Mins", border: OutlineInputBorder(), counterText: ""),
                          keyboardType: TextInputType.number,
                        ),*/
                      ),
                    ],
                  ),
                ),
                Center(
                    child: errorMsg == true
                        ? Text(
                            "Please check the hrs or mins.",
                            style: TextStyle(color: Colors.red),
                          )
                        : SizedBox(
                            height: 0.0,
                          )),
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
                                  if(checkboxIntegrationDay_Sun == false){
                                    setState(() {
                                      checkboxFertDay_Sun = false;
                                    });
                                  }
                                },
                              ),
                              Text(
                                "Sun",
                                style: TextStyle(
                                  fontSize: 20.0,
                                ),
                              )
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
                                  if(checkboxIntegrationDay_Mon == false){
                                    setState(() {
                                      checkboxFertDay_Mon = false;
                                    });
                                  }
                                },
                              ),
                              Text(
                                "Mon",
                                style: TextStyle(
                                  fontSize: 20.0,
                                ),
                              )
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
                                  if(checkboxIntegrationDay_Tues == false){
                                    setState(() {
                                      checkboxFertDay_Tues = false;
                                    });
                                  }
                                },
                              ),
                              Text(
                                "Tue",
                                style: TextStyle(
                                  fontSize: 20.0,
                                ),
                              )
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
                                  if(checkboxIntegrationDay_Wed == false){
                                    setState(() {
                                      checkboxFertDay_Wed = false;
                                    });
                                  }
                                },
                              ),
                              Text(
                                "Wed",
                                style: TextStyle(
                                  fontSize: 20.0,
                                ),
                              )
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
                                  if(checkboxIntegrationDay_Thurs == false){
                                    setState(() {
                                      checkboxFertDay_Thurs = false;
                                    });
                                  }
                                },
                              ),
                              Text(
                                "Thu",
                                style: TextStyle(
                                  fontSize: 20.0,
                                ),
                              )
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
                                  if(checkboxIntegrationDay_Friday == false){
                                    setState(() {
                                      checkboxFertDay_Fri = false;
                                    });
                                  }
                                },
                              ),
                              Text(
                                "Fri",
                                style: TextStyle(
                                  fontSize: 20.0,
                                ),
                              )
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
                                  if(checkboxIntegrationDay_Sat == false){
                                    setState(() {
                                      checkboxFertDay_Sat = false;
                                    });
                                  }
                                },
                              ),
                              Text(
                                "Sat",
                                style: TextStyle(
                                  fontSize: 20.0,
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 70.0,
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
                                      value: checkboxIntegrationDay_Sun == false ? false : checkboxFertDay_Sun,
                                      onChanged: checkboxIntegrationDay_Sun == false
                                          ? null
                                          : (bool value) {
                                              setState(() {
                                                checkboxFertDay_Sun = value;
                                              });
                                            }),
                                  Text(
                                    "Sun",
                                    style: TextStyle(
                                      fontSize: 20.0,
                                    ),
                                  )
                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  Checkbox(
                                    value: checkboxIntegrationDay_Mon == false ? false : checkboxFertDay_Mon,
                                    onChanged: checkboxIntegrationDay_Mon == false
                                        ? null
                                        : (bool value) {
                                      setState(() {
                                        checkboxFertDay_Mon = value;
                                      });
                                    },
                                  ),
                                  Text(
                                    "Mon",
                                    style: TextStyle(
                                      fontSize: 20.0,
                                    ),
                                  )
                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  Checkbox(
                                    value: checkboxIntegrationDay_Tues == false ? false : checkboxFertDay_Tues,
                                    onChanged: checkboxIntegrationDay_Tues == false
                                        ? null
                                        : (bool value) {
                                            setState(() {
                                              checkboxFertDay_Tues = value;
                                            });
                                          },
                                  ),
                                  Text(
                                    "Tue",
                                    style: TextStyle(
                                      fontSize: 20.0,
                                    ),
                                  )
                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  Checkbox(
                                    value: checkboxIntegrationDay_Wed == false ? false : checkboxFertDay_Wed,
                                    onChanged: checkboxIntegrationDay_Wed == false
                                        ? null
                                        : (bool value) {
                                            setState(() {
                                              checkboxFertDay_Wed = value;
                                            });
                                          },
                                  ),
                                  Text(
                                    "Wed",
                                    style: TextStyle(
                                      fontSize: 20.0,
                                    ),
                                  )
                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  Checkbox(
                                    value: checkboxIntegrationDay_Thurs == false ? false : checkboxFertDay_Thurs,
                                    onChanged: checkboxIntegrationDay_Thurs == false
                                        ? null
                                        : (bool value) {
                                            setState(() {
                                              checkboxFertDay_Thurs = value;
                                            });
                                          },
                                  ),
                                  Text(
                                    "Thu",
                                    style: TextStyle(
                                      fontSize: 20.0,
                                    ),
                                  )
                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  Checkbox(
                                    value: checkboxIntegrationDay_Friday == false ? false : checkboxFertDay_Fri,
                                    onChanged: checkboxIntegrationDay_Friday == false
                                        ? null
                                        : (bool value) {
                                            setState(() {
                                              checkboxFertDay_Fri = value;
                                            });
                                          },
                                  ),
                                  Text(
                                    "Fri",
                                    style: TextStyle(
                                      fontSize: 20.0,
                                    ),
                                  )
                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  Checkbox(
                                    value: checkboxIntegrationDay_Sat == false ? false : checkboxFertDay_Sat,
                                    onChanged: checkboxIntegrationDay_Sat == false
                                        ? null
                                        : (bool value) {
                                            setState(() {
                                              checkboxFertDay_Sat = value;
                                            });
                                          },
                                  ),
                                  Text(
                                    "Sat",
                                    style: TextStyle(
                                      fontSize: 20.0,
                                    ),
                                  )
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
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    commonButton((){
                      _validate();
                      if (scheduleForm.currentState.validate() && errorMsg == false) {
                        _stringForSchedule().then((_){
                          if(mounted){
                            _saveTimerData();
                            sendSmsForAndroid(timerString, widget.controllerId);
                            showPositiveToast("SMS Send Successfully");
                            Navigator.of(context).popUntil((route) => route is ControllerDetailsMainRoute);
                          }
                        });
                      } else {
                        showColoredToast("There is some problem");
                      }
                    }, "Send"),
                    commonButton(
                      () {
                        _validate();
                        if (scheduleForm.currentState.validate() && errorMsg == false) {
                          _saveTimerData();
                          /*apiMethods.saveAndUpdateTimerData(
                              "${widget.controllerId}",
                              "${widget.timerIndex + 1}",
                              _hrsController.text,
                              _minController.text,
                              checkboxIntegrationDay_Sun.toString(),
                              checkboxIntegrationDay_Mon.toString(),
                              checkboxIntegrationDay_Tues.toString(),
                              checkboxIntegrationDay_Wed.toString(),
                              checkboxIntegrationDay_Thurs.toString(),
                              checkboxIntegrationDay_Friday.toString(),
                              checkboxIntegrationDay_Sat.toString(),
                              checkboxFertDay_Sun.toString(),
                              checkboxFertDay_Mon.toString(),
                              checkboxFertDay_Tues.toString(),
                              checkboxFertDay_Wed.toString(),
                              checkboxFertDay_Thurs.toString(),
                              checkboxFertDay_Fri.toString(),
                              checkboxFertDay_Sat.toString()
                          );*/
                          //int nextIndex = widget.timerIndex + 1;
                          _oldTimerData != null
                              ? showPositiveToast("Data is updated successfully")
                              : showPositiveToast("Data is saved successfully");
                          Navigator.of(context).popUntil((route) => route is ControllerDetailsMainRoute);
                        } else {
                          showColoredToast("There is some problem");
                        }
                        /*if (nextIndex < widget.maxIndex) {
                          Navigator.of(context).pushReplacement(
                            _TimerOption.route(widget.controllerId, nextIndex, widget.maxIndex),
                          );
                        } else {
                          ControllerDetails.navigateToPage(context, ControllerDetailsPageId.TIMER.nextPageId);
                        }*/
                      },
                      _oldTimerData != null ? "Update" : "Save",
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
