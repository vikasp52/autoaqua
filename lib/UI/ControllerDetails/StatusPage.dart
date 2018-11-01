import 'package:autoaqua/UI/ControllerDetails/ControllerDetails.dart';
import 'package:flutter/material.dart';

class StatusPage extends StatefulWidget {

  static Route<dynamic> route(int controllerId) {
    return ControllerDetailsPageRoute(
      pageId: ControllerDetailsPageId.STATUS,
      builder: (context) => StatusPage(
        controllerId: controllerId,
      ),
    );
  }

  const StatusPage({
    Key key,
    @required this.controllerId,
  }) : super(key: key);

  final int controllerId;

  @override
  _StatusPageState createState() => _StatusPageState();
}

class _StatusPageState extends State<StatusPage> {
  @override
  Widget build(BuildContext context) {
    return ControllerDetailsPageFrame(
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            RaisedButton(
              color: Colors.white,
              padding: const EdgeInsets.all(24.0),
              child: Text("IRRIGATION STATUS",
                style: TextStyle(fontSize: 20.0),
              ),
              onPressed: () {
                ControllerDetails.navigateToNext(context);
              },
            ),
            SizedBox(height: 16.0),
            RaisedButton(
              color: Colors.white,
              padding: const EdgeInsets.all(24.0),
              child: Text("WEATHER STATUS",
                style: TextStyle(fontSize: 20.0),
              ),
              onPressed: () {
                ControllerDetails.navigateToNext(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
