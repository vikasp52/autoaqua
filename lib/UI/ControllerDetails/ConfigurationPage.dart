import 'dart:async';

import 'package:autoaqua/UI/ControllerDetails/ControllerDetails.dart';
import 'package:autoaqua/Model/ConfigurationModel.dart';
import 'package:autoaqua/UI/ControllerDetails/ProgramPage.dart';
import 'package:autoaqua/Utils/Database_Client.dart';
import 'package:autoaqua/Utils/CommonlyUserMethod.dart';
import 'package:flutter/material.dart';

//var etMaxProgram = TextEditingController();
class ConfigurationPage extends StatefulWidget {
  static Route<dynamic> route(int controllerId) {
    return ControllerDetailsPageRoute(
      pageId: ControllerDetailsPageId.CONFIGURATION,
      builder: (context) => ConfigurationPage(
            controllerId: controllerId,
          ),
    );
  }

  const ConfigurationPage({
    Key key,
    @required this.controllerId,
  }) : super(key: key);

  final int controllerId;

  @override
  _ConfigurationPageState createState() => _ConfigurationPageState();
}

class _ConfigurationPageState extends State<ConfigurationPage> {
  final _configurationformkey = GlobalKey<FormState>();
  final db = new DataBaseHelper();
  final _MaxProgController = TextEditingController();
  final _MaxOutputController = TextEditingController();
  final _phDelayController = TextEditingController();
  final _MaxInjectorController = TextEditingController();
  final _MaxRTUController = TextEditingController();
  final _TotalIrrigationController = TextEditingController();
  final _TotalFoggerController = TextEditingController();
  final _slaveTextControllers = <TextEditingController>[];
  bool _valECpHType = false;
  bool _valRTU = false;
  bool _errorMsg = false;
  int _irrigationValves = 0;
  int _totalControllerOutput = 0;
  int _foggerValves = 0;
  int _totalValves = 0;
  int _remaningValves = 0;

  Future _loading;
  ConfigurationModel _oldConfig;

  //Bool Value for error message
  bool errorMsgRTU = false;

  void _handleECpHValueChange(bool e) {
    setState(() {
      if (e) {
        _valECpHType = true;
      } else {
        _valECpHType = false;
      }
    });
  }

  void _handleRTUValueChange(bool RTUStatus) {
    setState(() {
      if (RTUStatus) {
        _valRTU = RTUStatus;
      } else {
        _valRTU = RTUStatus;
      }
    });
  }

