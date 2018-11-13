import 'dart:async';

import 'package:autoaqua/UI/ControllerDetails/ControllerDetails.dart';
import 'package:autoaqua/Model/ConfigurationModel.dart';
import 'package:autoaqua/UI/ControllerDetails/ProgramPage.dart';
import 'package:autoaqua/Utils/Database_Client.dart';
import 'package:autoaqua/Utils/DateFormatter.dart';
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
  final _MaxRTUController = TextEditingController();
  final _NoOfSlavesController = TextEditingController();
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
        _valECpHType = config.configEcpHStatus == "true" ? true : false;
        _valRTU = config.configMaxRTUOnOff == "true" ? true : false;
        _MaxRTUController.value = TextEditingValue(text: config.configMaxRTU);
        _slaveTextControllers.length = config.slaveMobNos.length;
        _NoOfSlavesController.value = TextEditingValue(text: config.configNoOfSlaves);
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

  _AppendZero(String etController) {
    if (etController.length < 2) {
      return '0' + '$etController';
    } else {
      return etController;
    }
  }

  Future<void> _handleSave() async {
    print("id here: ${widget.controllerId}");

    if (_oldConfig == null) {
      ConfigurationModel newConfig = new ConfigurationModel(
        widget.controllerId,
        _AppendZero(_MaxProgController.text),
        _AppendZero(_MaxOutputController.text),
        _valECpHType.toString(),
        _valRTU.toString(),
        _AppendZero(_MaxRTUController.text),
        _AppendZero(_NoOfSlavesController.text),
        _slaveTextControllers.map((controller) => controller.value.text).toList(growable: false),
        dateFormatted(),
        //_oldConfig.configid
      );

      int saveItemId = await db.saveConfigurationItem(newConfig);
      var addedItem = await db.getConfigDataForController(widget.controllerId);
      print('Added Item: $saveItemId: $addedItem');

      Navigator.of(context).pushReplacement(ProgramPage.route(widget.controllerId));
    } else {
      ConfigurationModel newConfig = new ConfigurationModel(
          widget.controllerId,
          _AppendZero(_MaxProgController.text),
          _AppendZero(_MaxOutputController.text),
          _valECpHType.toString(),
          _valRTU.toString(),
          _AppendZero(_MaxRTUController.text),
          _AppendZero(_NoOfSlavesController.text),
          _slaveTextControllers.map((controller) => controller.value.text).toList(growable: false),
          dateFormatted(),
          _oldConfig.configid);

      int saveItemId = await db.updateConfigurationItems(newConfig);
      var addedItem = await db.getConfigDataForController(widget.controllerId);
      print('Added Item: $saveItemId: $addedItem');

      Navigator.of(context).pushReplacement(ProgramPage.route(widget.controllerId));
    }
  }

  Widget buildContent(BuildContext context) {
    return Form(
      key: _configurationformkey,
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(18.0),
          child: Column(
            children: <Widget>[
              TextFormField(
                keyboardType: TextInputType.number,
                controller: _MaxProgController,
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.black
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return "Please enter the Max program";
                  }
                },
                autofocus: true,
                maxLength: 2,
                decoration: new InputDecoration(
                  labelText: "Maximum Program",
                  fillColor: Colors.black,
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                controller: _MaxOutputController,
                style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.black
                ),
                maxLength: 2,
                validator: (value) {
                  if (value.isEmpty) {
                    return "Please enter the Max output";
                  }
                },
                decoration: new InputDecoration(
                  labelText: "Maximum Valves",
                  fillColor: Colors.black,
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
                        "RTU:",
                        style: TextStyle(fontSize: 20.0),
                      ),
                      Switch(value: _valRTU, onChanged: (bool _valRTU) => _handleRTUValueChange(_valRTU)),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 10.0,
              ),
              _valECpHType == true
                  ? TextFormField(
                      keyboardType: TextInputType.number,
                      controller: _MaxRTUController,
                      maxLength: 2,
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Please enter the phDelay in mins";
                        }
                      },
                      decoration: new InputDecoration(
                        labelText: "ph Delay(mins)",
                        fillColor: Colors.black,
                      ),
                    )
                  : SizedBox(
                      height: 0.0,
                    ),
              SizedBox(
                height: 10.0,
              ),
              _valRTU == true
                  ? TextField(
                      keyboardType: TextInputType.number,
                      controller: _NoOfSlavesController,
                      maxLength: 2,
                      onChanged: (str) {
                        setState(() {
                          _updateSlaveCount();
                        });
                      },
                      decoration: new InputDecoration(
                        labelText: "Maximum RTU",
                        fillColor: Colors.black,
                        //errorText: _NoOfSlavesController.text == null ?slaveValidate: "",
                      ),
                    )
                  : SizedBox(
                      height: 0.0,
                    ),
              _valRTU == true
                  ? Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: Text("RTU Details"),
                    )
                  : SizedBox(
                      height: 0.0,
                    ),
              _valRTU == true
                  ? Container(
                      //height: 250.0,
                      //width: 300.0,
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
              MaterialButton(
                onPressed: () {
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
                child: Text(_oldConfig != null ? "Update & Next" : "Save & Next"),
                color: Colors.lightBlue,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _updateSlaveCount() {
    setState(() {
      _slaveTextControllers.length = int.parse(_NoOfSlavesController.text);
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
            child: TextFormField(
              controller: _slaveTextControllers[index],
              maxLength: 10,
              validator: (value) {
                if (value.isEmpty) {
                  return "Please enter the mobile no for slaves";
                }
              },
              decoration: new InputDecoration(
                labelText: "Slave ${index + 1}",
                hintText: "Enter the mobile no.",
                fillColor: Colors.black,
              ),
              keyboardType: TextInputType.number,
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
