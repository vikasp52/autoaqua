import 'dart:async';

import 'package:autoaqua/Model/StringModel.dart';
import 'package:autoaqua/UI/ControllerDetails/ControllerDetails.dart';
import 'package:autoaqua/Model/ConfigurationModel.dart';
import 'package:autoaqua/UI/ControllerDetails/FoggerPage.dart';
import 'package:autoaqua/UI/ControllerDetails/ProgramPage.dart';
import 'package:autoaqua/Utils/APICallMethods.dart';
import 'package:autoaqua/Utils/Database_Client.dart';
import 'package:autoaqua/Utils/CommonlyUserMethod.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

//var etMaxProgram = TextEditingController();
class ConfigurationPage extends StatefulWidget {
  static Route<dynamic> route(int controllerId, String controllerName) {
    return ControllerDetailsPageRoute(
      pageId: ControllerDetailsPageId.CONFIGURATION,
      builder: (context) => ConfigurationPage(
            controllerId: controllerId,
            controllerName: controllerName,
          ),
    );
  }

  const ConfigurationPage({
    Key key,
    @required this.controllerId,
    @required this.controllerName,
  }) : super(key: key);

  final int controllerId;
  final String controllerName;

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
  String _fDelay;
  String configString;

  APIMethods apiMethods = new APIMethods();


