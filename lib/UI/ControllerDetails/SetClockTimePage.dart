import 'package:autoaqua/UI/ControllerDetails/ControllerDetails.dart';
import 'package:autoaqua/Utils/CommonlyUserMethod.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SetClockTimePage extends StatefulWidget {
  static Route<dynamic> route(int controllerId, String controllerName) {
    return ControllerDetailsPageRoute(
      pageId: ControllerDetailsPageId.SET_TIME,
      builder: (context) => SetClockTimePage(
            controllerId: controllerId,
          controllerName: controllerName
          ),
    );
  }

  const SetClockTimePage({
    Key key,
    @required this.controllerId,
    @required this.controllerName,
  }) : super(key: key);

  final int controllerId;
  final String controllerName;

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

  @override
  void initState() {
    super.initState();

   // var now = DateTime.now();
   setState(() {
    /*  _hrsController.value = TextEditingValue(text: hrsFormate);
      _minController.value = TextEditingValue(text: minFormate);
      _dayOfWeekController.value = TextEditingValue(text: dayFormate);
      _dateController.value = TextEditingValue(text: dateFormate);
      _monthController.value = TextEditingValue(text: monthFormate);
      _yearController.value = TextEditingValue(text: yearFormate);*/
    });
  }

  @override
  Widget build(BuildContext context) {
    var now = DateTime.now();
    var dayFormatter = new DateFormat("EEE");
    var monthFormatter = new DateFormat("MMMM");
    var dateFormatter = new DateFormat("d");
    var yearFormatter = new DateFormat("yyyy");
    var hrsFormatter = new DateFormat("HH");
    var minFormatter = new DateFormat("m");
    String dayFormate = dayFormatter.format(now);
    String monthFormate = monthFormatter.format(now);
    String dateFormate = dateFormatter.format(now);
    String yearFormate = yearFormatter.format(now);
    String hrsFormate = hrsFormatter.format(now);
    String minFormate = minFormatter.format(now);
    return ControllerDetailsPageFrame(
      hasBackground: false,
      child: Column(
        //mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
      Padding(
        padding: const EdgeInsets.all(10.0),
        child: Text(widget.controllerName,style: TextStyle(
            fontSize: 20.0,
            color: Colors.white,
            fontWeight: FontWeight.bold
        ),),
      ),
      commonDivider(),
      Expanded(
        flex: 9,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              //height: 30.0,
              color: Color.fromRGBO(0, 84, 179, 1.0),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "$hrsFormate",
                      style: TextStyle(
                        fontSize: 50.0,
                        color: Colors.white,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                    //Text("hrs",style: TextStyle(fontSize: 20.0),),
                    Text(
                      ":",
                      style: TextStyle(
                          fontSize: 50.0,
                          color: Colors.white,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                    Text(
                      "$minFormate",
                      style: TextStyle(
                          fontSize: 50.0,
                          color: Colors.white,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                    Text(
                      " $dayFormate",
                      style: TextStyle(
                          fontSize: 50.0,
                          color: Colors.white,
                          fontWeight: FontWeight.bold
                      ),
                    )
                  ],
                ),
              ),
            ),
            Text("$dateFormate",style: TextStyle(
                fontSize: 50.0,
                color: Color.fromRGBO(0, 84, 179, 1.0),
                fontWeight: FontWeight.bold
            ),),
            Text("$monthFormate",style: TextStyle(
                fontSize: 40.0,
                color: Color.fromRGBO(0, 84, 179, 1.0),
                fontWeight: FontWeight.bold
            ),),
            Text("$yearFormate",style: TextStyle(
                fontSize: 40.0,
                color: Color.fromRGBO(0, 84, 179, 1.0),
                fontWeight: FontWeight.bold
            ),),
          ],
        ),
      ),
      /*SizedBox(
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
      ),*/
        ],
      ),
    );
  }
}
