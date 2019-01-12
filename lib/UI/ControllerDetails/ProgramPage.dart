import 'dart:convert';

import 'package:autoaqua/Model/ProgramModel.dart';
import 'package:autoaqua/Model/StringModel.dart';
import 'package:autoaqua/UI/ControllerDetails/ControllerDetails.dart';
import 'package:autoaqua/Utils/APICallMethods.dart';
import 'package:autoaqua/Utils/Database_Client.dart';
import 'package:autoaqua/Utils/CommonlyUserMethod.dart';
import 'package:flutter/material.dart';

class ProgramPage extends StatefulWidget {
  static Route<dynamic> route(int controllerId, String controllerName) {
    return ControllerDetailsPageRoute(
      pageId: ControllerDetailsPageId.PROGRAM,
      builder: (context) => ProgramPage(
            controllerId: controllerId,
            controllerName: controllerName,
          ),
    );
  }

  const ProgramPage({
    Key key,
    @required this.controllerId,
    @required this.controllerName,
  }) : super(key: key);

  final int controllerId;
  final String controllerName;

  @override
  _ProgramPageState createState() => _ProgramPageState();
}

class _ProgramPageState extends State<ProgramPage> {
  DataBaseHelper dbh = DataBaseHelper();
  var maxnumber;
  Future _loading;
  //ConfigurationModel _oldConfig;

  @override
  void initState() {
    super.initState();
    print("Controller Id is ${widget.controllerId}");
    _loading = dbh.getConfigDataForController(widget.controllerId).then((config) {
      //_oldConfig = config;
      if (config != null) {
        setState(() {
          maxnumber = int.parse(config.configMaxProg); //TextEditingValue(text: config.configMaxProg);
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
              flex: 8,
              child: maxnumber == null || maxnumber == 0
                  ? Center(
                child: Text(
                  "No program is added",
                  style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
                ),
              )
                  : ListView.builder(
                itemCount: maxnumber,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    contentPadding: EdgeInsets.fromLTRB(20.0,0.0,20.0,0.0),
                    title:CommonList(index),
                    onTap: () => Navigator.of(context).push(
                      _ProgramOption.route(index, maxnumber, widget.controllerId, widget.controllerName),
                    ),
                  );
                },
              ),
            )
          ],
        ));
  }
}

class _ProgramOption extends StatefulWidget {
  static Route<dynamic> route(int programIndex, int maxIndex, int controllerId, String controllerName) {
    return MaterialPageRoute(
      builder: (context) => _ProgramOption(
            programIndex: programIndex,
            maxIndex: maxIndex,
            controllerId: controllerId,
            controllerName: controllerName,
          ),
    );
  }

  const _ProgramOption({
    Key key,
    @required this.programIndex,
    @required this.maxIndex,
    @required this.controllerId,
    @required this.controllerName,
  }) : super(key: key);

  final int programIndex;
  final int maxIndex;
  final int controllerId;
  final String controllerName;

  @override
  _ProgramOptionState createState() => _ProgramOptionState();
}

class _ProgramOptionState extends State<_ProgramOption> {
  // state variable
  int _radioValueFlushType;
  int _radioValueIrrigation;
  int _radioValueFertilization;
  int _radioValueSensor;
  bool _valFlushMode = false;
  final _programKey = GlobalKey<FormState>();

  //bool value for Error Message
  bool irrError = false;
  bool fertError = false;
  bool senserError = false;
  bool backflushError = false;

  APIMethods apiMethods = new APIMethods();
  String programString;

  final TextEditingController _intervalController = new TextEditingController();
  final TextEditingController _timeForControler = new TextEditingController();
  final TextEditingController _NoOfValves = new TextEditingController();

  ProgramModel _oldProgram;
  StringModel _oldString;
  Future _loading;
  var db = new DataBaseHelper();

  void _handleFilterFlushModeChange(bool e) {
    setState(() {
      if (e) {
        _valFlushMode = true;
      } else {
        _valFlushMode = false;
      }
    });
  }

  //Retun Program No for String.
  int programNo() {
    return widget.programIndex + 1;
  }