  Future _loading;
  ConfigurationModel _oldConfig;
  StringModel _oldString;

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
  void initState(){
    super.initState();
    print("Controller Name : ${widget.controllerName}");
    print("THis is database table for Configuration ${db.getConfigItems()}");
    _errorMsg = false;
    db.getFoggerDetailsforConfig(widget.controllerId).then((foggerData){
      if(foggerData != null){
        setState(() {
          _fDelay = foggerData.fogger_foggerDelay;
        });
      }else{
        _fDelay = "00";
      }
      print("_fDelay is ${_fDelay}");
    });

    _loading = db.getStrings(widget.controllerId).then((sData){
      _oldString = sData;
    });

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

  //Get the data to generate String
  Future<String> stringforConfig()async{
    print("id here: ${widget.controllerId}");
    print('Max Program ${AppendZero(_MaxProgController.text)}');
    print('Max OP ${AppendZero(_MaxOutputController.text)}');
    print('Max RTU ${AppendZero(_MaxRTUController.text)}');
    print('Max Fogger ${_TotalFoggerController.text}');
    print('Fogger Delay ${AppendZero(_fDelay)}');
    print('pH Delay ${AppendZero(_phDelayController.text)}');
    print("ConfigString: $configString");
    return configString = "QD${AppendZero(_MaxProgController.text) + AppendZero(_MaxOutputController.text) + AppendZero(_MaxRTUController.text) + _TotalFoggerController.text + AppendZero(_fDelay) + AppendZero(_phDelayController.text)}>";

  }

  Future<void> _handleSave() async {
    configString = "QD${AppendZero(_MaxProgController.text) + AppendZero(_MaxOutputController.text) + AppendZero(_MaxRTUController.text) + _TotalFoggerController.text + AppendZero(_fDelay) + AppendZero(_phDelayController.text)}>";
    //saveUpdateStringData(widget.controllerId, configString);

   /* if(_oldString == null){
          StringModel saveStringData = new StringModel(
          widget.controllerId,
          configString,
          dateFormatted());
          await db.saveStrings(saveStringData);
          await db.getStrings(widget.controllerId);
          await db.getStringData(widget.controllerId);
    }else{
      StringModel saveStringData = new StringModel(
          widget.controllerId,
          configString,
          dateFormatted(),
        _oldString.stringId
      );
      await db.updateString(saveStringData);
      await db.getStrings(widget.controllerId);
      await db.getStringData(widget.controllerId);
    }*/

   /* //Method the save the String in StringTable
    saveUpdateStringData(controllerId, string) async {
      final db = new DataBaseHelper();
      StringModel saveStringData = new StringModel(controllerId, string, dateFormatted());
      await db.saveStrings(saveStringData);
      await db.getStringData(controllerId);
    }*/

    if (_oldConfig == null) {
      ConfigurationModel newConfig = new ConfigurationModel(
          widget.controllerId,
          _MaxProgController.text,
          _MaxOutputController.text,
          _MaxInjectorController.text,
          _TotalFoggerController.text,
          _TotalIrrigationController.text,
          _totalValves.toString(),
          _remaningValves.toString(),
          _valECpHType.toString(),
          _valRTU.toString(),
          _phDelayController.text,
          _MaxRTUController.text,
          _slaveTextControllers.map((controller) => controller.value.text).toList(growable: false),
          dateFormatted(),
          configString
          //_oldConfig.configid
          );

      int saveItemId = await db.saveConfigurationItem(newConfig);
      var addedItem = await db.getConfigDataForController(widget.controllerId);
      saveStringData(widget.controllerId, "CONFIG", '${widget.controllerId}', '0', configString);
      /*db.saveStrings(widget.controllerId);
      await db.getStrings(widget.controllerId);
      await db.getStringData(widget.controllerId);*/
     /* StringModel saveStringData = new StringModel(widget.controllerId, configString, dateFormatted());
      await db.saveStrings(saveStringData);
      await db.getStringData(widget.controllerId);
      print('Added Item: $saveItemId: $saveStringData');*/
      //Navigator.of(context).pushReplacement(ProgramPage.route(widget.controllerId, widget.controllerName));
    } else {
      ConfigurationModel newConfig = new ConfigurationModel(
          widget.controllerId,
          _MaxProgController.text,
          _MaxOutputController.text,
          _MaxInjectorController.text,
          _TotalFoggerController.text,
          _TotalIrrigationController.text,
          _totalValves.toString(),
          _remaningValves.toString(),
          _valECpHType.toString(),
          _valRTU.toString(),
          _phDelayController.text,
          _MaxRTUController.text,
          _slaveTextControllers.map((controller) => controller.value.text).toList(growable: false),
          dateFormatted(),
          configString,
          _oldConfig.configid);

      int saveItemId = await db.updateConfigurationItems(newConfig);
      var addedItem = await db.getConfigDataForController(widget.controllerId);
      print('Added Item: $saveItemId: $addedItem');

      updateStringData(widget.controllerId, "CONFIG", '${widget.controllerId}', '0', configString);
      /*db.updateConfigString(widget.controllerId);
      await db.getStrings(widget.controllerId);
      await db.getStringData(widget.controllerId);
      StringModel updateStringData = new StringModel(widget.controllerId, configString, dateFormatted());
      var savedString = await db.updateString(updateStringData);
      await db.getStringData(widget.controllerId);
      print('Added String Item: $saveItemId: $savedString');*/
     // Navigator.of(context).pushReplacement(ProgramPage.route(widget.controllerId, widget.controllerName));
    }
  }

  void validation(){
    if (_MaxRTUController.text.isEmpty && _valRTU == true) {
      setState(() {
        errorMsgRTU = true;
      });
    } else {
      setState(() {
        errorMsgRTU = false;
      });
    }
  }

  void CalculateTotalandremaningValves() async {
    if (_MaxOutputController.text.isNotEmpty) {
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
              Center(
                child: Text(
                  widget.controllerName.toUpperCase(),
                  style: TextStyle(fontSize: 30.0, color: Color.fromRGBO(0, 84, 179, 1.0), fontWeight: FontWeight.bold),
                ),
              ),
              commonDivider(),
              LabelForTextBoxes("Total Programs per Day"),
              CommonTextField(
                _MaxProgController,
                (value) {
                  if (validateEmpty(value)) {
                    return "Please enter the programs per day"; //showSnackBar(context, "Please enter the Max program");
                  }
                },
              ),
              /*TextFormField(
                //textAlign: TextAlign.center,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  BlacklistingTextInputFormatter(new RegExp('[\\.|\\,-]')),
                ],
                controller: _MaxProgController,
                style: TextStyle(fontSize: 20.0, color: Colors.black),
                validator: (value) {
                  //bool tst = _MaxProgController.text.isNotEmpty?int.parse(value) < 1:false;
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
              ),*/
              LabelForTextBoxes("Total Injectors per Controller"),
              CommonTextField(_MaxInjectorController, (value) {
                if (validateEmpty(value)) {
                  return "Please enter Total Injectors per Controller";
                } else if (int.parse(value) > 4) {
                  return "You cannot enter more then 4";
                }
              }, TextAlign.start,
                  "(Max 4)"),
              /*TextFormField(
                //textAlign: TextAlign.center,
                keyboardType: TextInputType.number,
                controller: _MaxInjectorController,
                style: TextStyle(fontSize: 20.0, color: Colors.black),
                maxLength: 1,
                validator: (value) {
                  if (value.isEmpty || int.parse(value) < 1) {
                    return "Please enter Total Injectors per Controller";
                  } else if (int.parse(value) > 4) {
                    return "You cannot enter more then 4";
                  }
                },
                decoration: new InputDecoration(
                    fillColor: Colors.black, counterText: "", suffixText: "(Max 4)", border: OutlineInputBorder()),
              ),*/
              LabelForTextBoxes("Total Controller Outputs"),
              CommonTextField(
                _MaxOutputController,
                (value) {
                  if (validateEmpty(value)) {
                    return "Please enter Total Controller Outputs";
                  }
                },
              ),
              /*TextFormField(
                keyboardType: TextInputType.number,
                controller: _MaxOutputController,
                style: TextStyle(fontSize: 20.0, color: Colors.black),
                maxLength: 2,
                validator: (value) {
                  if (value.isEmpty || int.parse(value) < 1) {
                    return "Please enter Total Controller Outputs";
                  }
                },
                decoration: new InputDecoration(
                  counterText: "",
                  border: OutlineInputBorder(),
                  fillColor: Colors.black,
                ),
              ),*/
              LabelForTextBoxes("Total Valves Details"),
              Row(
                children: <Widget>[
                  Expanded(flex: 4, child: Center(child: LabelForTextBoxes("Irrigation"))),
                  Expanded(flex: 4, child: Center(child: LabelForTextBoxes("Fogger"))),
                  Expanded(flex: 3, child: LabelForTextBoxes("       ")),
                ],
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    flex: 4,
                    child: CommonTextField(
                      _TotalIrrigationController,
                      (value) {
                        if (validateEmpty(value)) {
                          return "Please enter \n Irrigation";
                        }
                      },
                      TextAlign.center,
                    ),

                    /*TextFormField(
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      controller: _TotalIrrigationController,
                      validator: (value) {
                        if (value.isEmpty || int.parse(value) < 1) {
                          return "Please enter \n Irrigation";
                        }
                      },
                      style: TextStyle(fontSize: 20.0, color: Colors.black),
                      maxLength: 2,
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Please enter the maximum valves";
                        }
                      },
                      decoration: new InputDecoration(
                        counterText: "",
                        hintText: "Irrigation",
                        border: OutlineInputBorder(),
                        fillColor: Colors.black,
                      ),
                    ),*/
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Expanded(
                    flex: 4,
                    child: CommonTextField(
                      _TotalFoggerController,
                      (value) {
                        if (value.isEmpty) {
                          return "Please enter \n Fogger";
                        }
                      },
                      TextAlign.center,
                    ),

                    /*TextFormField(
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      controller: _TotalFoggerController,
                      validator: (value) {
                        if (value.isEmpty || int.parse(value) < 1) {
                          return "Please enter \n Fogger";
                        }
                      },
                      style: TextStyle(fontSize: 20.0, color: Colors.black),
                      maxLength: 2,
                      */ /* onChanged: (str) {
                        setState(() {
                          _foggerValves = int.parse(_TotalFoggerController.text);
                        });
                      },*/ /*
                      decoration: new InputDecoration(
                        counterText: "",
                        hintText: "Fogger",
                        border: OutlineInputBorder(),
                        fillColor: Colors.black,
                      ),
                    ),*/
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
                          child:CommonTextField(
                              _phDelayController,
                                (value) {
                              if (validateEmpty(value)) {
                                return "Please enter the phDelay in mins";
                              }
                            },
                              TextAlign.center,
                              "mins",
                            "Every"
                          ),


                          /*TextFormField(
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 20.0, color: Colors.black),
                            keyboardType: TextInputType.number,
                            controller: _phDelayController,
                            maxLength: 2,
                            validator: (value) {
                              if (value.isEmpty || int.parse(value) < 1) {
                                return "Please enter the phDelay in mins";
                              }
                            },
                            decoration: new InputDecoration(
                                counterText: "", border: OutlineInputBorder(), prefixText: "Every", suffixText: "mins"),
                          ),*/
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
                        errorMsgRTU == true
                            ? Text(
                                "Please enter Total RTU’s per Controller",
                                style: TextStyle(color: Colors.red),
                              )
                            : SizedBox(
                                height: 0.0,
                              ),
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

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  commonButton(
                    (){
                      validation();
                      CalculateTotalandremaningValves();
                      setState(() {
                        if (_configurationformkey.currentState.validate() &&
                            errorMsgRTU == false &&
                            (_totalValves <= _totalControllerOutput)) {
                          _loading = stringforConfig().then((_) {
                            if (mounted) {
                             /* _oldConfig != null
                                  ? saveStringData(widget.controllerId, "CONFIG", '${widget.controllerId}', '0', configString)
                                  : updateStringData(widget.controllerId, "CONFIG", '${widget.controllerId}', '0', configString);*/
                              sendSmsForAndroid(configString, widget.controllerId);
                              _handleSave();
                              Navigator.of(context).popUntil((route) => route is ControllerDetailsMainRoute);
                              showPositiveToast("sms sent successfully");
                            }
                          });
                        } else {
                          showColoredToast("There is some problem");
                        }
                      });
                    },
                      "Send"
                  ),
                  commonButton(
                        () {
                     validation();
                      CalculateTotalandremaningValves();
                      List<String> MobNo =
                      _slaveTextControllers.map((controller) => controller.value.text).toList(growable: false);
                      String slaveMoNo = MobNo.join(',');
                      print("Mob No is $MobNo");
                      print("slave No is $slaveMoNo");
                      /*apiMethods.saveAndUpdateConfigDataOnServer(
                            _MaxProgController.text,
                            _MaxOutputController.text,
                            //slaveMoNo,
                            _MaxRTUController.text,
                            _MaxInjectorController.text,
                            _TotalIrrigationController.text,
                            _TotalFoggerController.text,
                            _totalValves.toString(),
                            _remaningValves.toString(),
                            _valECpHType == true ? "1" : "0",
                            _valRTU == true ? "1" : "0",
                            _phDelayController.text,
                            slaveMoNo,
                            //"00",
                            widget.controllerId.toString());*/
                      setState(() {
                        if (_configurationformkey.currentState.validate() &&
                            errorMsgRTU == false &&
                            (_totalValves <= _totalControllerOutput)) {

                          _loading = _handleSave().then((_) {
                            if (mounted) {
                              //ControllerDetails.navigateToNext(context);
                              Navigator.of(context).popUntil((route) => route is ControllerDetailsMainRoute);
                              _oldConfig != null
                                  ? showPositiveToast("Data is updated successfully")
                                  : showPositiveToast("Data is saved successfully");
                            }
                          });
                        } else {
                          showColoredToast("Please enter the valid value");
                        }
                      });
                    },
                    _oldConfig != null ? "Update" : "Save",),
                ],
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
                  child:TextFormField(
                    style: TextStyle(fontSize: 20.0, color: Colors.black),
                    textAlign: TextAlign.center,
                    controller: _slaveTextControllers[index],
                    maxLength: 10,
                    validator: (value) {
                      if (value.isEmpty || int.parse(value) < 1 || value.length < 10) {
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
