import 'package:autoaqua/Model/ValvesModel.dart';
import 'package:autoaqua/UI/ControllerDetails/ControllerDetails.dart';
import 'package:autoaqua/Utils/Database_Client.dart';
import 'package:autoaqua/Utils/CommonlyUserMethod.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ValvesPage extends StatefulWidget {
  static Route<dynamic> route(int controllerId) {
    return ControllerDetailsPageRoute(
      pageId: ControllerDetailsPageId.VALVES,
      builder: (context) => ValvesPage(
            controllerId: controllerId,
          ),
    );
  }

  const ValvesPage({
    Key key,
    @required this.controllerId,
  }) : super(key: key);

  final int controllerId;

  @override
  _ValvesPageState createState() => _ValvesPageState();
}

class _ValvesPageState extends State<ValvesPage> {
  DataBaseHelper dbh = DataBaseHelper();
  Future _loading;
  var _maxProgramforValves = 0;

  @override
  void initState() {
    super.initState();
    print("THis is database table for Configuration ${dbh.getProgramItems}");

    _loading = dbh.getConfigDataForController(widget.controllerId).then((config) {
      //_oldConfig = config;
      if (config != null) {
        setState(() {
          _maxProgramforValves = int.parse(config.configMaxProg); //TextEditingValue(text: config.configMaxProg);
        });
      }
      print("MaxSequence is ${_maxProgramforValves}");
    });
  }

  @override
  Widget build(BuildContext context) {
    return _maxProgramforValves == null || _maxProgramforValves == 0
        ? Center(
            child: Text(
            "No program is added",
            style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
          ))
        : ControllerDetailsPageFrame(
            child: ListView.builder(
                itemCount: _maxProgramforValves,
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
                          _ValveOption.route(widget.controllerId, index, _maxProgramforValves, 0),
                        ),
                  );
                }),
          );
  }
}

class _ValveOption extends StatefulWidget {
  static Route<dynamic> route(int controllerId, int valveIndex, int maxIndex, int sequenceIndex) {
    return MaterialPageRoute(
      builder: (context) => _ValveOption(
            controllerId: controllerId,
            valveIndex: valveIndex,
            maxIndex: maxIndex,
            sequenceIndex: sequenceIndex,
          ),
    );
  }

  const _ValveOption({
    Key key,
    @required this.controllerId,
    @required this.valveIndex,
    @required this.maxIndex,
    @required this.sequenceIndex,
  }) : super(key: key);

  final int controllerId;
  final int valveIndex;
  final int maxIndex;
  final int sequenceIndex;

  @override
  _ValveOptionState createState() => _ValveOptionState();
}

class _ValveOptionState extends State<_ValveOption> {
  // state variable
  double _result = 0.0;
  final valvesFormKey = GlobalKey<FormState>();
  int _radioFertilizerProgrammingValue;
  DataBaseHelper dbh = DataBaseHelper();
  int noOfValves = 0;
  var integrationType;
  var fertlizationType;
  Future _loading;
  int _maxSequence = 9999999;
  int _maxTanks = 0;
  int _maxIrrigationValves = 0;
  String _showecPh;
  ValvesModel _oldValveModel;
  bool showValveErrorMsg = false;
  var _cropList = ['Wheat', 'Barley', 'Oat', 'RyeTriticale', 'Maize', 'Corn', 'Broomcorn'];
  List<String> _currentCropSlected;
  final _ctrl_FieldNo = <TextEditingController>[];
  final _ctrl_Tank = <TextEditingController>[];
  final _ctrl_ValveNo = <TextEditingController>[];
  final TextEditingController _ctrl_FertlizerDelay = new TextEditingController();
  final TextEditingController _postdelayController = new TextEditingController();
  final TextEditingController _ctrl_ECSetp = new TextEditingController();
  final TextEditingController _ctrl_PHSetp = new TextEditingController();