  @override
  void initState() {
    super.initState();
    print("THis is database table for program ${db.getProgramItems()}");
    print('This is controller id ${widget.controllerId}');
    print('This is list index ${widget.programIndex + 1}');

    _loading = db.getStrings(widget.controllerId).then((sData){
      _oldString = sData;
    });

    _loading = db.getProgramData(widget.controllerId, widget.programIndex).then((config) {
      _oldProgram = config;
      print(config);
      if (config != null) {
        setState(() {
          //_radioValueforMode = config.program_mode != "null"?int.parse(config.program_mode):null;
          _NoOfValves.value = TextEditingValue(text: config.program_mode);
          _valFlushMode = config.program_flushMode == "true" ? true : false;
          _radioValueFlushType = config.program_flushtype != "null" ? int.parse(config.program_flushtype) : null;
          _intervalController.value = TextEditingValue(text: config.program_interval);
          _timeForControler.value = TextEditingValue(text: config.program_flushon);
          _radioValueIrrigation =
              config.program_irrigationtype != "null" ? int.parse(config.program_irrigationtype) : null;
          _radioValueFertilization =
              config.program_fertilizationtype != "null" ? int.parse(config.program_fertilizationtype) : null;
          _radioValueSensor = config.program_sensorOverride != "null" ? int.parse(config.program_sensorOverride) : null;
        });
      }
    });
  }

  Future<void> stringForProgram() async {
    programString =
        "QP${AppendZero(programNo().toString())}${int.parse(_radioValueFlushType != null ? _radioValueFlushType.toString() : "0") + _radioValueIrrigation}${_NoOfValves.text == "1" ? 0 : _NoOfValves.text == "2" ? 1 : _NoOfValves.text == "3" ? 2 : _NoOfValves.text == "4" ? 2 : null}${AppendZero(_intervalController.text)}${AppendZero(_timeForControler.text)}>";
    print("programString is : $programString");
    print("Program No ${AppendZero(programNo().toString())}");
    print("FlushType: ${_radioValueFlushType != null ? _radioValueFlushType : "0"}");
    print("Irrigation type: ${_radioValueIrrigation}");
    print(
        "1st Char ${int.parse(_radioValueFlushType != null ? _radioValueFlushType.toString() : "0") + _radioValueIrrigation}");
    print(
        "2nd Char ${_NoOfValves.text == "1" ? 0 : _NoOfValves.text == "2" ? 1 : _NoOfValves.text == "3" ? 2 : _NoOfValves.text == "4" ? 2 : null}");
    print("Interval ${AppendZero(_intervalController.text)}");
    print("Time ${AppendZero(_timeForControler.text)}");
  }

  Future<void> _handelProgramDataSubmit() async {
    String programString =
        "QP${AppendZero(programNo().toString())}${int.parse(_radioValueFlushType != null ? _radioValueFlushType.toString() : "0") + _radioValueIrrigation}${_NoOfValves.text == "1" ? 0 : _NoOfValves.text == "2" ? 1 : _NoOfValves.text == "3" ? 2 : _NoOfValves.text == "4" ? 2 : null}${AppendZero(_intervalController.text)}${AppendZero(_timeForControler.text)}>";

    if (_oldProgram == null) {
      ProgramModel submitProgramData = new ProgramModel(
        widget.controllerId,
        _NoOfValves.text,
        _valFlushMode.toString(),
        _radioValueFlushType.toString(),
        _intervalController.text,
        _timeForControler.text,
        _radioValueIrrigation.toString(),
        _radioValueFertilization.toString(),
        _radioValueSensor.toString(),
        dateFormatted(),
        programString,
      );
      print("saved");
      await db.saveProgramData(submitProgramData);
      await db.getProgramData(widget.controllerId, widget.programIndex);
      await db.getProgramString(widget.controllerId);

      saveStringData(widget.controllerId, "PROG", '${widget.programIndex}', '0', programString);

    } else {
      ProgramModel submitProgramData = new ProgramModel(
        widget.controllerId,
        _NoOfValves.text,
        _valFlushMode.toString(),
        _radioValueFlushType.toString(),
        _intervalController.text,
        _timeForControler.text,
        _radioValueIrrigation.toString(),
        _radioValueFertilization.toString(),
        _radioValueSensor.toString(),
        dateFormatted(),
        programString,
        _oldProgram.programID,
      );
      await db.updateProgramData(submitProgramData);
      await db.getProgramData(widget.controllerId, widget.programIndex);

      updateStringData(widget.controllerId, "PROG", '${widget.programIndex}', '0', programString);
      //print('Updated String Item: $savedString');

      List pS = await db.getProgramString(widget.controllerId);
      List pS2 = await db.getProgramString(widget.controllerId);
      print("ps: ${pS.length}");
      print("ps: $pS2");
      String retVL = getStringFromList(pS);
      String retVL2 = getStringFromList(pS2);
      print("All List: $retVL");
      print("All List: $retVL2");
    }
  }

