import 'package:autoaqua/Model/ConfigurationModel.dart';
import 'package:autoaqua/Model/FoggerModel.dart';
import 'package:autoaqua/UI/ControllerDetails/ControllerDetails.dart';
import 'package:autoaqua/Utils/Database_Client.dart';
import 'package:autoaqua/Utils/CommonlyUserMethod.dart';
import 'package:flutter/material.dart';

class FoggerPage extends StatefulWidget {
  static Route<dynamic> route(int controllerId, String controllerName) {
    return ControllerDetailsPageRoute(
      pageId: ControllerDetailsPageId.FOGGER,
      builder: (context) => FoggerPage(
            controllerId: controllerId,
          controllerName:controllerName,
          ),
    );
  }

  const FoggerPage({
    Key key,
    @required this.controllerId,
    @required this.controllerName,
  }) : super(key: key);

  final int controllerId;
  final String controllerName;

  @override
  _FoggerPageState createState() => _FoggerPageState();
}

class _FoggerPageState extends State<FoggerPage> {
  final _foggerValveNoController = <TextEditingController>[];
  final _onSecontroller = <TextEditingController>[];
  final _minTempController = <TextEditingController>[];
  final _maxTempController = <TextEditingController>[];
  final _minHumController = <TextEditingController>[];
  final _maxHumController = <TextEditingController>[];
  final _foggerDelayController = TextEditingController();

  List<FoggerModel> _oldmodelFogger;
  Future _loading;
  int _count = 0;
  int _radioFoggingType;
  int _totalFoggerValves;
  int _totalValves;
  int _minFValveNo;
  var db = new DataBaseHelper();
  ConfigurationModel configurationModel;
  final _foggerKey = GlobalKey<FormState>();

  bool delayErrorMsg = false;

  void _handleFoggingRadioValueChange(int value) {
    setState(() {
      _radioFoggingType = value;

      /*switch (_radioValueFlushType) {
        case 0:

          break;
        case 1:
        //_result = ...
          break;
      }*/
    });
  }

  @override
  void initState() {
    super.initState();
    print("THis is database table for Configuration ${db.getConfigItems()}");

    _loading = db.getConfigDataForController(widget.controllerId).then((configData) {
      if (configData != null) {
        setState(() {
          _count = int.parse(configData.ConfigmaxFogger);
          _ensureTextControllsers(_count);
          _totalFoggerValves = int.parse(configData.ConfigmaxFogger);
          _totalValves = int.parse(configData.configTotalValves);

          _minFValveNo = (_totalValves - _totalFoggerValves) + 1;
        });
      }
    });

    _loading = db.getFoggerData(widget.controllerId).then((foggerdetails) {
      _oldmodelFogger = foggerdetails;
      if (foggerdetails != null) {
        setState(() {
          // _ensureTextControllsers(foggerdetails.length);
          for (int i = 0; i < foggerdetails.length; i++) {
            final model = foggerdetails[i];
            print("Fogger data is : $foggerdetails[]");
            _foggerValveNoController[i].text = model.fogger_Field;
            _onSecontroller[i].text = model.fogger_onSec;
            _minTempController[i].text = model.fogger_tempDegree;
            _maxTempController[i].text = model.fogger_maxTemp;
            _minHumController[i].text = model.fogger_hum;
            _maxHumController[i].text = model.fogger_maxHum;
            _foggerDelayController.value = TextEditingValue(text: model.fogger_foggerDelay);
            _radioFoggingType = int.parse(model.fogger_maxRTU);
          }
        });
      }
    });
  }

  void _ensureTextControllsers(int count) {
    _count = count;
    _foggerValveNoController.length = count;
    _onSecontroller.length = count;
    _minTempController.length = count;
    _maxTempController.length = count;
    _minHumController.length = count;
    _maxHumController.length = count;
    for (int i = 0; i < count; i++) {
      _foggerValveNoController[i] ??= TextEditingController();
      _onSecontroller[i] ??= TextEditingController();
      _minTempController[i] ??= TextEditingController();
      _maxTempController[i] ??= TextEditingController();
      _minHumController[i] ??= TextEditingController();
      _maxHumController[i] ??= TextEditingController();
    }
  }

  /*void _onAddPressed() {
    setState(() => _ensureTextControllsers(_count + 1));
  }

  void _onRemovePressed() {
    if (_count > 0) {
      setState(() => _ensureTextControllsers(_count - 1));
    }
  }*/