  void getDataToDisplay() {
     _loading =  dbh.getValvesData(widget.controllerId, widget.valveIndex, widget.sequenceIndex).then((valvesData) {
      _oldValveModel = valvesData;
      if (valvesData != null) {
        setState(() {
          _ctrl_ValveNo[0].value = TextEditingValue(text: valvesData.valves_VolveNo1);
          noOfValves > 1 ? _ctrl_ValveNo[1].value = TextEditingValue(text: valvesData.valves_VolveNo2) : null;
          noOfValves > 2 ? _ctrl_ValveNo[2].value = TextEditingValue(text: valvesData.valves_VolveNo3) : null;
          noOfValves > 3 ? _ctrl_ValveNo[3].value = TextEditingValue(text: valvesData.valves_VolveNo4) : null;
          _ctrl_FieldNo[0].value = TextEditingValue(text: valvesData.valves_fieldNo_1);
          noOfValves > 1 ? _ctrl_FieldNo[1].value = TextEditingValue(text: valvesData.valves_fieldNo_2) : null;
          noOfValves > 2 ? _ctrl_FieldNo[2].value = TextEditingValue(text: valvesData.valves_fieldNo_3) : null;
          noOfValves > 3 ? _ctrl_FieldNo[3].value = TextEditingValue(text: valvesData.valves_fieldNo_4) : null;

          _currentCropSlected[0] = valvesData.valves_field1_Crop;
          _currentCropSlected[1] = valvesData.valves_field2_Crop;
          _currentCropSlected[2] = valvesData.valves_field3_Crop;
          _currentCropSlected[3] = valvesData.valves_field4_Crop;
          _ctrl_Tank[0].value = TextEditingValue(text: valvesData.valves_tank_1);
          _maxTanks > 1 ? _ctrl_Tank[1].value = TextEditingValue(text: valvesData.valves_tank_2) : null;
          _maxTanks > 2 ? _ctrl_Tank[2].value = TextEditingValue(text: valvesData.valves_tank_3) : null;
          _maxTanks > 3 ? _ctrl_Tank[3].value = TextEditingValue(text: valvesData.valves_tank_4) : null;
          _radioFertilizerProgrammingValue = int.parse(valvesData.valves_FertlizerProgramming);
          _ctrl_FertlizerDelay.value = TextEditingValue(text: valvesData.valves_FertlizerDelay);
          _ctrl_ECSetp.value = TextEditingValue(text: valvesData.valves_ECSetp);
          _ctrl_PHSetp.value = TextEditingValue(text: valvesData.valves_PHSetp);
        });
      } else {
        return CircularProgressIndicator();
      }
    });
  }

