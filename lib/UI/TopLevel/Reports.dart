import 'dart:async';
import 'package:autoaqua/Utils/Database_Client.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class MyHomePage extends StatefulWidget {
  String selectedController;
  int _selectedControllerIndex;
  int totalwaterconsumptionpercontroller = 0;
  List<String> _ControllerName = <String>[];

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static int valve1 = 30;
  static int valve2 = 10;
  static int valve3 = 30;
  static int valve4 = 50;
  final db = new DataBaseHelper();

  Future _loadControllerData() async {
    var ControllerData = await db.getAllControllerDataAsString();
    if (ControllerData != null) {
      if(mounted){
        setState(() {
          widget._ControllerName = ControllerData;
        });
      }
    }
  }

  Future _loadOtherData(int ctrlId)async{
    var valveData = await db.getValves1LtrCount(ctrlId);
    var valve2Data = await db.getValves2LtrCount(ctrlId);
    var valve3Data = await db.getValves3LtrCount(ctrlId);
    var valve4Data = await db.getValves4LtrCount(ctrlId);
      setState(() {
        valve1 = valveData != null?valveData:0;
        valve2 = valve2Data != null?valve2Data:0;
        valve3 = valve3Data != null?valve3Data:0;
        valve4 = valve4Data != null?valve4Data:0;
        widget.totalwaterconsumptionpercontroller = valve1+valve2+valve3+valve4;
        print("Other data is ${widget.totalwaterconsumptionpercontroller}");
      });
  }



  static var data = [
  Controller("Valve 1", valve1, Colors.blue),
  Controller("Valve 2", valve2, Colors.red),
  Controller("Valve 3", valve3, Colors.amber),
  Controller("Valve 4", valve4, Colors.green),
  ];

  static var series = [
    charts.Series(
        domainFn:(Controller controller,_)=>controller.controllerName,
        measureFn: (Controller controller,_) =>controller.noOflitre,
        //colorFn: (Controller controller,_)=> controller.color,
        id: 'Controller',
        data: data,
        labelAccessorFn: (Controller controller,_)=>'${controller.controllerName}:${controller.noOflitre}'
    )
  ];


  var chart = charts.PieChart(
    series,
    defaultRenderer: charts.ArcRendererConfig(
      arcRendererDecorators: [charts.ArcLabelDecorator()],
      arcWidth: 100,
    ),
    animate: true,
  );

  @override
  void initState() {
    super.initState();
    _loadControllerData();
    //_loadOtherData(widget._selectedControllerIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(   //data == null ? CircularProgressIndicator() : createChart(),
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Text("Select Controller: ",style: TextStyle(
                    fontSize: 20.0,
                  ),),
                  DropdownButton<String>(
                    hint: Text(
                      "Select Controller",
                      style: TextStyle(color: Colors.white, fontSize: 15.0),
                    ),
                    style: TextStyle(
                      color: Colors.black,
                    ),
                    value: widget.selectedController,
                    items: widget._ControllerName.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String hu) {
                      setState(() {
                        widget.selectedController = hu;
                        widget._selectedControllerIndex = widget._ControllerName.indexOf(hu) + 1;
                        _loadOtherData(widget._selectedControllerIndex);
                        print("Slected Controller index is ${widget._selectedControllerIndex}");
                      });
                    },
                  ),
                ],
              ),
              widget.selectedController == null?SizedBox(width: 0.0,):Card(elevation: 10.0,child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Total water used in ${widget.selectedController}: ${widget.totalwaterconsumptionpercontroller} Ltr",style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.blue,
                  fontWeight: FontWeight.bold
                ),),
              ),),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Valves breakdown: ",style: TextStyle(
                  fontSize: 20.0,
                ),),
              ),
              Card(elevation: 10.0,child: SizedBox(height: 200,child: chart)),
              SizedBox(height: 300,child: chart),
              SizedBox(height: 200,child: chart),
            ],
          ),
        ),
      ),
    );
  }
}

class Controller {
   final String controllerName;
   final int noOflitre;
   final charts.Color color;

  Controller(this.controllerName, this.noOflitre, Color color)
      :this.color = charts.Color(a: color.red,g: color.green, b: color.blue, r: color.alpha);
}