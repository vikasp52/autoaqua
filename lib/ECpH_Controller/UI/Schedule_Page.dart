import 'package:autoaqua/ECpH_Controller/Model/ECpHScheduleModel.dart';
import 'package:autoaqua/ECpH_Controller/Utils/ECpHDatabaseHelper.dart';
import 'package:flutter/material.dart';
import 'package:autoaqua/Utils/CommonlyUserMethod.dart';

class Schedule_Page extends StatefulWidget {

  @override
  _Schedule_PageState createState() => _Schedule_PageState();
}

class _Schedule_PageState extends State<Schedule_Page> {
  final TextEditingController _hrsController = new TextEditingController();
  final TextEditingController _minController = new TextEditingController();
  final TextEditingController _hrsEndController = new TextEditingController();
  final TextEditingController _minEndController = new TextEditingController();

  static bool checkboxIntegrationDay_Mon = true;
  static bool checkboxIntegrationDay_Tues = true;
  static bool checkboxIntegrationDay_Wed = true;
  static bool checkboxIntegrationDay_Thurs = true;
  static bool checkboxIntegrationDay_Friday = true;
  static bool checkboxIntegrationDay_Sat = true;
  static bool checkboxIntegrationDay_Sun = true;

  static bool checkboxFertDay_Mon = true;
  static bool checkboxFertDay_Tues = true;
  static bool checkboxFertDay_Wed = true;
  static bool checkboxFertDay_Thurs = true;
  static bool checkboxFertDay_Fri = true;
  static bool checkboxFertDay_Sat = true;
  static bool checkboxFertDay_Sun = true;

  final scheduleForm = GlobalKey<FormState>();

  bool errorMsg = false;

  String iDay;
  String fday;
  String timerString;

  ECpHScheduleModel _oldECpHScheduleData;
  ECpHDataBaseHelper db = new ECpHDataBaseHelper();
  Future _loading;

  //APIMethods apiMethods = new APIMethods();