  @override
  void initState() {
    super.initState();

    dbh.getConfigDataForController(widget.controllerId).then((maxSeq) {
      if (maxSeq != null) {
        setState(() {
          _maxIrrigationValves = int.parse(maxSeq.ConfigTotalIrrigationValves);
          _maxTanks = int.parse(maxSeq.configMaxInjector);
          _showecPh = maxSeq.configEcpHStatus;
        });
      }
    });

    _loading = dbh.getProgramData(widget.controllerId, widget.valveIndex).then((programData) {
      if (programData != null) {
        setState(() {
          noOfValves = programData.program_mode != "null" ? int.parse(programData.program_mode) : 0;
          integrationType = programData.program_irrigationtype;
          fertlizationType = programData.program_fertilizationtype;
        });
      }
    });

    _currentCropSlected = [];
    getDataToDisplay();
    /*_loading = dbh.getValvesData(widget.controllerId, widget.valveIndex, widget.sequenceIndex).then((valvesData) {
      _oldValveModel = valvesData;
      if (valvesData != null) {
        setState(() {
          getDataToDisplay();
          print("Valves  ${valvesData.valves_fieldNo_1}");
          // print("Valves Data for Shaid ${_ctrl_ValveNo[0]}");
          //_currentCropSlected.length = 4;
          // print("Fogger data is : $model");
          //_ctrl_FieldNo.length = noOfValves;
          _ctrl_ValveNo[0].value = TextEditingValue(text: valvesData.valves_VolveNo1);
          noOfValves > 1 ? _ctrl_ValveNo[1].value = TextEditingValue(text: valvesData.valves_VolveNo2) : null;
          noOfValves > 2 ? _ctrl_ValveNo[2].value = TextEditingValue(text: valvesData.valves_VolveNo3) : null;
          noOfValves > 3 ? _ctrl_ValveNo[3].value = TextEditingValue(text: valvesData.valves_VolveNo4) : null;
          _ctrl_FieldNo[0].value = TextEditingValue(text: valvesData.valves_fieldNo_1);
          noOfValves > 1 ? _ctrl_FieldNo[1].value = TextEditingValue(text: valvesData.valves_fieldNo_2) : null;
          noOfValves > 2 ? _ctrl_FieldNo[2].value = TextEditingValue(text: valvesData.valves_fieldNo_3) : null;
          noOfValves > 3 ? _ctrl_FieldNo[3].value = TextEditingValue(text: valvesData.valves_fieldNo_4) : null;

          _currentCropSlected[0] = valvesData.valves_field1_Crop;
          _currentCropSlected[1] = valvesData.valves_field2_Crop;
          _currentCropSlected[2] = valvesData.valves_field3_Crop;
          _currentCropSlected[3] = valvesData.valves_field4_Crop;
          _ctrl_Tank[0].value = TextEditingValue(text: valvesData.valves_tank_1);
          _maxTanks > 1 ? _ctrl_Tank[1].value = TextEditingValue(text: valvesData.valves_tank_2) : null;
          _maxTanks > 2 ? _ctrl_Tank[2].value = TextEditingValue(text: valvesData.valves_tank_3) : null;
          _maxTanks > 3 ? _ctrl_Tank[3].value = TextEditingValue(text: valvesData.valves_tank_4) : null;
          _radioFertilizerProgrammingValue = int.parse(valvesData.valves_FertlizerProgramming);
          _ctrl_FertlizerDelay.value = TextEditingValue(text: valvesData.valves_FertlizerDelay);
          _ctrl_ECSetp.value = TextEditingValue(text: valvesData.valves_ECSetp);
          _ctrl_PHSetp.value = TextEditingValue(text: valvesData.valves_PHSetp);*//*
        });
      }
    });*/
  }

  var _db = DataBaseHelper();
  Future<void> _handelValvesDataSubmit() async {
    if (_oldValveModel == null) {
      ValvesModel submitValvesData = new ValvesModel(
          widget.controllerId,
          widget.valveIndex,
          widget.sequenceIndex,
          integrationType == "0" ? "Ltr" : "Time",
          _ctrl_ValveNo[0].text,
          noOfValves > 1 ? _ctrl_ValveNo[1].text : null,
          noOfValves > 2 ? _ctrl_ValveNo[2].text : null,
          noOfValves > 3 ? _ctrl_ValveNo[3].text : null,
          _ctrl_FieldNo[0].text,
          noOfValves > 1 ? _ctrl_FieldNo[1].text : null,
          noOfValves > 2 ? _ctrl_FieldNo[2].text : null,
          noOfValves > 3 ? _ctrl_FieldNo[3].text : null,
          _currentCropSlected[0],
          noOfValves > 1 ? _currentCropSlected[1] : null,
          noOfValves > 2 ? _currentCropSlected[2] : null,
          noOfValves > 3 ? _currentCropSlected[3] : null,
          _ctrl_Tank[0].text,
          _maxTanks > 1 ? _ctrl_Tank[1].text : null,
          _maxTanks > 2 ? _ctrl_Tank[2].text : null,
          _maxTanks > 3 ? _ctrl_Tank[3].text : null,
          _radioFertilizerProgrammingValue.toString(),
          _ctrl_FertlizerDelay.text,
          _ctrl_ECSetp.text,
          _ctrl_PHSetp.text,
          dateFormatted());

      await _db.saveValvesData(submitValvesData);
      await _db.getValvesData(widget.controllerId, widget.valveIndex, widget.sequenceIndex);
    } else {
      ValvesModel updateValvesData = new ValvesModel(
          widget.controllerId,
          widget.valveIndex,
          widget.sequenceIndex,
          integrationType == "0" ? "Ltr" : "Time",
          _ctrl_ValveNo[0].text,
          noOfValves > 1 ? _ctrl_ValveNo[1].text : null,
          noOfValves > 2 ? _ctrl_ValveNo[2].text : null,
          noOfValves > 3 ? _ctrl_ValveNo[3].text : null,
          _ctrl_FieldNo[0].text,
          noOfValves > 1 ? _ctrl_FieldNo[1].text : null,
          noOfValves > 2 ? _ctrl_FieldNo[2].text : null,
          noOfValves > 3 ? _ctrl_FieldNo[3].text : null,
          _currentCropSlected[0],
          noOfValves > 1 ? _currentCropSlected[1] : null,
          noOfValves > 2 ? _currentCropSlected[2] : null,
          noOfValves > 3 ? _currentCropSlected[3] : null,
          _ctrl_Tank[0].text,
          _maxTanks > 1 ? _ctrl_Tank[1].text : null,
          _maxTanks > 2 ? _ctrl_Tank[2].text : null,
          _maxTanks > 3 ? _ctrl_Tank[3].text : null,
          _radioFertilizerProgrammingValue.toString(),
          _ctrl_FertlizerDelay.text,
          _ctrl_ECSetp.text,
          _ctrl_PHSetp.text,
          dateFormatted());

      await _db.updateValvesData(updateValvesData);
      await _db.getValvesData(widget.controllerId, widget.valveIndex, widget.sequenceIndex);
    }
  }

