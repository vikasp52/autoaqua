import 'package:autoaqua/UI/ControllerDetails/ControllerDetails.dart';
import 'package:flutter/material.dart';

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
  @override
  Widget build(BuildContext context) {
    return ControllerDetailsPageFrame(
      hasBackground: false,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text("Under Development",
              style: TextStyle(fontSize: 30.0),
            ),
            SizedBox(height: 16.0),
            RaisedButton(
              child: Text('NEXT'),
              onPressed: () {
                ControllerDetails.navigateToNext(context);
              },
            ),
          ],
        ),
        /*Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    width: 60.0,
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: ""
                      ),
                      style: TextStyle(fontSize: 20.0,
                          color: Colors.black),

                      keyboardType: TextInputType.number,
                    ),
                  ),
                  Container(
                    width: 60.0,
                    child: TextFormField(
                      style: TextStyle(fontSize: 20.0,
                          color: Colors.black),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  Container(
                    width: 60.0,
                    child: TextFormField(
                      style: TextStyle(fontSize: 20.0,
                          color: Colors.black),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  Container(
                    width: 60.0,
                    child: TextFormField(
                      style: TextStyle(fontSize: 20.0,
                          color: Colors.black),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                ],
              ),
            ],
          )*/
      ),
    );
  }
}
