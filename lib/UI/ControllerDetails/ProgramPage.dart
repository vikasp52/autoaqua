import 'package:autoaqua/Model/ConfigurationModel.dart';
import 'package:autoaqua/Model/ProgramModel.dart';
import 'package:autoaqua/UI/ControllerDetails/ControllerDetails.dart';
import 'package:autoaqua/UI/ControllerDetails/ValvesPage.dart';
import 'package:autoaqua/Utils/Database_Client.dart';
import 'package:autoaqua/Utils/DateFormatter.dart';
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
      if(config != null) {
        setState(() {
          maxnumber = int.parse(config.configMaxProg); //TextEditingValue(text: config.configMaxProg);
        });
        }
        print("Max program no is ${maxnumber}");
    });
  }

  @override
  Widget build(BuildContext context) {
    return ControllerDetailsPageFrame(
      child: ListView.builder(
          itemCount: maxnumber,
          itemBuilder: (BuildContext context, int index){
            return ListTile(
              title: Card(
                  color: Colors.lightBlueAccent.shade100,
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text("PROGRAM ${index+1}", style: TextStyle(
                        //fontWeight: FontWeight.bold,
                        fontSize: 20.0
                    ),),
                  )
              ),
              onTap: () => Navigator.of(context).push(
                _ProgramOption.route(index, maxnumber, widget.controllerId),
              ),
            );
          },
      ),
    );
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
  int _radioValueforMode;
  int _radioValueFlushType;
  int _radioValueIntegration;

  final TextEditingController _intervalController =
  new TextEditingController();
  final TextEditingController _flushOnControler=
  new TextEditingController();

  ProgramModel _oldProgram;
  Future _loading;
  var db = new DataBaseHelper();

  @override
  void initState() {
    super.initState();
    print("THis is database table for Configuration ${db.getProgramItems()}");
    print('This is controller id ${widget.controllerId}');
    print('This is list index ${widget.programIndex+1}');
    _loading = db.getProgramData(widget.controllerId, widget.programIndex).then((config) {
      _oldProgram = config;
      print(config);
      if(config != null) {
        setState(() {
          _radioValueforMode = int.parse(config.program_mode);
          _radioValueFlushType = int.parse(config.program_flushtype);
          _intervalController.value = TextEditingValue(text: config.program_interval);
          _flushOnControler.value = TextEditingValue(text: config.program_flushon);
          _radioValueIntegration = int.parse(config.program_integrationtype);
        });
        }
    });
  }

  Future<void > _handelProgramDataSubmit() async{

    if(_oldProgram == null){
      ProgramModel submitProgramData = new ProgramModel(
          widget.controllerId,
          _radioValueforMode.toString(),
          _radioValueFlushType.toString(),
          _intervalController.text,
          _flushOnControler.text,
          _radioValueIntegration.toString(),
          dateFormatted());
      print("saved");
      await db.saveProgramData(submitProgramData);
      await db.getProgramData(widget.controllerId, widget.programIndex);
    }else{
      ProgramModel submitProgramData = new ProgramModel(
          widget.controllerId,
          _radioValueforMode.toString(),
          _radioValueFlushType.toString(),
          _intervalController.text,
          _flushOnControler.text,
          _radioValueIntegration.toString(),
          dateFormatted(),
          _oldProgram.programID,
      );

      print("updated");
      await db.updateProgramData(submitProgramData);
      await db.getProgramData(widget.controllerId, widget.programIndex);
    }
  }

  void _handleRadioValueChange(int value) {
    setState(() {
      _radioValueforMode = value;

      /*switch (_radioValueforMode) {
        case 0:

          break;
        case 1:
        //_result = ...
          break;
        case 2:
        //_result = ...
          break;
      }*/
    });
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

  void _handleIntegrationValueChange(int value) {
    setState(() {
      _radioValueIntegration = value;

      switch (_radioValueIntegration) {
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
      child: ListView(
        children: <Widget>[
          Padding(padding: EdgeInsets.all(20.0),
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
                              child: Text("Program No: ${widget.programIndex+1}", style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20.0,
                                  //fontWeight: FontWeight.bold
                              ),),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10.0),
                Text("Mode:",
                  style: TextStyle(fontSize: 20.0),
                ),
                Row(
                  children: <Widget>[
                    new Radio(
                      value: 1,
                      groupValue: _radioValueforMode,
                      onChanged: _handleRadioValueChange,
                    ),
                    Text("1"),
                    SizedBox.fromSize(
                      size: Size(20.0, 0.0),
                    ),
                    new Radio(
                      value: 2,
                      groupValue: _radioValueforMode,
                      onChanged: _handleRadioValueChange,
                    ),
                    Text("2"),
                    SizedBox.fromSize(
                      size: Size(20.0, 0.0),
                    ),
                    new Radio(
                      value: 4,
                      groupValue: _radioValueforMode,
                      onChanged: _handleRadioValueChange,
                    ),
                    Text("4"),
                  ],
                ),
                Text("Flush Type:",
                  style: TextStyle(fontSize: 20.0),
                ),
                Row(
                  children: <Widget>[
                    new Radio(
                      value: 0,
                      groupValue: _radioValueFlushType,
                      onChanged: _handleFlushRadioValueChange,
                    ),
                    Text("Days"),
                    SizedBox.fromSize(
                      size: Size(10.0, 0.0),
                    ),
                    new Radio(
                      value: 1,
                      groupValue: _radioValueFlushType,
                      onChanged: _handleFlushRadioValueChange,
                    ),
                    Text("Irr-Out"),
                  ],
                ),
                TextFormField(
                  style: TextStyle(fontSize: 20.0,
                      color: Colors.black),
                  decoration: InputDecoration(
                      hintText: "day",
                      labelText: 'Interval',
                  ),
                  keyboardType: TextInputType.number,
                  controller: _intervalController,
                ),
                TextFormField(
                  style: TextStyle(fontSize: 20.0,
                      color: Colors.black),
                  decoration: InputDecoration(
                      hintText: "min",
                      labelText: 'Flush On',
                  ),
                  keyboardType: TextInputType.number,
                  controller: _flushOnControler,
                ),
                Row(
                  children: <Widget>[
                    Container(
                      width: 250.0,
                      child: Text("Volume based integration", style: TextStyle(
                        fontSize: 20.0,
                      ),),
                    ),
                    new Radio(
                      value: 0,
                      groupValue: _radioValueIntegration,
                      onChanged: _handleIntegrationValueChange,
                    ),
                  ],
                ),

                Row(
                  children: <Widget>[
                    Container(
                      width: 250.0,
                      child:Text("Time based integration", style: TextStyle(
                          fontSize: 20.0
                      ),),
                    ),
                    new Radio(
                      value: 1,
                      groupValue: _radioValueIntegration,
                      onChanged: _handleIntegrationValueChange,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    RawMaterialButton(
                      onPressed: (){
                        _handelProgramDataSubmit();
                        final int nextIndex = widget.programIndex + 1;
                        if(nextIndex < widget.maxIndex){
                          Navigator.of(context).pushReplacement(
                            _ProgramOption.route(nextIndex, widget.maxIndex, widget.controllerId),
                          );
                        }else{
                          ControllerDetails.navigateToPage(context, ControllerDetailsPageId.PROGRAM.nextPageId);
                        }
                      },
                      fillColor: Colors.indigo,
                      splashColor: Colors.white,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15.0),
                        child: Text(_oldProgram != null? "Update & Next": "Save & Next",
                          style: TextStyle(color: Colors.white),
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
      ),
    );
  }
}
