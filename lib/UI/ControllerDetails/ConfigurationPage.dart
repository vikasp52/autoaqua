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
  final _slaveTextControllers = <TextEditingController>[];
  bool _valECpHType = false;
  bool _valRTU = false;

  Future _loading;
  ConfigurationModel _oldConfig;

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

    _loading = db.getConfigDataForController(widget.controllerId).then((config) {
      _oldConfig = config;
      if (config != null) {
        _MaxProgController.value = TextEditingValue(text: config.configMaxProg);
        _MaxOutputController.value = TextEditingValue(text: config.configMaxOutput);
        _MaxInjectorController.value = TextEditingValue(text: config.configMaxInjector);
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
        _valECpHType.toString(),
        _valRTU.toString(),
        AppendZero(_phDelayController.text),
        AppendZero(_MaxRTUController.text),
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
          _valECpHType.toString(),
          _valRTU.toString(),
          AppendZero(_phDelayController.text),
          AppendZero(_MaxRTUController.text),
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

  paddingforText() {
    return const EdgeInsets.only(bottom: 8.0);
  }

  String showSnackBar(BuildContext context, String message) {
    var snackbar = SnackBar(
      content: Text(message,style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
      backgroundColor: Colors.white,
      duration: Duration(seconds: 5),
      action: SnackBarAction(label: "OK", onPressed: (){}),
    );
    Scaffold.of(context).showSnackBar(snackbar);
  }

  Widget buildContent(BuildContext context) {
    return Form(
      key: _configurationformkey,
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Column(
            children: <Widget>[
              Row(
               // mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Flexible(
                    child: Padding(
                      padding: paddingforText(),
                      child: Text(
                        "Total Programs per Day: ",
                        //textAlign: TextAlign.right,
                        style: TextStyle(fontSize: 20.0),
                      ),
                    ),
                  ),
                  Container(
                    width: 40.0,
                    child: TextFormField(
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      controller: _MaxProgController,
                      style: TextStyle(fontSize: 20.0, color: Colors.black),
                      validator: (value) {
                        if (value.isEmpty || int.parse(value) < 1) {
                          return  "";//showSnackBar(context, "Please enter the Max program");
                        }
                      },
                      autofocus: true,
                      maxLength: 2,
                      decoration: new InputDecoration(
                        //labelText: "Total Programs per Day",
                        counterText: "",
                        fillColor: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                //mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Flexible(
                      child: Padding(
                        padding: paddingforText(),
                        child: Text(
                          "Total Valves per Controller: ",
                          style: TextStyle(fontSize: 20.0),
                        ),
                      )),
                  Container(
                    width: 40.0,
                    child: TextFormField(
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      controller: _MaxOutputController,
                      style: TextStyle(fontSize: 20.0, color: Colors.black),
                      maxLength: 2,
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Please enter the Max output";
                        }
                      },
                      decoration: new InputDecoration(
                        counterText: "",
                        fillColor: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                //mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Flexible(
                    child: Padding(
                      padding: paddingforText(),
                      child: Text(
                        "Total Injectors Controller: ",
                        style: TextStyle(fontSize: 20.0),
                      ),
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      Container(
                        width: 40.0,
                        child: TextFormField(
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.number,
                          controller: _MaxInjectorController,
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
                            fillColor: Colors.black,
                            counterText: "",
                          ),
                        ),
                      ),
                      Padding(
                        padding: paddingforText(),
                        child: Text("(Max 4)"),
                      )
                    ],
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Divider(
                  height: 1.0,
                ),
              ),
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
                      Text(
                        "RTU’s:",
                        style: TextStyle(fontSize: 20.0),
                      ),
                      Switch(value: _valRTU, onChanged: (bool _valRTU) => _handleRTUValueChange(_valRTU)),
                    ],
                  ),
                ],
              ),
              _valECpHType == true
                  ? Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Divider(
                        height: 1.0,
                      ),
                    )
                  : SizedBox(
                      height: 0.0,
                    ),
              _valECpHType == true
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: paddingforText(),
                          child: Text(
                            "pH Delay: ",
                            style: TextStyle(fontSize: 20.0),
                          ),
                        ),
                        Padding(
                          padding: paddingforText(),
                          child: Text(
                            "Every ",
                            style: TextStyle(fontSize: 20.0),
                          ),
                        ),
                        Container(
                          width: 60.0,
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
                              counterText: "",
                            ),
                          ),
                        ),
                        Padding(
                          padding: paddingforText(),
                          child: Text(
                            " mins",
                            style: TextStyle(fontSize: 20.0),
                          ),
                        ),
                      ],
                    )
                  : SizedBox(
                      height: 0.0,
                    ),
              _valRTU == true
                  ? Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Divider(
                        height: 1.0,
                      ),
                    )
                  : SizedBox(
                      height: 0.0,
                    ),
              _valRTU == true
                  ? Row(
                      //mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Flexible(
                            child: Padding(
                              padding: paddingforText(),
                              child: Text(
                                "Total RTU’s per Controller: ",
                                style: TextStyle(
                                  fontSize: 20.0,
                                ),
                              ),
                            )),
                        Container(
                          width: 40.0,
                          child: TextField(
                            style: TextStyle(fontSize: 20.0, color: Colors.black),
                            textAlign: TextAlign.center,
                            keyboardType: TextInputType.number,
                            controller: _MaxRTUController,
                            maxLength: 2,
                            onChanged: (str) {
                              setState(() {
                                _updateSlaveCount();
                              });
                            },
                            decoration: new InputDecoration(
                              counterText: "",
                              // fillColor: Colors.black,
                              //errorText: _NoOfSlavesController.text == null ?slaveValidate: "",
                            ),
                          ),
                        ),
                      ],
                    )
                  : SizedBox(
                      height: 0.0,
                    ),
              _valRTU == true
                  ? Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: Text(
                        "RTU Details",
                        style: TextStyle(fontSize: 20.0),
                      ),
                    )
                  : SizedBox(
                      height: 0.0,
                    ),
              _valRTU == true
                  ? Container(
                      height: 250.0,
                      width: 250.0,
                      decoration: BoxDecoration(
                        border: Border.all(width: 1.0, color: Colors.black),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(13.0),
                        child: SingleChildScrollView(child: createSlaveTextFields()),
                      ),
                    )
                  : SizedBox(
                      height: 0.0,
                    ),
              SizedBox(
                height: 10.0,
              ),
              RawMaterialButton(
                textStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                ),
                onPressed: () {
                  if(_MaxProgController.text.isEmpty || int.parse(_MaxProgController.text) < 1){
                    showSnackBar(context, "Enter the total no. of program");
                  }else if(_MaxOutputController.text.isEmpty){
                    showSnackBar(context, "Enter the out program");
                  }
                  setState(() {
                    if (_configurationformkey.currentState.validate()) {
                      _loading = _handleSave().then((_) {
                        if (mounted) {
                          ControllerDetails.navigateToNext(context);
                        }
                      });
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
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Flexible(
                    child: Container(
                  width: 70.0,
                  //color: Colors.green,
                  child: Padding(
                    padding: paddingforText(),
                    child: Text(
                      "RTU ${index + 1}: ",
                      style: TextStyle(
                        fontSize: 20.0,
                      ),
                    ),
                  ),
                )),
                SizedBox(
                  width: 10.0,
                ),
                Container(
                  width: 120.0,
                  //color: Colors.green,
                  child: TextFormField(
                    style: TextStyle(fontSize: 20.0, color: Colors.black),
                    textAlign: TextAlign.center,
                    controller: _slaveTextControllers[index],
                    maxLength: 10,
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Please enter the mobile no for controller";
                      }
                    },
                    decoration: new InputDecoration(
                      //labelText: "Controller ${index + 1}",
                      //hintText: "Enter the mobile no.",
                      counterText: "",
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
          "No Slaves Avaliable. Enter the no. of slaves.",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      );
    }
  }
}