  @override
  void initState() {
    super.initState();
    print("THis is database table for Configuration ${db.getConfigItems()}");
    _errorMsg = false;

    _loading = db.getConfigDataForController(widget.controllerId).then((config) {
      _oldConfig = config;
      if (config != null) {
        _MaxProgController.value = TextEditingValue(text: config.configMaxProg);
        _MaxOutputController.value = TextEditingValue(text: config.configMaxOutput);
        _MaxInjectorController.value = TextEditingValue(text: config.configMaxInjector);
        _TotalIrrigationController.value = TextEditingValue(text: config.ConfigTotalIrrigationValves);
        _TotalFoggerController.value = TextEditingValue(text: config.ConfigmaxFogger);
        _totalValves = int.parse(config.configTotalValves);
        _remaningValves = int.parse(config.configRemaningValves);
        _valECpHType = config.configEcpHStatus == "true" ? true : false;
        _valRTU = config.configMaxRTUOnOff == "true" ? true : false;
        _phDelayController.value = TextEditingValue(text: config.configMaxRTU);
        _slaveTextControllers.length = config.slaveMobNos.length;
        _MaxRTUController.value = TextEditingValue(text: config.configNoOfSlaves);
        for (int i = 0; i < _slaveTextControllers.length; i++) {
          _slaveTextControllers[i] = TextEditingController(
            text: config.slaveMobNos[i],
          );
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ControllerDetailsPageFrame(
      child: FutureBuilder(
        future: _loading,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return buildContent(context);
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  Future<void> _handleSave() async {
    print("id here: ${widget.controllerId}");

    if (_oldConfig == null) {
      ConfigurationModel newConfig = new ConfigurationModel(
          widget.controllerId,
          AppendZero(_MaxProgController.text),
          AppendZero(_MaxOutputController.text),
          _MaxInjectorController.text,
          _TotalFoggerController.text,
          _TotalIrrigationController.text,
          _totalValves.toString(),
          _remaningValves.toString(),
          _valECpHType.toString(),
          _valRTU.toString(),
          AppendZero(_phDelayController.text),
          _MaxRTUController.text,
          _slaveTextControllers.map((controller) => controller.value.text).toList(growable: false),
          dateFormatted(),
          "QD${AppendZero(_MaxProgController.text) + AppendZero(_MaxProgController.text) + AppendZero(_MaxRTUController.text) + AppendZero(_phDelayController.text)}>"
          //_oldConfig.configid
          );

      int saveItemId = await db.saveConfigurationItem(newConfig);
      var addedItem = await db.getConfigDataForController(widget.controllerId);
      print('Added Item: $saveItemId: $addedItem');

      Navigator.of(context).pushReplacement(ProgramPage.route(widget.controllerId));
    } else {
      ConfigurationModel newConfig = new ConfigurationModel(
          widget.controllerId,
          AppendZero(_MaxProgController.text),
          AppendZero(_MaxOutputController.text),
          _MaxInjectorController.text,
          _TotalFoggerController.text,
          _TotalIrrigationController.text,
          _totalValves.toString(),
          _remaningValves.toString(),
          _valECpHType.toString(),
          _valRTU.toString(),
          AppendZero(_phDelayController.text),
          _MaxRTUController.text,
          _slaveTextControllers.map((controller) => controller.value.text).toList(growable: false),
          dateFormatted(),
          "QD${AppendZero(_MaxProgController.text) + AppendZero(_MaxProgController.text) + AppendZero(_MaxRTUController.text) + AppendZero(_phDelayController.text)}>",
          _oldConfig.configid);

      int saveItemId = await db.updateConfigurationItems(newConfig);
      var addedItem = await db.getConfigDataForController(widget.controllerId);
      print('Added Item: $saveItemId: $addedItem');

      Navigator.of(context).pushReplacement(ProgramPage.route(widget.controllerId));
    }
  }

  void CalculateTotalandremaningValves() async {
    await setState(() {
      _totalControllerOutput = int.parse(_MaxOutputController.text);
      _irrigationValves = int.parse(_TotalIrrigationController.text);
      _foggerValves = int.parse(_TotalFoggerController.text);
      _totalValves = _irrigationValves + _foggerValves;
      _remaningValves = int.parse(_MaxOutputController.text) - _totalValves;

      if (_totalValves > _totalControllerOutput) {
        _errorMsg = true;
      } else {
        _errorMsg = false;
      }
    });
  }

  String showSnackBar(BuildContext context, String message) {
    var snackbar = SnackBar(
      content: Text(
        message,
        style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
      ),
      backgroundColor: Colors.white,
      duration: Duration(seconds: 5),
      action: SnackBarAction(label: "OK", onPressed: () {}),
    );
    Scaffold.of(context).showSnackBar(snackbar);
  }

  Widget buildContent(BuildContext context) {
    return Form(
      key: _configurationformkey,
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              LabelForTextBoxes("Total Programs per Day"),
              TextFormField(
                //textAlign: TextAlign.center,
                keyboardType: TextInputType.number,
                controller: _MaxProgController,
                style: TextStyle(fontSize: 20.0, color: Colors.black),
                validator: (value) {
                  if (value.isEmpty || int.parse(value) < 1) {
                    return "Please enter the programs per day"; //showSnackBar(context, "Please enter the Max program");
                  }
                },
                maxLength: 2,
                decoration: new InputDecoration(
                  //labelText: "Total Programs per Day",
                  counterText: "",
                  border: OutlineInputBorder(),
                  fillColor: Colors.black,
                ),
              ),
              LabelForTextBoxes("Total Injectors per Controller"),
              TextFormField(
                //textAlign: TextAlign.center,
                keyboardType: TextInputType.number,
                controller: _MaxInjectorController,
                style: TextStyle(fontSize: 20.0, color: Colors.black),
                maxLength: 1,
                validator: (value) {
                  if (value.isEmpty) {
                    return "Please enter Total Injectors per Controller";
                  } else if (int.parse(value) > 4) {
                    return "You cannot enter more then 4";
                  }
                },
                decoration: new InputDecoration(
                    fillColor: Colors.black, counterText: "", suffixText: "(Max 4)", border: OutlineInputBorder()),
              ),
              LabelForTextBoxes("Total Controller Outputs"),
              TextFormField(
                //textAlign: TextAlign.center,
                keyboardType: TextInputType.number,
                controller: _MaxOutputController,
                style: TextStyle(fontSize: 20.0, color: Colors.black),
                maxLength: 2,
                validator: (value) {
                  if (value.isEmpty) {
                    return "Please enter Total Controller Outputs";
                  }
                },
                decoration: new InputDecoration(
                  counterText: "",
                  border: OutlineInputBorder(),
                  fillColor: Colors.black,
                ),
              ),
              LabelForTextBoxes("Total Valves Details"),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  LabelForTextBoxes("Irrigation"),
                  LabelForTextBoxes("Fogger"),
                  LabelForTextBoxes("       "),
                ],
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    flex: 4,
                    child: TextFormField(
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      controller: _TotalIrrigationController,
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Please enter \n Irrigation";
                        }
                      },
                      style: TextStyle(fontSize: 20.0, color: Colors.black),
                      maxLength: 2,
                      /*validator: (value) {
                        if (value.isEmpty) {
                          return "Please enter the maximum valves";
                        }
                      },*/
                      decoration: new InputDecoration(
                        counterText: "",
                        hintText: "Irrigation",
                        border: OutlineInputBorder(),
                        fillColor: Colors.black,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Expanded(
                    flex: 4,
                    child: TextFormField(
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      controller: _TotalFoggerController,
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Please enter \n Fogger";
                        }
                      },
                      style: TextStyle(fontSize: 20.0, color: Colors.black),
                      maxLength: 2,
                      /* onChanged: (str) {
                        setState(() {
                          _foggerValves = int.parse(_TotalFoggerController.text);
                        });
                      },*/
                      decoration: new InputDecoration(
                        counterText: "",
                        hintText: "Fogger",
                        border: OutlineInputBorder(),
                        fillColor: Colors.black,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Expanded(
                      flex: 3,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 25.0),
                        child: MaterialButton(
                            color: Colors.green,
                            child: Text("Done"),
                            onPressed: () {
                              CalculateTotalandremaningValves();
                            }),
                      ))
                ],
              ),
              _errorMsg == false
                  ? Container(
                      color: Color.fromRGBO(0, 84, 179, 1.0),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                                flex: 5,
                                child: Text(
                                  "Total Valves: $_totalValves",
                                  style: TextStyle(color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.bold),
                                )),
                            Expanded(
                                flex: 5,
                                child: Text("[Free Outputs = $_remaningValves]",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15.0,
                                    ))),
                          ],
                        ),
                      ),
                    )
                  : Text(
                    "Total should not be more then ${_MaxOutputController.text}.",
                    style: TextStyle(color: Colors.red),
                  ),
              commonDivider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Text(
                        "EC/pH:",
                        style: TextStyle(fontSize: 20.0),
                      ),
                      Switch(value: _valECpHType, onChanged: (bool e) => _handleECpHValueChange(e)),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Switch(value: _valRTU, onChanged: (bool _valRTU) => _handleRTUValueChange(_valRTU)),
                      Text(
                        "RTU’s:",
                        style: TextStyle(fontSize: 20.0),
                      ),
                    ],
                  ),
                ],
              ),
              _valECpHType == true
                  ? commonDivider()
                  : SizedBox(
                      height: 0.0,
                    ),
              _valECpHType == true
                  ? Row(
                      //mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Expanded(
                          flex: 3,
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 18.0),
                            child: Text(
                              "pH Delay:",
                              style: TextStyle(fontSize: 20.0),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 7,
                          child: TextFormField(
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 20.0, color: Colors.black),
                            keyboardType: TextInputType.number,
                            controller: _phDelayController,
                            maxLength: 2,
                            validator: (value) {
                              if (value.isEmpty) {
                                return "Please enter the phDelay in mins";
                              }
                            },
                            decoration: new InputDecoration(
                                counterText: "", border: OutlineInputBorder(), prefixText: "Every", suffixText: "mins"),
                          ),
                        ),
                      ],
                    )
                  : SizedBox(
                      height: 0.0,
                    ),
              _valRTU == true
                  ? commonDivider()
                  : SizedBox(
                      height: 0.0,
                    ),
              _valRTU == true
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        LabelForTextBoxes("Total RTU’s per Controller"),
                        TextField(
                          style: TextStyle(fontSize: 20.0, color: Colors.black),
                          //textAlign: TextAlign.center,
                          keyboardType: TextInputType.number,
                          controller: _MaxRTUController,
                          maxLength: 2,
                          onChanged: (str) {
                            setState(() {
                              _updateSlaveCount();
                            });
                          },
                          decoration: new InputDecoration(counterText: "", border: OutlineInputBorder()
                              //labelText: "Total RTU’s per Controller",
                              // fillColor: Colors.black,
                              //errorText: _NoOfSlavesController.text == null ?slaveValidate: "",
                              ),
                        ),
                        errorMsgRTU == true?Text("Please enter Total RTU’s per Controller",style: TextStyle(
                            color: Colors.red
                        ),):SizedBox(height: 0.0,),
                      ],
                    )
                  : SizedBox(
                      height: 0.0,
                    ),
              _valRTU == true
                  ? Center(
                    child: Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: Text(
                        "RTU Details",
                        style: TextStyle(fontSize: 20.0),
                      ),
                    ),
                  )
                  : SizedBox(
                      height: 0.0,
                    ),
              _valRTU == true
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          height: 250.0,
                          width: 300.0,
                          decoration: BoxDecoration(
                            border: Border.all(width: 1.0, color: Colors.black),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(13.0),
                            child: SingleChildScrollView(child: createSlaveTextFields()),
                          ),
                        ),
                      ],
                    )
                  : SizedBox(
                      height: 0.0,
                    ),
              SizedBox(
                height: 10.0,
              ),
              Center(
                child: RawMaterialButton(
                  textStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                  ),
                  onPressed: () {
                    if(_MaxRTUController.text.isEmpty && _valRTU == true){
                      setState(() {
                        errorMsgRTU = true;
                      });
                    }else{
                      setState(() {
                        errorMsgRTU = false;
                      });
                    }

                    CalculateTotalandremaningValves();
                    setState(() {
                      if (_configurationformkey.currentState.validate() && (_MaxRTUController.text.isEmpty && _valRTU == false) && (_totalValves <= _totalControllerOutput)) {
                          _loading = _handleSave().then((_) {
                            if (mounted) {
                              ControllerDetails.navigateToNext(context);
                            }
                          });
                      }else{
                        showColoredToast("Please enter the valid value");
                      }
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(
                      _oldConfig != null ? "Update" : "Save",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  fillColor: Color.fromRGBO(0, 84, 179, 1.0),
                  shape: StadiumBorder(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _updateSlaveCount() {
    setState(() {
      _slaveTextControllers.length = int.parse(_MaxRTUController.text);
      for (int i = 0; i < _slaveTextControllers.length; i++) {
        if (_slaveTextControllers[i] == null) {
          _slaveTextControllers[i] = TextEditingController();
        }
      }
    });
  }

  Widget createSlaveTextFields() {
    if (_slaveTextControllers.length != 0) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(_slaveTextControllers.length, (index) {
          return Padding(
            padding: const EdgeInsets.all(2.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  flex: 3,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: Text(
                      "RTU-${index + 1}",
                      style: TextStyle(
                        fontSize: 20.0,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 7,
                  child: TextFormField(
                    style: TextStyle(fontSize: 20.0, color: Colors.black),
                    textAlign: TextAlign.center,
                    controller: _slaveTextControllers[index],
                    maxLength: 10,
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Please enter Mob no for RTU";
                      }
                    },
                    decoration: new InputDecoration(
                      //labelText: "RTU ${index + 1}",
                      hintText: "Mobile No.",
                      counterText: "",
                      border: OutlineInputBorder(),
                      fillColor: Colors.black,
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ),
              ],
            ),
          );
        }),
      );
    } else {
      return Center(
        child: Text(
          "No RTU Avaliable. Enter the no. of RTU.",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      );
    }
  }
}
