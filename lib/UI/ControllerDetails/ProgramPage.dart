import 'package:autoaqua/Model/ProgramModel.dart';
import 'package:autoaqua/UI/ControllerDetails/ControllerDetails.dart';
import 'package:autoaqua/Utils/Database_Client.dart';
import 'package:autoaqua/Utils/CommonlyUserMethod.dart';
import 'package:flutter/material.dart';

class ProgramPage extends StatefulWidget {
  static Route<dynamic> route(int controllerId) {
    return ControllerDetailsPageRoute(
      pageId: ControllerDetailsPageId.PROGRAM,
      builder: (context) => ProgramPage(
            controllerId: controllerId,
          ),
    );
  }

  const ProgramPage({
    Key key,
    @required this.controllerId,
  }) : super(key: key);

  final int controllerId;

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
    print("THis is database table for Configuration ${dbh.getProgramItems}");

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
                          _ProgramOption.route(index, maxnumber, widget.controllerId),
                        ),
                  );
                },
              ));
  }
}

class _ProgramOption extends StatefulWidget {
  static Route<dynamic> route(int programIndex, int maxIndex, int controllerId) {
    return MaterialPageRoute(
      builder: (context) => _ProgramOption(
            programIndex: programIndex,
            maxIndex: maxIndex,
            controllerId: controllerId,
          ),
    );
  }

  const _ProgramOption({
    Key key,
    @required this.programIndex,
    @required this.maxIndex,
    @required this.controllerId,
  }) : super(key: key);

  final int programIndex;
  final int maxIndex;
  final int controllerId;

  @override
  _ProgramOptionState createState() => _ProgramOptionState();
}

class _ProgramOptionState extends State<_ProgramOption> {
  // state variable
  int _radioValueFlushType;
  int _radioValueIrrigation;
  int _radioValueFertilization;
  bool _valFlushMode = false;

  final TextEditingController _intervalController = new TextEditingController();
  final TextEditingController _flushOnControler = new TextEditingController();
  final TextEditingController _NoOfValves = new TextEditingController();

  ProgramModel _oldProgram;
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

  @override
  void initState() {
    super.initState();
    print("THis is database table for Configuration ${db.getProgramItems()}");
    print('This is controller id ${widget.controllerId}');
    print('This is list index ${widget.programIndex + 1}');
    _loading = db.getProgramData(widget.controllerId, widget.programIndex).then((config) {
      _oldProgram = config;
      print(config);
      if (config != null) {
        setState(() {
          //_radioValueforMode = config.program_mode != "null"?int.parse(config.program_mode):null;
          _NoOfValves.value = TextEditingValue(text: config.program_mode);
          _valFlushMode = config.program_flushMode == "true" ? true : false;
            _radioValueFlushType = config.program_flushtype != "null" ?int.parse(config.program_flushtype):null;
          _intervalController.value = TextEditingValue(text: config.program_interval);
          _flushOnControler.value = TextEditingValue(text: config.program_flushon);
          _radioValueIrrigation = config.program_irrigationtype != "null" ?int.parse(config.program_irrigationtype):null;
          _radioValueFertilization = config.program_fertilizationtype != "null"?int.parse(config.program_fertilizationtype):null;
        });
      }
    });
  }

