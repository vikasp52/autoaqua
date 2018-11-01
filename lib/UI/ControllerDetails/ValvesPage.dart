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
  var maxSequence;
  Future _loading;

  @override
  void initState() {
    super.initState();
    print("THis is database table for Configuration ${dbh.getProgramItems}");

    _loading = dbh.getConfigDataForController(widget.controllerId).then((config) {
      //_oldConfig = config;
      if(config != null) {
        setState(() {
          maxSequence = int.parse(config.configMaxOutput); //TextEditingValue(text: config.configMaxProg);
        });
      }
      print("MaxSequence is ${maxSequence}");
    });
  }

  @override
  Widget build(BuildContext context) {
    return ControllerDetailsPageFrame(
      child: ListView.builder(
        itemCount: maxSequence,
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
              _ValveOption.route(widget.controllerId, index, maxSequence, 0),
            ),
          );
        },
      ),
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
  int _radioValue = 0;
  DataBaseHelper dbh = DataBaseHelper();
  int noOfValves = 0;
  Future _loading;
  //ConfigurationModel _oldConfig;

  @override
  void initState() {
    super.initState();
    print("THis is database table for Configuration ${dbh.getProgramItems}");

    _loading = dbh.getProgramData(widget.controllerId, widget.valveIndex).then((programData){
      if(programData != null){
        setState(() {
          noOfValves = int.parse(programData.program_mode);
        });
      }
    });
  }

  final _ctrl_FieldNo = <TextEditingController>[];
  final _ctrl_Tank = <TextEditingController>[];

  final TextEditingController _ctrl_FieldNo_Ltr = new TextEditingController();
  final TextEditingController _ctrl_Field_Ltr = new TextEditingController();
  final TextEditingController _ctrl_FieldNo_Min= new TextEditingController();
  final TextEditingController _ctrl_Field_Min = new TextEditingController();
  final TextEditingController _ctrl_Tank1_Ltr = new TextEditingController();
  final TextEditingController _ctrl_Tank2_Ltr = new TextEditingController();
  final TextEditingController _ctrl_Tank3_Ltr= new TextEditingController();
  final TextEditingController _ctrl_Tank4_Ltr = new TextEditingController();
  final TextEditingController _ctrl_Tank1_Min = new TextEditingController();
  final TextEditingController _ctrl_Tank2_Min = new TextEditingController();
  final TextEditingController _ctrl_Tank3_Min= new TextEditingController();
  final TextEditingController _ctrl_Tank4_Min = new TextEditingController();
  final TextEditingController _ctrl_FertlizerDelay_Ltr = new TextEditingController();
  final TextEditingController _ctrl_FertlizerDelay_Min = new TextEditingController();
  final TextEditingController _ctrl_ECSetp = new TextEditingController();
  final TextEditingController _ctrl_PHSetp= new TextEditingController();

  var _db = DataBaseHelper();
  void _handelValvesDataSubmit() async{

    ValvesModel submitValvesData = new ValvesModel(
        widget.controllerId,
        widget.valveIndex,
        widget.valveIndex,
        _ctrl_FieldNo_Ltr.text,
        _ctrl_Field_Ltr.text,
        _ctrl_FieldNo_Min.text,
        _ctrl_Field_Min.text,
        _ctrl_Tank1_Ltr.text,
        _ctrl_Tank1_Min.text,
        _ctrl_Tank2_Ltr.text,
        _ctrl_Tank2_Min.text,
        _ctrl_Tank3_Ltr.text,
        _ctrl_Tank3_Min.text,
        _ctrl_Tank4_Ltr.text,
        _ctrl_Tank4_Min.text,
        _radioValue.toString(),
        _ctrl_FertlizerDelay_Ltr.text,
        _ctrl_FertlizerDelay_Min.text,
        _ctrl_ECSetp.text,
        _ctrl_PHSetp.text,
        dateFormatted());

    int saveValvesId = await _db.saveValvesData(submitValvesData);

  }

  void _handleRadioValueChange(int value) {
    setState(() {
      _radioValue = value;

      switch (_radioValue) {
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
      title: "VALVES",
      child: SingleChildScrollView(
        //padding: EdgeInsets.all(20.0),
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
                          padding: const EdgeInsets.fromLTRB(25.0, 8.0, 8.0, 8.0),
                          child: Text("Program No: ${widget.valveIndex+1}", style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold
                          ),),
                        ),

                      )
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("Field / Valve Parameter",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text("Program No ${widget.valveIndex+1} - A",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20.0, ),
                ),
                Text("SEQ : ${widget.sequenceIndex+1}",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20.0, ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Divider(height: 1.0,),
            ),
            //SizedBox(height: 10.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("Field / Valve Number",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(height: 10.0,),
            Container(
              child: listOfValve(),
            ),
            /*Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Container(
                  child: DropdownButton<String>(
                    hint: Text("Field/Valve No", style: TextStyle(
                        color: Colors.black,
                        fontSize: 15.0
                    ),),
                    style: TextStyle(
                      color: Colors.black,
                    ),
                    items: <String>[
                      'Field/Valve No 1',
                      'Field/Valve No 2',
                      'Field/Valve No 3',
                      'Field/Valve No 4'
                    ].map((String value) {
                      return new DropdownMenuItem<String>(
                        value: value,
                        child: new Text(value),
                      );
                    }).toList(),
                    onChanged: (_) {},
                  ),
                ),
                Image.asset("Images/valve_1.png",
                  height: 50.0,
                  width: 50.0,),
                *//*Container(
                  width: 120.0,
                  child: TextFormField(
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.black,
                    ),
                    decoration: InputDecoration(
                      labelText: 'Field No',
                    ),
                    controller: _ctrl_FieldNo_Ltr,
                    keyboardType: TextInputType.number,
                  ),
                ),*//*
                Column(
                  children: <Widget>[
                    Container(
                      width: 120.0,
                      child: TextFormField(
                        style: TextStyle(
                          fontSize: 15.0,
                          color: Colors.black,
                        ),
                        controller: _ctrl_Field_Ltr,
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    Text("Select proper unit"),
                    SizedBox(height: 5.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Image.asset("Images/ltr.png",
                          height: 40.0,
                          width: 40.0,),
                        Image.asset("Images/minutes.png",
                          height: 40.0,
                          width: 40.0,),
                      ],
                    ),
                  ],
                ),
              ],
            ),*/
            /*Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  width: 120.0,
                  child: TextFormField(
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.black,
                    ),
                    decoration: InputDecoration(
                      labelText: 'Field No',
                    ),
                    controller: _ctrl_FieldNo_Min,
                    keyboardType: TextInputType.number,
                  ),
                ),
                Container(
                  width: 120.0,
                  child: TextFormField(
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.black,
                    ),
                    decoration: InputDecoration(
                      labelText: 'Minutes',
                    ),
                    controller: _ctrl_Field_Min,
                    keyboardType: TextInputType.number,
                  ),
                ),
              ],
            ),*/
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Divider(height: 1.0,),
            ),
            //SizedBox(height: 30.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("Fertilizer Programming",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(height: 10.0,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  decoration: _radioValue == 0? ShapeDecoration(shape: StadiumBorder(), color: Color.fromRGBO(0, 84, 179, 1.0)): null,
                  //color: Colors.blueAccent,
                  child: Row(
                    children: <Widget>[
                      Radio(
                        value: 0,
                        activeColor: Colors.white,
                        groupValue: _radioValue,
                        onChanged: _handleRadioValueChange,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Sequential", style: TextStyle(
                          color: _radioValue == 0? Colors.white: Colors.black
                        ),),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 20.0),
                Container(
                  decoration: _radioValue == 1? ShapeDecoration(shape: StadiumBorder(), color: Color.fromRGBO(0, 84, 179, 1.0)): null,
                  //color: Colors.blueAccent,
                  child: Row(
                    children: <Widget>[
                      Radio(
                        value: 1,
                        activeColor: Colors.white,
                        groupValue: _radioValue,
                        onChanged: _handleRadioValueChange,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Together", style: TextStyle(
                            color: _radioValue == 1? Colors.white: Colors.black
                        ),),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Divider(height: 1.0,),
            ),
            listOfTanks(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Divider(height: 1.0,),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("Set EC and pH Values",
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
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Divider(height: 1.0,),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("Pre and Post Fertlizer Delay",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Column(
              children: <Widget>[
                Container(
                  width: 120.0,
                  child: TextFormField(
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 15.0,
                      color: Colors.black,
                    ),
                    controller: _ctrl_FertlizerDelay_Min,
                    keyboardType: TextInputType.number,
                  ),
                ),
                Text("Select proper unit"),
                SizedBox(height: 5.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.asset("Images/ltr.png",
                      height: 40.0,
                      width: 40.0,),
                    Image.asset("Images/minutes.png",
                      height: 40.0,
                      width: 40.0,),
                  ],
                ),
              ],
            ),
            SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                RawMaterialButton(
                  onPressed: (){
                    _handelValvesDataSubmit();
                    if(widget.sequenceIndex < 2) {
                      Navigator.of(context).pushReplacement(
                        _ValveOption.route(
                          widget.controllerId,
                          widget.valveIndex,
                          widget.maxIndex,
                          widget.sequenceIndex + 1,
                        ),
                      );
                    }
                    else {
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
                    child: Text("SAVE",
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

  void _updateTankControllerCount(){
    setState(() {
      _ctrl_Tank.length = 4;
      for(int i = 0; i < _ctrl_Tank.length; i++){
        if(_ctrl_Tank[i] == null){
          _ctrl_Tank[i] = TextEditingController();
        }
      }
    });
  }

  Widget listOfTanks(){
    _updateTankControllerCount();
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(4, (index){
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text("Tank ${index+1}",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20.0)),
            Image.asset("Images/tankicon.png",
              height: 50.0,
              width: 50.0,),
            Column(
              children: <Widget>[
                Container(
                  width: 120.0,
                  child: TextFormField(
                    style: TextStyle(
                      fontSize: 15.0,
                      color: Colors.black,
                    ),
                    controller: _ctrl_Tank1_Ltr,
                    keyboardType: TextInputType.number,
                  ),
                ),
                Text("Select proper unit"),
                SizedBox(height: 5.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Image.asset("Images/ltr.png",
                      height: 40.0,
                      width: 40.0,),
                    Image.asset("Images/minutes.png",
                      height: 40.0,
                      width: 40.0,),
                  ],
                ),
              ],
            ),
          ],
        );
      }),
    );
  }

  void _updateValvesCount() {
    setState(() {
      _ctrl_FieldNo.length = noOfValves;
      for (int i = 0; i < _ctrl_FieldNo.length; i++) {
        if (_ctrl_FieldNo[i] == null) {
          _ctrl_FieldNo[i] = TextEditingController();
        }
      }
    });
  }

  Widget listOfValve(){
    _updateValvesCount();
    if(noOfValves != 0){
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(noOfValves, (index){
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Text("Field/Valve Number ${index + 1}"),
              Image.asset("Images/valve_1.png",
                height: 50.0,
                width: 50.0,),
              /*Container(
                  width: 120.0,
                  child: TextFormField(
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.black,
                    ),
                    decoration: InputDecoration(
                      labelText: 'Field No',
                    ),
                    controller: _ctrl_FieldNo_Ltr,
                    keyboardType: TextInputType.number,
                  ),
                ),*/
              Column(
                children: <Widget>[
                  Container(
                    width: 120.0,
                    child: TextFormField(
                      style: TextStyle(
                        fontSize: 15.0,
                        color: Colors.black,
                      ),
                      controller: _ctrl_FieldNo[index],
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  Text("Select proper unit"),
                  SizedBox(height: 5.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Image.asset("Images/ltr.png",
                        height: 40.0,
                        width: 40.0,),
                      Image.asset("Images/minutes.png",
                        height: 40.0,
                        width: 40.0,),
                    ],
                  ),
                ],
              ),
            ],
          );
        }),
      );
    }else{
      Text("There is no valves");
    }
  }
}