  Future<void> _getScheduleData()async{
    _loading = db.getECpHScheduleItems().then((scheduleData) {
      _oldECpHScheduleData = scheduleData;
      if (scheduleData != null) {
        setState(() {
          _hrsController.value = TextEditingValue(text: AppendZero(scheduleData.ECpHStartTimeHrs));
          _minController.value = TextEditingValue(text: AppendZero(scheduleData.ECpHStartTimeMin));
          _hrsEndController.value = TextEditingValue(text: AppendZero(scheduleData.ECpHEndTimeHrs));
          _minEndController.value = TextEditingValue(text: AppendZero(scheduleData.ECpHEndTimeMin));
          checkboxIntegrationDay_Mon = scheduleData.ECpHIntegrationDay_Mon == 'true' ? true : false;
          checkboxIntegrationDay_Tues = scheduleData.ECpHIntegrationDay_Tue == 'true' ? true : false;
          checkboxIntegrationDay_Wed = scheduleData.ECpHIntegrationDay_Wed == 'true' ? true : false;
          checkboxIntegrationDay_Thurs = scheduleData.ECpHIntegrationDay_Thur == 'true' ? true : false;
          checkboxIntegrationDay_Friday = scheduleData.ECpHIntegrationDay_Fri == 'true' ? true : false;
          checkboxIntegrationDay_Sat = scheduleData.ECpHIntegrationDay_Sat == 'true' ? true : false;
          checkboxIntegrationDay_Sun = scheduleData.ECpHIntegrationDay_Sun == 'true' ? true : false;
          checkboxFertDay_Mon = scheduleData.ECpHScheduleDay_Mon == 'true' ? true : false;
          checkboxFertDay_Tues = scheduleData.ECpHScheduleDay_Tue == 'true' ? true : false;
          checkboxFertDay_Wed = scheduleData.ECpHScheduleDay_Wed == 'true' ? true : false;
          checkboxFertDay_Thurs = scheduleData.ECpHScheduleDay_Thur == 'true' ? true : false;
          checkboxFertDay_Fri = scheduleData.ECpHScheduleDay_Fri == 'true' ? true : false;
          checkboxFertDay_Sat = scheduleData.ECpHScheduleDay_Sat == 'true' ? true : false;
          checkboxFertDay_Sun = scheduleData.ECpHScheduleDay_Sun == 'true' ? true : false;
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

  Future<void> _saveECphScheduleData() async {
    iDay =
    "${(checkboxIntegrationDay_Sun == true ? 64 : 0) + (checkboxIntegrationDay_Mon == true ? 1 : 0) + (checkboxIntegrationDay_Tues == true ? 2 : 0) + (checkboxIntegrationDay_Wed == true ? 4 : 0) + (checkboxIntegrationDay_Thurs == true ? 8 : 0) + (checkboxIntegrationDay_Friday == true ? 16 : 0) + (checkboxIntegrationDay_Sat == true ? 32 : 0)}";
    fday =
    "${(checkboxFertDay_Sun == true ? 64 : 0) + (checkboxFertDay_Mon == true ? 1 : 0) + (checkboxFertDay_Tues == true ? 2 : 0) + (checkboxFertDay_Wed == true ? 4 : 0) + (checkboxFertDay_Thurs == true ? 8 : 0) + (checkboxFertDay_Fri == true ? 16 : 0) + (checkboxFertDay_Sat == true ? 32 : 0)}";
    timerString =
    "QS${AppendZero(_hrsController.text)}${AppendZero(_minController.text)}${AppendThreeDigit(iDay)}${AppendThreeDigit(fday)}>";

    if (_oldECpHScheduleData == null) {
      ECpHScheduleModel submitTimerData = new ECpHScheduleModel(
        _hrsController.text,
        _minController.text,
        _hrsEndController.text,
        _minEndController.text,
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
      await db.saveECpHScheduleItem(submitTimerData);
      await db.getECpHScheduleItems();
      //saveStringData(widget.controllerId, "SCHEDULE", '${widget.timerIndex}', '0', timerString);
    } else {
      ECpHScheduleModel updateTimerData = new ECpHScheduleModel(
          _hrsController.text,
          _minController.text,
          _hrsEndController.text,
          _minEndController.text,
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
          _oldECpHScheduleData.ECpHScheduleId);
      print("Updated Schedule data is $updateTimerData");
      await db.updateECpHScheduleData(updateTimerData);
      await db.getECpHScheduleItems();
      //updateStringData(widget.controllerId, "SCHEDULE", '${widget.timerIndex}', '0', timerString);
    }
  }

  @override
  void initState() {
    super.initState();
    _loading = _getScheduleData();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _loading,
        builder: (context, snapshot){
        if(snapshot.connectionState == ConnectionState.done){
          return BuildScheduleContent();
        }else{
          return Center(child: CircularProgressIndicator(),);
        }
        });
  }


  Widget BuildScheduleContent(){
    return CommonBodyStrecture(
      text: "ECpH SCHEDULE",
      child: Form(
        key: scheduleForm,
        child: SingleChildScrollView(
          child: Column(
            //crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 10.0,),
              Center(
                child: Text(
                  "MOTOR START TIME",
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
              Center(
                child: Text(
                  "MOTOR RUNNING TIME",
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
                        _hrsEndController,
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
                        _minEndController,
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
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text(
                    "Irrigation \nSchedules",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "pH \nSchedules",
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
                  commonButton(
                          () {
                        _validate();
                        if (scheduleForm.currentState.validate() && errorMsg == false) {
                          _saveECphScheduleData();

                          _oldECpHScheduleData != null
                            ? showPositiveToast("Data is updated successfully")
                            : showPositiveToast("Data is saved successfully");
                          Navigator.of(context).pop();
                        } else {
                          showColoredToast("There is some problem");
                        }
                      },
                      _oldECpHScheduleData != null ? "Update" : "Save",
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

}