import 'package:autoaqua/Model/ConfigurationModel.dart';
import 'package:autoaqua/Model/FoggerModel.dart';
import 'package:autoaqua/UI/ControllerDetails/ControllerDetails.dart';
import 'package:autoaqua/Utils/Database_Client.dart';
import 'package:autoaqua/Utils/CommonlyUserMethod.dart';
import 'package:flutter/material.dart';

class FoggerPage extends StatefulWidget {
  static Route<dynamic> route(int controllerId) {
    return ControllerDetailsPageRoute(
      pageId: ControllerDetailsPageId.FOGGER,
      builder: (context) => FoggerPage(
            controllerId: controllerId,
          ),
    );
  }

  const FoggerPage({
    Key key,
    @required this.controllerId,
  }) : super(key: key);

  final int controllerId;

  @override
  _FoggerPageState createState() => _FoggerPageState();
}

class _FoggerPageState extends State<FoggerPage> {
  final _FieldController = <TextEditingController>[];
  final _onSecontroller = <TextEditingController>[];
  final _tempDegreeController = <TextEditingController>[];
  final _humController = <TextEditingController>[];
  final _maxFoggerController = TextEditingController();
  final _foggerDelayController = TextEditingController();

  List<FoggerModel> _oldmodelFogger;
  Future _loading;
  int _count = 0;
  var db = new DataBaseHelper();
  ConfigurationModel configurationModel;

  @override
  void initState() {
    super.initState();
    print("THis is database table for Configuration ${db.getConfigItems()}");

    _loading = db.getFoggerData(widget.controllerId).then((foggerdetails) {
      _oldmodelFogger = foggerdetails;
      if (foggerdetails != null) {
        setState(() {
          _ensureTextControllsers(foggerdetails.length);
          for (int i = 0; i < foggerdetails.length; i++) {
            final model = foggerdetails[i];
            print("Fogger data is : $foggerdetails[]");
            _FieldController[i].text = model.fogger_Field;
            _onSecontroller[i].text = model.fogger_onSec;
            _tempDegreeController[i].text = model.fogger_tempDegree;
            _humController[i].text = model.fogger_hum;
            _maxFoggerController.value = TextEditingValue(text: model.fogger_maxRTU);
            _foggerDelayController.value = TextEditingValue(text: model.fogger_foggerDelay);
          }
        });
      }
    });
  }

  void _ensureTextControllsers(int count) {
    _count = count;
    _FieldController.length = count;
    _onSecontroller.length = count;
    _tempDegreeController.length = count;
    _humController.length = count;
    for (int i = 0; i < count; i++) {
      _FieldController[i] ??= TextEditingController();
      _onSecontroller[i] ??= TextEditingController();
      _tempDegreeController[i] ??= TextEditingController();
      _humController[i] ??= TextEditingController();
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


      ConfigurationModel newFoggerConfig = new ConfigurationModel.fogger(
          _maxFoggerController.text,
          _foggerDelayController.text,
          "UPDATED123"
      );
      int saveItemId = await db.updateConfigurationItemsforFogger(newFoggerConfig);
      print('Updated Config Fogger Item: $saveItemId');

    for (int i = 0; i < _count; i++) {
      final model = FoggerModel(
        widget.controllerId,
        _maxFoggerController.text,
        _foggerDelayController.text,
        _FieldController[i].text,
        _onSecontroller[i].text,
        _tempDegreeController[i].text,
        _humController[i].text,
        dateFormatted(),
        "${AppendZero(_maxFoggerController.text) + AppendZero(_foggerDelayController.text)}"
      );
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
  paddingforText(){
    return const EdgeInsets.only(bottom: 12.0);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: paddingforText(),
                      child: Text("Maximum Fogger:  ",style: TextStyle(
                        color: Colors.black,
                        fontSize: 20.0,
                      ),),
                    ),
                    Container(
                      width: 40.0,
                      child: TextField(
                        textAlign: TextAlign.center,
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
                          counterText: ""
                          //errorText: _NoOfSlavesController.text == null ?slaveValidate: "",
                        ),
                      ),
                    ),
                  ],
                ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: paddingforText(),
                  child: Text("       Fogger Delay:  ",style: TextStyle(
                    color: Colors.black,
                    fontSize: 20.0,
                  ),),
                ),
                Container(
                  width: 40.0,
                  child: TextField(
                      textAlign: TextAlign.center,
                      style:TextStyle(
                        fontSize: 20.0,
                        color: Colors.black
                      ),
                    keyboardType: TextInputType.number,
                    controller: _foggerDelayController,
                    maxLength: 2,
                    decoration: new InputDecoration(
                      fillColor: Colors.black,
                      counterText: ""
                      //errorText: _NoOfSlavesController.text == null ?slaveValidate: "",
                    )),
                ),
              ],
            )
              ],
            ),
          ),
          _count > 0 ?ControllerDetailsPageFrame(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                            //width: 60.0,
                            child: Text(
                          "Fogger \n Valves \n No.",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 15.0),
                        )),
                        Container(
                            //width: 60.0,
                            child: Text(
                          "FoggerOn \n (Sec)",
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 15.0),
                        )),
                        Container(
                            //width: 60.0,
                            child: Text(
                          "Set \n Temp \n [°C]",
                              textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 15.0),
                        )),
                        Container(
                            // width: 60.0,
                            child: Text(
                          "Set \n Humedity \n [%]",
                              textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 15.0),
                        )),
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
          ):SizedBox(height: 0.0,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              RawMaterialButton(
                onPressed: () {
                  _handelFoggerDataSubmit();
                  ControllerDetails.navigateToNext(context);
                },
                fillColor: Color.fromRGBO(0, 84, 179, 1.0),
                splashColor: Colors.white,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.0),
                  child: Text(
                    _oldmodelFogger != null ? "Update" : "Save",
                    style: TextStyle(color: Colors.white,fontSize: 20.0,fontWeight: FontWeight.bold),
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
    );
  }

  Widget createFoggerList() {
    return Column(
      children: List.generate(_count, (index) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              width: 60.0,
              child: TextFormField(
                maxLength: 2,
                decoration: InputDecoration(
                    counterText: ""
                ),
                textAlign: TextAlign.center,
                controller: _FieldController[index],
                style: TextStyle(fontSize: 20.0, color: Colors.black),
                keyboardType: TextInputType.number,
              ),
            ),
            Container(
              width: 60.0,
              child: TextFormField(
                maxLength: 2,
                decoration: InputDecoration(
                    counterText: ""
                ),
                textAlign: TextAlign.center,
                controller: _onSecontroller[index],
                style: TextStyle(fontSize: 20.0, color: Colors.black),
                keyboardType: TextInputType.number,
              ),
            ),
            Container(
              width: 60.0,
              child: TextFormField(
                maxLength: 2,
                decoration: InputDecoration(
                    counterText: ""
                ),
                textAlign: TextAlign.center,
                controller: _tempDegreeController[index],
                style: TextStyle(fontSize: 20.0, color: Colors.black),
                keyboardType: TextInputType.number,
              ),
            ),
            Container(
              width: 60.0,
              child: TextFormField(
                maxLength: 2,
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  counterText: ""
                ),
                controller: _humController[index],
                style: TextStyle(fontSize: 20.0, color: Colors.black),
                keyboardType: TextInputType.number,
              ),
            ),
          ],
        );
      }),
    );
  }
}