  void valdateRadio(){
    if (_radioValueIrrigation == null) {
      setState(() {
        irrError = true;
      });
    } else {
      setState(() {
        irrError = false;
      });
    }

    if (_radioValueFertilization == null) {
      setState(() {
        fertError = true;
      });
    } else {
      setState(() {
        fertError = false;
      });
    }

    if (_radioValueSensor == null) {
      setState(() {
        senserError = true;
      });
    } else {
      setState(() {
        senserError = false;
      });
    }

    if (_radioValueFlushType == null && _valFlushMode == true) {
      setState(() {
        backflushError = true;
      });
    } else {
      setState(() {
        backflushError = false;
      });
    }
  }

  void _handleFlushRadioValueChange(int value) {
    setState(() {
      _radioValueFlushType = value;

      /*switch (_radioValueFlushType) {
        case 0:

          break;
        case 1:
        //_result = ...
          break;
      }*/
    });
  }

  void _handleIrrigationValueChange(int value) {
    setState(() {
      _radioValueIrrigation = value;

      switch (_radioValueIrrigation) {
        case 0:
          break;
        case 2:
          //_result = ...
          break;
      }
    });
  }

  void _handleFertilizationValueChange(int value) {
    setState(() {
      _radioValueFertilization = value;

      switch (_radioValueFertilization) {
        case 0:
          break;
        case 1:
          //_result = ...
          break;
      }
    });
  }