  void _handleRadioValueChange(int value) {
    setState(() {
      _radioFertilizerProgrammingValue = value;
    });
  }

  radioDecoration() {
    return ShapeDecoration(shape: StadiumBorder(), color: Color.fromRGBO(0, 84, 179, 1.0));
  }

  paddingforText() {
    return const EdgeInsets.only(bottom: 8.0);
  }

  @override
  Widget build(BuildContext context) {
    return ControllerDetailsPageFrame(title: "VALVES", child: buildValveContent(context));
  }

  Widget buildValveContent(BuildContext context) {
    return Form(
      key: valvesFormKey,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                    //color: Color.fromRGBO(0, 84, 179, 1.0),
                    decoration: radioDecoration(),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 8.0),
                      child: Text(
                        "Program No: ${widget.valveIndex + 1}",
                        style: TextStyle(color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Container(
                    //color: Color.fromRGBO(0, 84, 179, 1.0),
                    decoration: radioDecoration(),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 8.0),
                      child: Text(
                        "Seq No: ${widget.sequenceIndex + 1}",
                        style: TextStyle(color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.bold),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Divider(
                height: 1.0,
              ),
            ),
            //SizedBox(height: 10.0),
            Center(
              child: Text(
                "VALVE DETAILS",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
            ),
            integrationType == "0" || integrationType == "1"
                ? Column(
                    children: <Widget>[
                      Row(
                        //mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Expanded(
                            flex: 3,
                            child: Image.asset(
                              "Images/valve_1.png",
                              height: 50.0,
                              color: Color.fromRGBO(0, 84, 179, 1.0),
                              width: 50.0,
                            ),
                          ),
                          Expanded(
                              flex: 2,
                              child: SizedBox(
                                width: 0.0,
                              )),
                          Expanded(
                            flex: 5,
                            child: Center(
                              child: integrationType == "0"
                                  ? Image.asset(
                                      "Images/ltr.png",
                                      height: 50.0,
                                      color: Color.fromRGBO(0, 84, 179, 1.0),
                                      width: 50.0,
                                    )
                                  : integrationType == "1"
                                      ? Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Image.asset(
                                            "Images/minutes.png",
                                            height: 50.0,
                                            color: Color.fromRGBO(0, 84, 179, 1.0),
                                            width: 50.0,
                                          ),
                                        )
                                      : SizedBox(
                                          width: 0.0,
                                        ),
                            ),
                          )
                        ],
                      ),
                      listOfValve(),
                      Container(
                        //color: Colors.indigo,
                        decoration: ShapeDecoration(
                            shape: StadiumBorder(),
                            color: Colors.green
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Icon(Icons.info_outline,color: Colors.white,),
                            Flexible(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "Valve No. should be between 1 to $_maxIrrigationValves.",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15.0,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                : Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Please select the valve details in Program page",
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                  ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Divider(
                height: 1.0,
              ),
            ),
            //SizedBox(height: 30.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "FERTILIZER PROGRAMING",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(
              height: 10.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text(
                      "Sequential",
                      style: TextStyle(color: Colors.black, fontSize: 20.0),
                    ),
                    Radio(
                      value: 0,
                      //activeColor: Colors.white,
                      groupValue: _radioFertilizerProgrammingValue,
                      onChanged: _handleRadioValueChange,
                    ),
                  ],
                ),
                SizedBox(width: 20.0),
                Row(
                  children: <Widget>[
                    Radio(
                      value: 1,
                      //activeColor: Colors.white,
                      groupValue: _radioFertilizerProgrammingValue,
                      onChanged: _handleRadioValueChange,
                    ),
                    Text(
                      "Together",
                      style: TextStyle(color: Colors.black, fontSize: 20.0),
                    ),
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
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "PRE AND POST FERTLIZER DELAY",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(45.0, 0.0, 45.0, 0.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    flex: 4,
                    child: TextFormField(
                      maxLength: 3,
                      decoration: InputDecoration(counterText: "", hintText: "PRE", border: OutlineInputBorder()),
                      textAlign: TextAlign.center,
                      validator: (value) {
                        if (_ctrl_FertlizerDelay.text.isEmpty) {
                          return "Enter valid value";
                        }
                      },
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.black,
                      ),
                      controller: _ctrl_FertlizerDelay,
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 30.0),
                    child: integrationType == "0"
                        ? Image.asset(
                            "Images/ltr.png",
                            height: 50.0,
                            color: Color.fromRGBO(0, 84, 179, 1.0),
                            width: 50.0,
                          )
                        : integrationType == "1"
                            ? Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Image.asset(
                                  "Images/minutes.png",
                                  height: 50.0,
                                  color: Color.fromRGBO(0, 84, 179, 1.0),
                                  width: 50.0,
                                ),
                              )
                            : SizedBox(
                                width: 0.0,
                              ),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Expanded(
                    flex: 4,
                    child: TextFormField(
                      maxLength: 3,
                      controller: _postdelayController,
                      decoration: InputDecoration(counterText: "", hintText: "POST", border: OutlineInputBorder()),
                      textAlign: TextAlign.center,
                      validator: (value) {
                        if (_postdelayController.text.isEmpty) {
                          return "Enter valid value";
                        }
                      },
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.black,
                      ),
                      //controller: _ctrl_FertlizerDelay,
                      keyboardType: TextInputType.number,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Divider(
                height: 1.0,
              ),
            ),
            Center(
              child: Text(
                "FERTILIZER TANK",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
            ),
            fertlizationType == "0" || fertlizationType == "1"
                ? Column(
                    children: <Widget>[
                      Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Expanded(
                            flex: 4,
                            child: Center(
                              child: Image.asset(
                                "Images/tankicon.png",
                                height: 50.0,
                                color: Color.fromRGBO(0, 84, 179, 1.0),
                                width: 50.0,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 6,
                            child: Center(
                              child: fertlizationType == "0"
                                  ? Image.asset(
                                      "Images/ltr.png",
                                      height: 50.0,
                                      color: Color.fromRGBO(0, 84, 179, 1.0),
                                      width: 50.0,
                                    )
                                  : fertlizationType == "1"
                                      ? Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Image.asset(
                                            "Images/minutes.png",
                                            height: 50.0,
                                            color: Color.fromRGBO(0, 84, 179, 1.0),
                                            width: 50.0,
                                          ),
                                        )
                                      : SizedBox(
                                          width: 0.0,
                                        ),
                            ),
                          )
                        ],
                      ),
                      listOfTanks(),
                    ],
                  )
                : Center(
                    child: Text(
                    "Please select the tank details in Program Page",
                    style: TextStyle(color: Colors.red),
                  )),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Divider(
                height: 1.0,
              ),
            ),
            _showecPh == "true"
                ? Column(
                    children: <Widget>[
                      Text(
                        "SET EC AND pH VALUES",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          //mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Expanded(
                              flex: 5,
                              child: TextFormField(
                                maxLength: 5,
                                textAlign: TextAlign.center,
                                validator: (value) {
                                  if (_ctrl_ECSetp.text.isEmpty) {
                                    return "Enter valid value";
                                  }
                                },
                                style: TextStyle(
                                  fontSize: 20.0,
                                  color: Colors.black,
                                ),
                                decoration: InputDecoration(
                                    hintText: 'EC', suffixText: "mS/Cm", counterText: "", border: OutlineInputBorder()),
                                keyboardType: TextInputType.number,
                                controller: _ctrl_ECSetp,
                              ),
                            ),
                            SizedBox(
                              width: 10.0,
                            ),
                            Expanded(
                              flex: 5,
                              child: TextFormField(
                                maxLength: 5,
                                textAlign: TextAlign.center,
                                validator: (value) {
                                  if (_ctrl_PHSetp.text.isEmpty) {
                                    return "Enter valid value";
                                  }
                                },
                                style: TextStyle(
                                  fontSize: 20.0,
                                  color: Colors.black,
                                ),
                                decoration: InputDecoration(
                                    hintText: 'pH', suffixText: "pH", counterText: "", border: OutlineInputBorder()),
                                keyboardType: TextInputType.number,
                                controller: _ctrl_PHSetp,
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  )
                : SizedBox(
                    height: 0.0,
                  ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                RawMaterialButton(
                    child: Text(
                      "Back",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0,
                      ),
                    ),
                    shape: const StadiumBorder(),
                    fillColor: Color.fromRGBO(0, 84, 179, 1.0),
                    onPressed: () {
                      if (widget.sequenceIndex < 1) {
                        Navigator.of(context).pop();
                      } else {
                        Navigator.of(context).pushReplacement(
                          _ValveOption.route(
                            widget.controllerId,
                            widget.valveIndex,
                            widget.maxIndex,
                            widget.sequenceIndex - 1,
                          ),
                        );
                      }
                    }),
                RawMaterialButton(
                    child: Text(
                      "Update",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0,
                      ),
                    ),
                    shape: const StadiumBorder(),
                    fillColor: Color.fromRGBO(0, 84, 179, 1.0),
                    onPressed: () {
                      _handelValvesDataSubmit();
                      Navigator.of(context).pop();
                    }),
                RawMaterialButton(
                  onPressed: () {
                    setState(() {
                      if (valvesFormKey.currentState.validate()) {
                        showValveErrorMsg = false;
                        _loading = _handelValvesDataSubmit().then((_) {
                          if (mounted) {
                            if (widget.sequenceIndex < _maxSequence - 1) {
                              Navigator.of(context).pushReplacement(
                                _ValveOption.route(
                                  widget.controllerId,
                                  widget.valveIndex,
                                  widget.maxIndex,
                                  widget.sequenceIndex + 1,
                                ),
                              );
                            } else {
                              int nextIndex = widget.valveIndex + 1;
                              if (nextIndex < widget.maxIndex) {
                                Navigator.of(context).pushReplacement(
                                  _ValveOption.route(
                                    widget.controllerId,
                                    nextIndex,
                                    widget.maxIndex,
                                    0,
                                  ),
                                );
                              } else {
                                ControllerDetails.navigateToPage(context, ControllerDetailsPageId.VALVES.nextPageId);
                              }
                            }
                          }
                        });
                      } else {
                        for (int i = 0; i < int.parse(noOfValves.toString()); i++) {
                          if (int.parse(_ctrl_ValveNo[i].text) > _maxIrrigationValves) {
                            setState(() {
                              showValveErrorMsg = true;
                            });
                          } else {
                            setState(() {
                              showValveErrorMsg = false;
                            });
                          }
                        }
                      }
                    });
                  },
                  fillColor: Color.fromRGBO(0, 84, 179, 1.0),
                  splashColor: Colors.white,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15.0),
                    child: Text(
                      _oldValveModel != null ? "Next" : "Next",
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20.0),
                    ),
                  ),
                  shape: const StadiumBorder(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  //Method to generate the No. of Valves
  void _updateValvesCount() {
    setState(() {
      _ctrl_FieldNo.length = 4;
      _currentCropSlected.length = 4;
      _ctrl_ValveNo.length = 4;
      for (int i = 0; i < 4; i++) {
        _ctrl_FieldNo[i] ??= TextEditingController();
        _ctrl_ValveNo[i] ??= TextEditingController();
      }
    });
  }

  Widget listOfValve() {
    _updateValvesCount();
    if (noOfValves != 0) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(noOfValves, (index) {
          return Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(12.0, 0.0, 12.0, 0.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      flex: 3,
                      child: Padding(
                          padding: const EdgeInsets.only(bottom: 15.0),
                          child: Center(
                            child: Text(
                              "Valve No.",
                              style: TextStyle(fontSize: 20.0),
                            ),
                          )),
                    ),
                    Expanded(
                      flex: 2,
                      child: TextFormField(
                        maxLength: 2,
                        decoration: InputDecoration(counterText: "", border: OutlineInputBorder()),
                        controller: _ctrl_ValveNo[index],
                        textAlign: TextAlign.center,
                        validator: (value) {
                          if (int.parse(_ctrl_ValveNo[index].text) > _maxIrrigationValves) {
                            return "";
                          }
                        },
                        style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.black,
                        ),
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    SizedBox(
                      width: 20.0,
                    ),
                    Expanded(
                      flex: 5,
                      child: TextFormField(
                        maxLength: integrationType == "0" ? 6 : integrationType == "1" ? 3 : null,
                        decoration: InputDecoration(
                          counterText: "",
                          border: OutlineInputBorder(),
                          suffixText: integrationType == "0" ? " Ltr" : integrationType == "1" ? " Mins" : " ",
                        ),
                        textAlign: TextAlign.center,
                        validator: (value) {
                          if (_ctrl_FieldNo[index].text.isEmpty) {
                            return "Enter valid value";
                          }
                        },
                        style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.black,
                        ),
                        controller: _ctrl_FieldNo[index],
                        keyboardType: TextInputType.number,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        }),
      );
    } else {
      Text("There is no valves");
    }
  }

  //Method to generate tanks
  void _updateTankControllerCount() {
    setState(() {
      _ctrl_Tank.length = _maxTanks;
      for (int i = 0; i < _ctrl_Tank.length; i++) {
        if (_ctrl_Tank[i] == null) {
          _ctrl_Tank[i] = TextEditingController();
        }
      }
    });
  }

  Widget listOfTanks() {
    _updateTankControllerCount();
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(_maxTanks, (index) {
        return Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                //mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Expanded(
                    flex: 4,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: Text("Tank ${index + 1}", textAlign: TextAlign.center, style: TextStyle(fontSize: 20.0)),
                    ),
                  ),
                  Expanded(
                    flex: 6,
                    child: TextFormField(
                      maxLength: fertlizationType == "0" ? 6 : 3,
                      decoration: InputDecoration(
                        counterText: "",
                        border: OutlineInputBorder(),
                        suffixText: fertlizationType == "0" ? " Ltr" : fertlizationType == "1" ? " Mins" : " ",
                      ),
                      textAlign: TextAlign.center,
                      validator: (value) {
                        if (_ctrl_Tank[index].text.isEmpty) {
                          return "Enter valid value";
                        }
                      },
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.black,
                      ),
                      controller: _ctrl_Tank[index],
                      keyboardType: TextInputType.number,
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      }),
    );
  }
}