  Future<void> _handelProgramDataSubmit() async {
    if (_oldProgram == null) {
      ProgramModel submitProgramData = new ProgramModel(
          widget.controllerId,
          _NoOfValves.text,
          _valFlushMode.toString(),
          _radioValueFlushType.toString(),
          _intervalController.text,
          _flushOnControler.text,
          _radioValueIrrigation.toString(),
          _radioValueFertilization.toString(),
          dateFormatted());
      print("saved");
      await db.saveProgramData(submitProgramData);
      await db.getProgramData(widget.controllerId, widget.programIndex);
    } else {
      ProgramModel submitProgramData = new ProgramModel(
        widget.controllerId,
        _NoOfValves.text,
        _valFlushMode.toString(),
        _radioValueFlushType.toString(),
        _intervalController.text,
        _flushOnControler.text,
        _radioValueIrrigation.toString(),
          _radioValueFertilization.toString(),
        dateFormatted(),
        _oldProgram.programID,
      );

      print("updated");
      await db.updateProgramData(submitProgramData);
      await db.getProgramData(widget.controllerId, widget.programIndex);
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
        case 1:
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

  paddingforText(){
    return const EdgeInsets.only(bottom: 8.0);
  }

  @override
  Widget build(BuildContext context) {
    return ControllerDetailsPageFrame(
      title: "Program No: ${widget.programIndex + 1}",
      child: FutureBuilder(
        future: _loading,
          builder: (BuildContext context, AsyncSnapshot snapshot){
              if(snapshot.connectionState == ConnectionState.done){
                return buildProgramContent(context);
              }else{
                CircularProgressIndicator();
              }
          })
    );
  }

  Widget buildProgramContent(BuildContext context){
    return ListView(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Flexible(
                    child: Padding(
                      padding: paddingforText(),
                      child: Text(
                        "No. of Valves to be operated together:",
                        style: TextStyle(fontSize: 20.0),
                      ),
                    ),
                  ),
                  SizedBox(width: 10.0,),
                  Container(
                    width: 30.0,
                    child: TextFormField(
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      controller: _NoOfValves,
                      style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.black
                      ),
                      maxLength: 1,
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Please enter the Max output";
                        }else if(int.parse(value) >  4){
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
                    child: Text(" (Max 4)"),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Divider(
                  height: 2.0,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "FILTER BACKFLUSH:",
                    style: TextStyle(fontSize: 20.0),
                  ),
                  Switch(value: _valFlushMode, onChanged: (bool e) => _handleFilterFlushModeChange(e)),
                ],
              ),

              _valFlushMode == true ?Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      new Radio(
                        value: 0,
                        groupValue: _radioValueFlushType,
                        onChanged: _handleFlushRadioValueChange,
                      ),
                      Expanded(child: Text("Once Before every Irrigation Program", style: TextStyle(fontSize: 20.0),)),
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
                      Text("Before Starting of Next Valve",style: TextStyle(fontSize: 20.0),),
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
                      Text("Interval",style: TextStyle(fontSize: 20.0),),
                      Text("Time",style: TextStyle(fontSize: 20.0),)
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 28.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Flexible(
                          //flex:5,
                          child: Row(
                            children: <Widget>[
                              Padding(
                                padding: paddingforText(),
                                child: Text("After ",
                                  style: TextStyle(
                                    fontSize: 20.0,
                                  ),),
                              ),
                              Flexible(
                                child: Container(
                                  width: 30.0,
                                  child: TextFormField(
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontSize: 20.0, color: Colors.black),
                                    maxLength: 2,
                                    decoration: InputDecoration(
                                        counterText: ""
                                    ),
                                    keyboardType: TextInputType.number,
                                    controller: _intervalController,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: paddingforText(),
                                child: Text(" Days",
                                  style: TextStyle(
                                    fontSize: 20.0,
                                  ),),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 40.0,),
                        Flexible(
                          //flex: 5,
                          child: Row(
                            children: <Widget>[
                              Padding(
                                padding: paddingforText(),
                                child: Text("For ",
                                  style: TextStyle(
                                    fontSize: 20.0,
                                  ),),
                              ),
                              Flexible(
                                child: Container(
                                  width: 30.0,
                                  child: TextFormField(
                                    maxLength: 2,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontSize: 20.0, color: Colors.black),
                                    decoration: InputDecoration(
                                      counterText: "",
                                    ),
                                    keyboardType: TextInputType.number,
                                    controller: _flushOnControler,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: paddingforText(),
                                child: Text(" mins",
                                  style: TextStyle(
                                    fontSize: 20.0,
                                  ),),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ):SizedBox(height: 0.0,),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Divider(
                  height: 1.0,
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Expanded(
                    flex: 5,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text(
                          "IRRIGATION",
                          style: TextStyle(fontSize: 20.0),
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Flexible(
                              flex:3,
                              child: Text(
                                "    Time based",
                                textAlign: TextAlign.end,
                                style: TextStyle(fontSize: 20.0),
                              ),
                            ),
                            Flexible(
                              flex: 1,
                              child: Radio(
                                value: 1,
                                groupValue: _radioValueIrrigation,
                                onChanged: _handleIrrigationValueChange,
                              ),),
                          ],
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Flexible(
                              flex:3,
                              child: Text(
                                "Volume based",
                                textAlign: TextAlign.end,
                                style: TextStyle(
                                  fontSize: 20.0,
                                ),
                              ),
                            ),
                            Flexible(
                              flex: 1,
                              child: Radio(
                                value: 0,
                                groupValue: _radioValueIrrigation,
                                onChanged: _handleIrrigationValueChange,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ) ,
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Container(
                        height: 110.0,
                        width: 1.0,
                        color: Colors.black,
                        margin: const EdgeInsets.only(right: 5.0),
                      ),
                    ],
                  ),
                  Expanded(
                    flex: 5,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Flexible(
                          flex: 5,
                          child: Text(
                            "FERTIGATION",
                            style: TextStyle(fontSize: 20.0),
                          ),
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Flexible(
                              flex: 1,
                              child: Radio(
                                value: 1,
                                groupValue: _radioValueFertilization,
                                onChanged: _handleFertilizationValueChange,
                              ),
                            ),
                            Flexible(
                              flex:3,
                              child: Text(
                                "Time based    ",
                                //textAlign: TextAlign.end,
                                style: TextStyle(
                                  fontSize: 20.0,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Flexible(
                              flex: 1,
                              child: Radio(
                                value: 0,
                                groupValue: _radioValueFertilization,
                                onChanged: _handleFertilizationValueChange,
                              ),
                            ),
                            Flexible(
                              flex: 3,
                              child: Text(
                                "Volume based",
                                textAlign: TextAlign.end,
                                style: TextStyle(
                                  fontSize: 20.0,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
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
                  RawMaterialButton(
                    textStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                    ),
                    onPressed: () {
                      _handelProgramDataSubmit();
                      final int nextIndex = widget.programIndex + 1;
                      if (nextIndex < widget.maxIndex) {
                        Navigator.of(context).pushReplacement(
                          _ProgramOption.route(nextIndex, widget.maxIndex, widget.controllerId),
                        );
                      } else {
                        ControllerDetails.navigateToPage(context, ControllerDetailsPageId.PROGRAM.nextPageId);
                      }
                    },
                    fillColor: Color.fromRGBO(0, 84, 179, 1.0),
                    splashColor: Colors.white,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15.0),
                      child: Text(
                        _oldProgram != null ? "Update" : "Save",
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
        ),
      ],
    );
  }
}