  Future<void> _handelFoggerDataSubmit() async {
    for (int i = 0; i < _count; i++) {
      final model = FoggerModel(
          widget.controllerId,
          _radioFoggingType.toString(),
          _foggerDelayController.text,
          _foggerValveNoController[i].text,
          _onSecontroller[i].text,
          _minTempController[i].text,
          _maxTempController[i].text,
          _minHumController[i].text,
          _maxHumController[i].text,
          dateFormatted(),
          "${AppendZero(_foggerDelayController.text)}");
      if (i < (_oldmodelFogger?.length ?? 0)) {
        model.foggerId = _oldmodelFogger[i].foggerId;
      }
      await db.saveFoggerData(model);
    }
    if (_count < (_oldmodelFogger?.length ?? 0)) {
      for (int i = _count; i < _oldmodelFogger.length; i++) {
        await db.deleteFoggerData(_oldmodelFogger[i].foggerId);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _foggerKey,
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Center(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(widget.controllerName,style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                    fontWeight: FontWeight.bold
                ),),
              ),
            ),
            commonDivider(),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Flexible(
                        flex:7,
                          child: Padding(
                            padding: const EdgeInsets.only(bottom:12.0),
                            child: LabelForTextBoxes("Fogger Sensing Delay: "),
                          )),
                      Expanded(
                        flex: 3,
                        child: CommonTextField(
                          _foggerDelayController,
                              (value) {
                            if (validateEmpty(value)) {
                              return "";
                            }
                          },
                          TextAlign.center,
                            "mins",
                        ),
                      ),
                    ],
                  ),
                  /*TextFormField(
                      style: TextStyle(fontSize: 20.0, color: Colors.black),
                      keyboardType: TextInputType.number,
                      validator: (val) {
                        if (_foggerDelayController.text.isEmpty) {
                          return "Please enter Fogger Sensing Delay";
                        }
                      },
                      controller: _foggerDelayController,
                      maxLength: 2,
                      decoration: new InputDecoration(
                          fillColor: Colors.black, border: OutlineInputBorder(), counterText: "", suffixText: "mins"
                          //errorText: _NoOfSlavesController.text == null ?slaveValidate: "",
                          )),*/
                  Center(
                    child: delayErrorMsg?Text("Please enter Fogger Sensing Delay.", textAlign: TextAlign.center,style: TextStyle(
                      color: Colors.red
                    ),):SizedBox(width: 0.0,),
                  ),
                  commonDivider(),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      LabelForTextBoxes("Fogging by:"),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Radio(
                                value: 1,
                                groupValue: _radioFoggingType,
                                onChanged: _handleFoggingRadioValueChange,
                              ),
                              Text(
                                "Time",
                                style: TextStyle(fontSize: 20.0),
                              ),
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Radio(
                                value: 3,
                                groupValue: _radioFoggingType,
                                onChanged: _handleFoggingRadioValueChange,
                              ),
                              Text(
                                "Humidity",
                                style: TextStyle(fontSize: 20.0),
                              ),
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Radio(
                                value: 2,
                                groupValue: _radioFoggingType,
                                onChanged: _handleFoggingRadioValueChange,
                              ),
                              Text(
                                "Temperature",
                                style: TextStyle(fontSize: 20.0),
                              ),
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                  /*Padding(
                    padding: paddingforText(),
                    child: Text("No. of Fogger Valves per Controller:  ",style: TextStyle(
                      color: Colors.black,
                      fontSize: 20.0,
                    ),),
                  ),
                  TextField(
                    style:TextStyle(
                      fontSize: 20.0,
                        color: Colors.black
                    ),
                    keyboardType: TextInputType.number,
                    controller: _maxFoggerController,
                    maxLength: 1,
                    onChanged: (str) {
                      setState(() {
                        _ensureTextControllsers(int.parse(_maxFoggerController.text));
                      });
                    },
                    decoration: new InputDecoration(
                      fillColor: Colors.black,
                      counterText: "",
                      border: OutlineInputBorder(),
                      //errorText: _NoOfSlavesController.text == null ?slaveValidate: "",
                    ),
                  ),*/
                ],
              ),
            ),
            _count > 0 && (_radioFoggingType == 1 || _radioFoggingType == 2 || _radioFoggingType == 3)
                ? ControllerDetailsPageFrame(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Column(
                          children: <Widget>[
                            Container(
                              //color: Colors.indigo,
                              decoration: ShapeDecoration(shape: StadiumBorder(), color: Colors.green),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Icon(
                                      Icons.info_outline,
                                      color: Colors.white,
                                    ),
                                    Flexible(
                                      child: Text(
                                        "Fogger Valve No. should be between $_minFValveNo to $_totalValves.",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 14.0,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            commonDivider(),
                            Row(
                              //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Expanded(
                                    flex: 2,
                                    child: Text(
                                      "Fogger Valve \n No.",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(fontSize: 18.0),
                                    )),
                                _radioFoggingType == 1
                                    ? Expanded(
                                        flex: 2,
                                        //width: 60.0,
                                        child: Text(
                                          "FoggerOn \n (Sec)",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(fontSize: 18.0),
                                        ))
                                    : SizedBox(
                                        width: 0.0,
                                      ),
                                _radioFoggingType == 2
                                    ? Expanded(
                                        flex: 2,
                                        child: Text(
                                          "Set Min Temp \n [°C]",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(fontSize: 18.0),
                                        ))
                                    : SizedBox(
                                        width: 0.0,
                                      ),
                                _radioFoggingType == 2
                                    ? Expanded(
                                        flex: 2,
                                        child: Text(
                                          "Set Max Temp \n [°C]",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(fontSize: 18.0),
                                        ))
                                    : SizedBox(
                                        width: 0.0,
                                      ),
                                _radioFoggingType == 3
                                    ? Expanded(
                                        flex: 2,
                                        child: Text(
                                          "Set Min Humidity \n [%]",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(fontSize: 18.0),
                                        ))
                                    : SizedBox(
                                        width: 0.0,
                                      ),
                                _radioFoggingType == 3
                                    ? Expanded(
                                        flex: 2,
                                        child: Text(
                                          "Set Max Humidity \n [%]",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(fontSize: 18.0),
                                        ))
                                    : SizedBox(
                                        width: 0.0,
                                      ),
                              ],
                            ),
                            SizedBox.fromSize(
                              size: Size(10.0, 10.0),
                            ),
                            Container(
                              height: 300.0,
                              decoration: BoxDecoration(
                                border: Border.all(width: 1.0, color: Colors.black),
                              ),
                              child: SingleChildScrollView(child: createFoggerList()),
                            ),
                            SizedBox.fromSize(
                              size: Size(10.0, 10.0),
                            ),
                            /* Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          IconButton(
                            onPressed: _onRemovePressed,
                            icon: Icon(Icons.remove)
                          ),
                          IconButton(
                            onPressed: _onAddPressed,
                            icon: Icon(Icons.add),
                          ),
                        ],
                      ),*/
                          ],
                        ),
                      ),
                    ),
                  )
                : SizedBox(
                    height: 0.0,
                  ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                RawMaterialButton(
                  onPressed: () {

                    if (_foggerDelayController.text.isEmpty || int.parse(_foggerDelayController.text) < 1) {
                      setState(() {
                        delayErrorMsg = true;
                      });
                    }else{
                      setState(() {
                        delayErrorMsg = false;
                      });
                    }

                    setState(() {
                      if (_foggerKey.currentState.validate() && delayErrorMsg == false) {
                        _loading = _handelFoggerDataSubmit().then((_) {
                          if (mounted) {
                            _oldmodelFogger != null ? showPositiveToast("Data is updated successfully") : showPositiveToast("Data is saved successfully");
                            //ControllerDetails.navigateToNext(context);
                            Navigator.of(context).popUntil((route) => route is ControllerDetailsMainRoute);
                          }
                        });
                      } else {
                        showColoredToast("Please check the values");
                      }
                    });
                  },
                  fillColor: Color.fromRGBO(0, 84, 179, 1.0),
                  splashColor: Colors.white,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15.0),
                    child: Text(
                      _oldmodelFogger != null ? "Update" : "Save",
                      style: TextStyle(color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.bold),
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
        ),
      ),
    );
  }

  Widget createFoggerList() {
    return Column(
      children: List.generate(_count, (index) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                flex: 2,
                child:CommonTextField(
                    _foggerValveNoController[index],
                      (val) {
                    if (validateEmpty(val)) {
                      return "";
                    } else if (int.parse(_foggerValveNoController[index].text) < _minFValveNo ||
                        int.parse(_foggerValveNoController[index].text) > _totalValves) {
                      return "";
                    }
                  },
                  TextAlign.center,
                ),

                /*TextFormField(
                  maxLength: 2,
                  validator: (val) {
                    if (_foggerValveNoController[index].text.isEmpty) {
                      return "";
                    } else if (int.parse(_foggerValveNoController[index].text) < _minFValveNo ||
                        int.parse(_foggerValveNoController[index].text) > _totalValves) {
                      return "";
                    }
                  },
                  decoration: InputDecoration(counterText: "", border: OutlineInputBorder()),
                  textAlign: TextAlign.center,
                  controller: _foggerValveNoController[index],
                  style: TextStyle(fontSize: 20.0, color: Colors.black),
                  keyboardType: TextInputType.number,
                ),*/
              ),
              SizedBox(
                width: 5.0,
              ),
              _radioFoggingType == 1
                  ? Expanded(
                      flex: 2,
                      child:CommonTextField(
                        _onSecontroller[index],
                            (val) {
                          if (validateEmpty(val)) {
                            return "";
                          }
                        },
                        TextAlign.center,
                      ),

                      /*TextFormField(
                        maxLength: 2,
                        validator: (val) {
                          if (_onSecontroller[index].text.isEmpty) {
                            return "";
                          }
                        },
                        decoration: InputDecoration(counterText: "", border: OutlineInputBorder()),
                        textAlign: TextAlign.center,
                        controller: _onSecontroller[index],
                        style: TextStyle(fontSize: 20.0, color: Colors.black),
                        keyboardType: TextInputType.number,
                      ),*/
                    )
                  : SizedBox(
                      width: 0.0,
                    ),
              SizedBox(
                width: 5.0,
              ),
              _radioFoggingType == 2
                  ? Expanded(
                      flex: 2,
                      child:CommonTextField(
                        _minTempController[index],
                            (val) {
                          if (validateEmpty(val)) {
                            return "";
                          }
                        },
                        TextAlign.center,
                        "°C",
                      ),


               /* TextFormField(
                        maxLength: 2,
                        validator: (val) {
                          if (_minTempController[index].text.isEmpty) {
                            return "";
                          }
                        },
                        decoration: InputDecoration(counterText: "", suffixText: "°C", border: OutlineInputBorder()),
                        textAlign: TextAlign.center,
                        controller: _minTempController[index],
                        style: TextStyle(fontSize: 20.0, color: Colors.black),
                        keyboardType: TextInputType.number,
                      ),*/
                    )
                  : SizedBox(
                      width: 0.0,
                    ),
              SizedBox(
                width: 5.0,
              ),
              _radioFoggingType == 2
                  ? Expanded(
                      flex: 2,
                      child:CommonTextField(
                        _maxTempController[index],
                            (val) {
                          if (validateEmpty(val)) {
                            return "";
                          }
                        },
                        TextAlign.center,
                        "°C",
                      ),


                /*TextFormField(
                        maxLength: 2,
                        validator: (val) {
                          if (_maxTempController[index].text.isEmpty) {
                            return "";
                          }
                        },
                        decoration: InputDecoration(counterText: "", suffixText: "°C", border: OutlineInputBorder()),
                        textAlign: TextAlign.center,
                        controller: _maxTempController[index],
                        style: TextStyle(fontSize: 20.0, color: Colors.black),
                        keyboardType: TextInputType.number,
                      ),*/
                    )
                  : SizedBox(
                      width: 0.0,
                    ),
              SizedBox(
                width: 5.0,
              ),
              _radioFoggingType == 3
                  ? Expanded(
                      flex: 2,
                      child:CommonTextField(
                        _minHumController[index],
                            (val) {
                          if (validateEmpty(val)) {
                            return "";
                          }
                        },
                        TextAlign.center,
                          "%"
                      ),
                      /*TextFormField(
                        maxLength: 2,
                        validator: (val) {
                          if (_minHumController[index].text.isEmpty) {
                            return "";
                          }
                        },
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(counterText: "", suffixText: "%", border: OutlineInputBorder()),
                        controller: _minHumController[index],
                        style: TextStyle(fontSize: 20.0, color: Colors.black),
                        keyboardType: TextInputType.number,
                      ),*/
                    )
                  : SizedBox(
                      width: 0.0,
                    ),
              SizedBox(
                width: 5.0,
              ),
              _radioFoggingType == 3
                  ? Expanded(
                      flex: 2,
                      child:CommonTextField(
                          _maxHumController[index],
                              (val) {
                            if (validateEmpty(val)) {
                              return "";
                            }
                          },
                          TextAlign.center,
                          "%"
                      ),

                /*TextFormField(
                        maxLength: 2,
                        validator: (val) {
                          if (_maxHumController[index].text.isEmpty) {
                            return "";
                          }
                        },
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(counterText: "", suffixText: "%", border: OutlineInputBorder()),
                        controller: _maxHumController[index],
                        style: TextStyle(fontSize: 20.0, color: Colors.black),
                        keyboardType: TextInputType.number,
                      ),*/
                    )
                  : SizedBox(
                      width: 0.0,
                    ),
            ],
          ),
        );
      }),
    );
  }
}
