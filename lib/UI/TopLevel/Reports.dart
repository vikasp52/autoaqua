import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:charts_flutter/flutter.dart' as charts;

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  /*static var data = [
    Controller("Controller1", 10, Colors.blue),
    Controller("Controller2", 20, Colors.red),
    Controller("Controller3", 30, Colors.amber),
    Controller("Controller4", 40, Colors.green),
    Controller("Controller5", 50, Colors.deepPurpleAccent),
  ];*/
  List data;

  charts.Series<Controller, String> createSeries(String id, int i) {
    return charts.Series<Controller, String>(
        domainFn:(Controller controller,_)=>controller.controllerName,
        measureFn: (Controller controller,_) => controller.noOflitre,
        //colorFn: (Controller controller,_)=> controller.color,
        id: 'Controller',
        //data: data,
        labelAccessorFn: (Controller controller,_)=>'${controller.controllerName}:${controller.noOflitre}',
        data: [
        Controller("Controller$i", i, Colors.blue),
      ],
    );
  }

  Widget createChart() {
    // data is a List of Maps
    // each map contains at least temp1 (tool 1) and temp2 (tool 2)
    // what are the groupings?

    List<charts.Series<Controller, String>> seriesList = [];

    for (int i = 0; i < 5; i++) {
      String id = 'WZG${i + 1}';
      seriesList.add(createSeries(id, i));
    }

    print("series List is $seriesList");

    return charts.PieChart(
      seriesList,
      defaultRenderer: charts.ArcRendererConfig(
        arcRendererDecorators: [charts.ArcLabelDecorator()],
        arcWidth: 100,
      ),
      animate: true,
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    createChart();
  }
 /* static var series = [
    charts.Series(
        domainFn:(Controller controller,_)=>controller.controllerName,
        measureFn: (Controller controller,_) => controller.noOflitre,
        //colorFn: (Controller controller,_)=> controller.color,
        id: 'Controller',
        data: data,
        labelAccessorFn: (Controller controller,_)=>'${controller.controllerName}:${controller.noOflitre}'
    )
  ];*/


 /* var chart = charts.PieChart(
    series,
    defaultRenderer: charts.ArcRendererConfig(
      arcRendererDecorators: [charts.ArcLabelDecorator()],
      arcWidth: 100,
    ),
    animate: true,
  );*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: data == null ? CircularProgressIndicator() : createChart(), /*Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Text("Controller Details",style: TextStyle(
                fontSize: 30.0,
              ),),
              SizedBox(height: 400,child: chart),
              SizedBox(height: 300,child: chart),
              SizedBox(height: 200,child: chart),
            ],
          ),
        ),
      ),*/
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