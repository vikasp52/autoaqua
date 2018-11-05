import 'package:autoaqua/UI/ControllerDetails/ControllerDetails.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SetClockTimePage extends StatefulWidget {
  static Route<dynamic> route(int controllerId) {
    return ControllerDetailsPageRoute(
      pageId: ControllerDetailsPageId.SET_TIME,
      builder: (context) => SetClockTimePage(
            controllerId: controllerId,
          ),
    );
  }

  const SetClockTimePage({
    Key key,
    @required this.controllerId,
  }) : super(key: key);

  final int controllerId;

  @override
  _SetClockTimePageState createState() => _SetClockTimePageState();
}

class _SetClockTimePageState extends State<SetClockTimePage> {
  TextEditingController _hrsController = new TextEditingController();
  TextEditingController _minController = new TextEditingController();
  TextEditingController _dayOfWeekController = new TextEditingController();
  TextEditingController _dateController = new TextEditingController();
  TextEditingController _monthController = new TextEditingController();
  TextEditingController _yearController = new TextEditingController();

  static var now = DateTime.now();

  static var dayFormatter = new DateFormat("EEE");
  static var monthFormatter = new DateFormat("M");
  static var dateFormatter = new DateFormat("d");
  static var yearFormatter = new DateFormat("yyyy");
  static var hrsFormatter = new DateFormat("HH");
  static var minFormatter = new DateFormat("m");
  String dayFormate = dayFormatter.format(now);
  String monthFormate = monthFormatter.format(now);
  String dateFormate = dateFormatter.format(now);
  String yearFormate = yearFormatter.format(now);
  String hrsFormate = hrsFormatter.format(now);
  String minFormate = minFormatter.format(now);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      _hrsController.value = TextEditingValue(text: hrsFormate);
      _minController.value = TextEditingValue(text: minFormate);
      _dayOfWeekController.value = TextEditingValue(text: dayFormate);
      _dateController.value = TextEditingValue(text: dateFormate);
      _monthController.value = TextEditingValue(text: monthFormate);
      _yearController.value = TextEditingValue(text: yearFormate);
    });
  }

  @override
  Widget build(BuildContext context) {
    return ControllerDetailsPageFrame(
      hasBackground: false,
      child: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: 80.0,
                child: TextFormField(
                  controller: _hrsController,
                  decoration: InputDecoration(suffixText: "Hrs", fillColor: Colors.black),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  ":",
                  style: TextStyle(fontSize: 15.0),
                ),
              ),
              Container(
                width: 80.0,
                child: TextFormField(
                  controller: _minController,
                  decoration: InputDecoration(suffixText: "Min", fillColor: Colors.black),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: 80.0,
                child: TextFormField(
                  controller: _dayOfWeekController,
                  decoration: InputDecoration(
                      //suffixText: "Hrs",
                      fillColor: Colors.black),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: 60.0,
                child: TextFormField(
                  controller: _dateController,
                  decoration: InputDecoration(fillColor: Colors.black),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              SizedBox(
                width: 10.0,
              ),
              Container(
                width: 60.0,
                child: TextFormField(
                  controller: _monthController,
                  decoration: InputDecoration(fillColor: Colors.black),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              SizedBox(
                width: 10.0,
              ),
              Container(
                width: 60.0,
                child: TextFormField(
                  controller: _yearController,
                  decoration: InputDecoration(fillColor: Colors.black),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              )
            ],
          ),
          SizedBox(
            height: 20.0,
          ),
          RawMaterialButton(
            onPressed: () {
              ControllerDetails.navigateToNext(context);
            },
            fillColor: Colors.indigo,
            splashColor: Colors.white,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.0),
              child: Text(
                "Save",
                //_oldTimerData != null? "Update & Next": "Save & Next",
                style: TextStyle(color: Colors.white),
              ),
            ),
            shape: const StadiumBorder(),
          ),
        ],
      )),
    );
  }
}