  void _handleSensorValueChange(int value) {
    setState(() {
      _radioValueSensor = value;

      switch (_radioValueSensor) {
        case 0:
          break;
        case 1:
          //_result = ...
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ControllerDetailsPageFrame(
        title: "Program No: ${widget.programIndex + 1}",
        child: FutureBuilder(
            future: _loading,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return buildProgramContent(context);
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            }));
  }

  Widget buildProgramContent(BuildContext context) {
    return Form(
      key: _programKey,
      child: ListView(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Center(
                  child: Text(
                    widget.controllerName,
                    style: TextStyle(fontSize: 30.0, color: Color.fromRGBO(0, 84, 179, 1.0), fontWeight: FontWeight.bold),
                  ),
                ),
                commonDivider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            //color: Color.fromRGBO(0, 84, 179, 1.0),
                            decoration: ShapeDecoration(shape: StadiumBorder(), color: Color.fromRGBO(0, 84, 179, 1.0)),
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 8.0),
                              child: Text(
                                "Program No: ${widget.programIndex + 1}",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20.0,
                                  //fontWeight: FontWeight.bold
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Divider(
                    height: 2.0,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text(
                    "No. of Valves to be operated together:",
                    style: TextStyle(
                      fontSize: 20.0,
                    ),
                  ),
                ),
                CommonTextField(_NoOfValves, (value) {
                  if (validateEmpty(value)) {
                    return "Please enter the Max output"; //showSnackBar(context, "Please enter the Max program");
                  } else if (int.parse(value) > 4) {
                    return "You cannot enter more then 4";
                  }
                }, TextAlign.start, "(Max 4)"),
                /*TextFormField(
                  keyboardType: TextInputType.number,
                  controller: _NoOfValves,
                  style: TextStyle(fontSize: 20.0, color: Colors.black),
                  maxLength: 1,
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Please enter the Max output";
                    } else if (int.parse(value) > 4) {
                      return "You cannot enter more then 4";
                    }
                  },
                  decoration: new InputDecoration(
                      fillColor: Colors.black, counterText: "", border: OutlineInputBorder(), suffixText: "(Max 4)"),
                ),*/
                commonDivider(),
                Center(
                  child: Text(
                    "IRRIGATION BY",
                    style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                  ),
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      flex: 5,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Text(
                            "Time",
                            style: TextStyle(fontSize: 20.0),
                          ),
                          Radio(
                            value: 0,
                            groupValue: _radioValueIrrigation,
                            onChanged: _handleIrrigationValueChange,
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 5,
                      child: Row(
                        children: <Widget>[
                          Radio(
                            value: 2,
                            groupValue: _radioValueIrrigation,
                            onChanged: _handleIrrigationValueChange,
                          ),
                          Text(
                            "Volume",
                            style: TextStyle(
                              fontSize: 20.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                irrError == true
                    ? Center(
                        child: Text(
                          "Please select the Irrigation type",
                          style: TextStyle(color: Colors.red),
                        ),
                      )
                    : SizedBox(
                        height: 0.0,
                      ),
                commonDivider(),
                Center(
                  child: Text(
                    "FERTIGATION BY",
                    style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                  ),
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      flex: 5,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Text(
                            "Time",
                            style: TextStyle(fontSize: 20.0),
                          ),
                          Radio(
                            value: 1,
                            groupValue: _radioValueFertilization,
                            onChanged: _handleFertilizationValueChange,
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 5,
                      child: Row(
                        children: <Widget>[
                          Radio(
                            value: 0,
                            groupValue: _radioValueFertilization,
                            onChanged: _handleFertilizationValueChange,
                          ),
                          Text(
                            "Volume",
                            style: TextStyle(
                              fontSize: 20.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                fertError == true
                    ? Center(
                        child: Text(
                          "Please select the Fertigation type",
                          style: TextStyle(color: Colors.red),
                        ),
                      )
                    : SizedBox(
                        height: 0.0,
                      ),
                commonDivider(),
                Center(
                  child: Text(
                    "SENSOR OVERRIDE",
                    style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                  ),
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      flex: 5,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Text(
                            "Manual",
                            style: TextStyle(fontSize: 20.0),
                          ),
                          Radio(
                            value: 1,
                            groupValue: _radioValueSensor,
                            onChanged: _handleSensorValueChange,
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 5,
                      child: Row(
                        children: <Widget>[
                          Radio(
                            value: 0,
                            groupValue: _radioValueSensor,
                            onChanged: _handleSensorValueChange,
                          ),
                          Text(
                            "Auto",
                            style: TextStyle(
                              fontSize: 20.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                senserError == true
                    ? Center(
                        child: Text(
                          "Please select the Fertigation type",
                          style: TextStyle(color: Colors.red),
                        ),
                      )
                    : SizedBox(
                        height: 0.0,
                      ),
                commonDivider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "FILTER BACKFLUSH:",
                      style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                    ),
                    Switch(value: _valFlushMode, onChanged: (bool e) => _handleFilterFlushModeChange(e)),
                  ],
                ),
                _valFlushMode == true
                    ? Column(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              new Radio(
                                value: 0,
                                groupValue: _radioValueFlushType,
                                onChanged: _handleFlushRadioValueChange,
                              ),
                              Expanded(
                                  child: Text(
                                "Once Before every Irrigation Program",
                                style: TextStyle(fontSize: 20.0),
                              )),
                              SizedBox.fromSize(
                                size: Size(10.0, 0.0),
                              ),
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              new Radio(
                                value: 1,
                                groupValue: _radioValueFlushType,
                                onChanged: _handleFlushRadioValueChange,
                              ),
                              Text(
                                "Before Starting of Next Valve",
                                style: TextStyle(fontSize: 20.0),
                              ),
                            ],
                          ),
                          backflushError == true
                              ? Center(
                                  child: Text(
                                    "Please select the Filter Backflush type",
                                    style: TextStyle(color: Colors.red),
                                  ),
                                )
                              : SizedBox(
                                  height: 0.0,
                                ),
                          commonDivider(),
                          Row(
                            children: <Widget>[
                              Expanded(
                                flex: 5,
                                child: Padding(
                                  padding: const EdgeInsets.only(bottom: 10.0),
                                  child: Text(
                                    "Interval After ",
                                    style: TextStyle(
                                      fontSize: 20.0,
                                    ),
                                  ),
                                ),
                              ),
                              Flexible(
                                flex: 5,
                                child: CommonTextField(
                                  _intervalController,
                                  (value) {
                                    if (validateEmpty(value)) {
                                      return "Please enter Interval";
                                    }
                                  },
                                  TextAlign.center,
                                ),

                                /*TextFormField(
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 20.0, color: Colors.black),
                                  maxLength: 2,
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return "Please enter the Interval time";
                                    }
                                  },
                                  decoration: InputDecoration(
                                    counterText: "",
                                    //prefixText: "After",
                                    border: OutlineInputBorder(),
                                    //suffixText: "Days"
                                  ),
                                  keyboardType: TextInputType.number,
                                  controller: _intervalController,
                                ),*/
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 10.0),
                                child: Text(
                                  " Days",
                                  style: TextStyle(
                                    fontSize: 20.0,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Expanded(
                                flex: 5,
                                child: Padding(
                                  padding: const EdgeInsets.only(bottom: 10.0),
                                  child: Text(
                                    "Time For ",
                                    style: TextStyle(
                                      fontSize: 20.0,
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 5,
                                child: CommonTextField(
                                  _timeForControler,
                                  (value) {
                                    if (validateEmpty(value)) {
                                      return "Please enter the mins";
                                    }
                                  },
                                  TextAlign.center,
                                ),

                                /*TextFormField(
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 20.0, color: Colors.black),
                                  maxLength: 2,
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return "Please enter the mins";
                                    }
                                  },
                                  decoration: InputDecoration(
                                    counterText: "",
                                    //prefixText: "For",
                                    border: OutlineInputBorder(),
                                    //suffixText: "Mins"
                                  ),
                                  keyboardType: TextInputType.number,
                                  controller: _timeForControler,
                                ),*/
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 10.0),
                                child: Text(
                                  " Mins",
                                  style: TextStyle(
                                    fontSize: 20.0,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      )
                    : SizedBox(
                        height: 0.0,
                      ),
                commonDivider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    commonButton(
                            () {
                              valdateRadio();
                          setState(() {
                            if (_programKey.currentState.validate() &&
                                _radioValueIrrigation != null &&
                                _radioValueFertilization != null &&
                                _radioValueSensor != null &&
                                backflushError == false
                            ) {
                              _loading = stringForProgram().then((_) {
                                if (mounted) {
                                  _handelProgramDataSubmit();
                                  sendSmsForAndroid(programString, widget.controllerId);
                                  Navigator.of(context).popUntil((route) => route is ControllerDetailsMainRoute);
                                  showPositiveToast("sms sent successfully");
                                }
                              });
                            } else {
                              showColoredToast("Please enter the valid value");
                            }
                          });
                        },
                    "Send"),
                    commonButton(() {
                      valdateRadio();
                      setState(() {
                        if (_programKey.currentState.validate() &&
                                _radioValueIrrigation != null &&
                                _radioValueFertilization != null &&
                                _radioValueSensor != null &&
                                backflushError == false
                            // (_radioValueFlushType == null && _valFlushMode == false)
                            ) {
                          //irrError = false;

                          /*ProgramModel submitProgramData = new ProgramModel(
        widget.controllerId,
        _NoOfValves.text,
        _valFlushMode.toString(),
        _radioValueFlushType.toString(),
        _intervalController.text,
        _flushOnControler.text,
        _radioValueIrrigation.toString(),
        _radioValueFertilization.toString(),
        _radioValueSensor.toString(),
        dateFormatted(),
        _oldProgram.programID,
      );*/
                          print("Flush on Value $_valFlushMode,");
                          /* apiMethods.saveAndUpdateProgramDataOnServer(
                                  "${widget.programIndex + 1}",
                                  _NoOfValves.text,
                                  _radioValueIrrigation.toString(),
                                  _radioValueFertilization.toString(),
                                  _radioValueSensor.toString(),
                                  _valFlushMode == true ? "1" : "0",
                                  _radioValueFlushType.toString(),
                                _intervalController.text,
                                _timeForControler.text,
                                "${widget.controllerId}"
                              );*/
                          _handelProgramDataSubmit();
                          final int nextIndex = widget.programIndex + 1;
                          if (nextIndex < widget.maxIndex) {
                            /*Navigator.of(context).pushReplacement(
                              _ProgramOption.route(nextIndex, widget.maxIndex, widget.controllerId),
                            );*/
                            //Navigator.of(context).pop();
                            Navigator.of(context).popUntil((route) => route is ControllerDetailsMainRoute);
                            _oldProgram != null
                                ? showPositiveToast("Data is updated successfully")
                                : showPositiveToast("Data is saved successfully");
                          } else {
                            //ControllerDetails.navigateToPage(context, ControllerDetailsPageId.PROGRAM.nextPageId);
                            Navigator.of(context).popUntil((route) => route is ControllerDetailsMainRoute);
                          }
                        } else {
                          showColoredToast("Please enter the valid value");
                        }
                      });
                    }, _oldProgram != null ? "Update" : "Save"),
                  ],
                ),
                SizedBox.fromSize(
                  size: Size(10.0, 10.0),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String getStringFromList(List pS) {
    return pS.join(', ').substring(8, pS.join(',').length - 1);
  }
}
