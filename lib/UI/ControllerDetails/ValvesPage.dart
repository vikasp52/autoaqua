import 'package:autoaqua/Model/ValvesModel.dart';
import 'package:autoaqua/UI/ControllerDetails/ControllerDetails.dart';
import 'package:autoaqua/Utils/Database_Client.dart';
import 'package:autoaqua/Utils/DateFormatter.dart';
import 'package:flutter/material.dart';

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
  int _radioFertilizerProgrammingValue = 0;
  DataBaseHelper dbh = DataBaseHelper();
  int noOfValves = 0;
  var integrationType;
  var fertlizationType;
  Future _loading;
  int _maxSequence = 0;
  ValvesModel _oldValveModel;
  //ConfigurationModel _oldConfig;
  var _cropList = ['Wheat', 'Barley', 'Oat', 'RyeTriticale', 'Maize', 'Corn', 'Broomcorn'];
  List<String> _currentCropSlected;
  final _ctrl_FieldNo = <TextEditingController>[];
  final _ctrl_Tank = <TextEditingController>[];
  final _ctrl_ValveNo = <TextEditingController>[];
  final TextEditingController _ctrl_FertlizerDelay = new TextEditingController();
  final TextEditingController _ctrl_ECSetp = new TextEditingController();
  final TextEditingController _ctrl_PHSetp = new TextEditingController();

  @override
  void initState() {
    super.initState();

    dbh.getConfigDataForController(widget.controllerId).then((maxSeq) {
      if (maxSeq != null) {
        setState(() {
          _maxSequence = int.parse(maxSeq.configMaxOutput);
        });
      }
    });

    _loading = dbh.getProgramData(widget.controllerId, widget.valveIndex).then((programData) {
      if (programData != null) {
        setState(() {
          noOfValves = programData.program_mode != "null" ? int.parse(programData.program_mode):0;
          integrationType = programData.program_irrigationtype;
          fertlizationType = programData.program_fertilizationtype;
          print("Data from db ${programData.program_irrigationtype}");
        });
      }
      print('integrationType is $integrationType');
      print('fertlizationType is $fertlizationType');
      print(integrationType == "0");
    });

    _currentCropSlected = [];
    print("Valve index ${widget.controllerId}");
    print("Valve index ${widget.valveIndex}");
    print("seq index ${widget.sequenceIndex}");
    //print("THis is database table for Configuration ${dbh.getProgramItems}");

    _loading = dbh.getValvesData(widget.controllerId, widget.valveIndex, widget.sequenceIndex).then((valvesData) {
      _oldValveModel = valvesData;

      print("Valve index ${widget.controllerId}");
      print("Valve index ${widget.valveIndex}");
      print("seq index ${widget.sequenceIndex}");
      if (valvesData != null) {
        setState(() {
          print("Valves Data for Shaid ${valvesData.valves_fieldNo_1}");
          print("Valves Data for Shaid ${_ctrl_Tank[0]}");
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
          _ctrl_Tank[1].value = TextEditingValue(text: valvesData.valves_tank_2);
          _ctrl_Tank[2].value = TextEditingValue(text: valvesData.valves_tank_3);
          _ctrl_Tank[3].value = TextEditingValue(text: valvesData.valves_tank_4);
          _radioFertilizerProgrammingValue = int.parse(valvesData.valves_FertlizerProgramming);
          _ctrl_FertlizerDelay.value = TextEditingValue(text: valvesData.valves_FertlizerDelay);
          _ctrl_ECSetp.value = TextEditingValue(text: valvesData.valves_ECSetp);
          _ctrl_PHSetp.value = TextEditingValue(text: valvesData.valves_PHSetp);
        });
      }
    });
  }

  var _db = DataBaseHelper();
  void _handelValvesDataSubmit() async {
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
          _ctrl_Tank[1].text,
          _ctrl_Tank[2].text,
          _ctrl_Tank[3].text,
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
          _ctrl_Tank[1].text,
          _ctrl_Tank[2].text,
          _ctrl_Tank[3].text,
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

  @override
  Widget build(BuildContext context) {
    return ControllerDetailsPageFrame(
      title: "VALVES",
      child: SingleChildScrollView(
        //padding: EdgeInsets.all(20.0),
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
                    decoration: ShapeDecoration(shape: StadiumBorder(), color: Color.fromRGBO(0, 84, 179, 1.0)),
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
                    decoration: ShapeDecoration(shape: StadiumBorder(), color: Color.fromRGBO(0, 84, 179, 1.0)),
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Valves Details",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Image.asset(
                  "Images/valve_1.png",
                  height: 50.0,
                  width: 50.0,
                ),
                Image.asset(
                  "Images/crops.png",
                  height: 50.0,
                  width: 50.0,
                ),
                integrationType == "0"
                    ? Image.asset(
                        "Images/ltr.png",
                        height: 50.0,
                        width: 50.0,
                      ):
                integrationType == "1"
                    ? Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset(
                          "Images/minutes.png",
                          height: 50.0,
                          width: 50.0,
                        ),
                      ):SizedBox(width: 0.0,)
              ],
            ),
            SizedBox(
              height: 10.0,
            ),
            Container(
              child: listOfValve(),
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
                  "Fertilizer Programming",
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
                Container(
                  decoration: _radioFertilizerProgrammingValue == 0
                      ? ShapeDecoration(shape: StadiumBorder(), color: Color.fromRGBO(0, 84, 179, 1.0))
                      : null,
                  //color: Colors.blueAccent,
                  child: Row(
                    children: <Widget>[
                      Radio(
                        value: 0,
                        activeColor: Colors.white,
                        groupValue: _radioFertilizerProgrammingValue,
                        onChanged: _handleRadioValueChange,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Sequential",
                          style: TextStyle(color: _radioFertilizerProgrammingValue == 0 ? Colors.white : Colors.black),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 20.0),
                Container(
                  decoration: _radioFertilizerProgrammingValue == 1
                      ? ShapeDecoration(shape: StadiumBorder(), color: Color.fromRGBO(0, 84, 179, 1.0))
                      : null,
                  //color: Colors.blueAccent,
                  child: Row(
                    children: <Widget>[
                      Radio(
                        value: 1,
                        activeColor: Colors.white,
                        groupValue: _radioFertilizerProgrammingValue,
                        onChanged: _handleRadioValueChange,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Together",
                          style: TextStyle(color: _radioFertilizerProgrammingValue == 1 ? Colors.white : Colors.black),
                        ),
                      ),
                    ],
                  ),
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
                  "Pre and Post Fertlizer Delay",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(100.0, 0.0, 100.0, 0.0),
              child: TextFormField(
                decoration: InputDecoration(
                  suffixIcon: integrationType == "0"
                      ? Image.asset(
                          "Images/ltr.png",
                          height: 20.0,
                          width: 20.0,
                        ):
                  integrationType == "1"?
                      Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.asset(
                            "Images/minutes.png",
                            height: 20.0,
                            width: 20.0,
                          ),
                        ):SizedBox(width: 0.0,),
                ),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15.0,
                  color: Colors.black,
                ),
                controller: _ctrl_FertlizerDelay,
                keyboardType: TextInputType.number,
              ),
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
                Image.asset(
                  "Images/tankicon.png",
                  height: 50.0,
                  width: 50.0,
                ),
                //SizedBox(width: 90.0,),
                fertlizationType == "0"
                    ? Image.asset(
                        "Images/ltr.png",
                        height: 50.0,
                        width: 50.0,
                      ):
                fertlizationType == "1"
                    ? Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset(
                          "Images/minutes.png",
                          height: 50.0,
                          width: 50.0,
                        ),
                      ):SizedBox(width: 0.0,)
              ],
            ),
            listOfTanks(),
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
                  "Set EC and pH Values",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Container(
                      width: 100.0,
                      child: TextFormField(
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 15.0,
                          color: Colors.black,
                        ),
                        decoration: InputDecoration(
                          hintText: '01.65 mS/cm',
                        ),
                        keyboardType: TextInputType.number,
                        controller: _ctrl_ECSetp,
                      ),
                    ),
                    Text("EC Values")
                  ],
                ),
                Column(
                  children: <Widget>[
                    Container(
                      width: 100.0,
                      child: TextFormField(
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 15.0,
                          color: Colors.black,
                        ),
                        decoration: InputDecoration(
                          hintText: '06.50 pH',
                        ),
                        keyboardType: TextInputType.number,
                        controller: _ctrl_PHSetp,
                      ),
                    ),
                    Text("pH Values")
                  ],
                )
              ],
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                RawMaterialButton(
                  onPressed: () {
                    _handelValvesDataSubmit();
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
                  },
                  fillColor: Colors.indigo,
                  splashColor: Colors.white,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15.0),
                    child: Text(
                      _oldValveModel != null ? "Update & Next" : "Save & Next",
                      style: TextStyle(color: Colors.white),
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
                padding: const EdgeInsets.fromLTRB(12.0,0.0,12.0,0.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: TextFormField(
                        decoration: InputDecoration(hintText: "No."),
                        controller: _ctrl_ValveNo[index],
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.black,
                        ),
                        //controller: _ctrl_FieldNo[index],
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          hint: Text("Select Crop"),
                          iconSize: 40.0,
                          items: _cropList.map((String dropDownMenuItem) {
                            return DropdownMenuItem<String>(
                              value: dropDownMenuItem,
                              child: SingleChildScrollView(child: Text(dropDownMenuItem)),
                            );
                          }).toList(),
                          onChanged: (String newValueSelected) {
                            setState(() {
                              _currentCropSlected[index] = newValueSelected;
                            });
                          },
                          value: _currentCropSlected[index],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: TextFormField(
                        decoration: InputDecoration(suffixText: integrationType == "0" ? "Ltr" : "Mins"),
                        textAlign: TextAlign.center,
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
              SizedBox(
                height: 10.0,
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
      _ctrl_Tank.length = 4;
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
      children: List.generate(4, (index) {
        return Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Text("Tank ${index + 1}", textAlign: TextAlign.center, style: TextStyle(fontSize: 20.0)),
                Column(
                  children: <Widget>[
                    Container(
                      width: 90.0,
                      child: TextFormField(
                        decoration: InputDecoration(suffixText: fertlizationType == "0" ? "Ltr" :fertlizationType == "1"? "Mins":" "),
                        textAlign: TextAlign.center,
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
              ],
            ),
            SizedBox(
              height: 10.0,
            )
          ],
        );
      }),
    );
  }
}
