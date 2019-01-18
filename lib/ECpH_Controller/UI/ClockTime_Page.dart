import 'package:autoaqua/UI/ControllerDetails/ControllerDetails.dart';
import 'package:autoaqua/Utils/CommonlyUserMethod.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


class SetClockTime extends StatefulWidget {
  @override
  _SetClockTimeState createState() => _SetClockTimeState();
}

class _SetClockTimeState extends State<SetClockTime> {
  @override
  Widget build(BuildContext context) {
    var now = DateTime.now();
    var dayFormatter = new DateFormat("EEE");
    var monthFormatter = new DateFormat("MMMM");
    var dateFormatter = new DateFormat("d");
    var yearFormatter = new DateFormat("yyyy");
    var hrsFormatter = new DateFormat("HH");
    var minFormatter = new DateFormat("m");
    var yearNum = new DateFormat("yy");
    var monthNum = new DateFormat("M");
    String dayFormate = dayFormatter.format(now);
    String monthFormate = monthFormatter.format(now);
    String dateFormate = dateFormatter.format(now);
    String yearFormate = yearFormatter.format(now);
    String hrsFormate = hrsFormatter.format(now);
    String minFormate = minFormatter.format(now);

    //Parameters for String
    String month = monthNum.format(now);
    String year = yearNum.format(now);

    //String clockString = "QK${AppendZero(hrsFormate)}${AppendZero(minFormate)}${AppendZero(dateFormate)}${AppendZero(monthFormate)}${AppendZero(yearFormate)}";
    return CommonBodyStrecture(
      text: "CLOCK TIME",
      child: Column(
        //mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
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
                          AppendZero("$minFormate"),
                          style: TextStyle(
                              fontSize: 50.0,
                              color: Colors.white,
                              fontWeight: FontWeight.bold
                          ),
                        ),
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
