import 'package:autoaqua/UI/ControllerDetails/ControllerDetails.dart';
import 'package:flutter/material.dart';

class IRRPage extends StatefulWidget {

  static Route<dynamic> route(int controllerId) {
    return ControllerDetailsPageRoute(
      pageId: ControllerDetailsPageId.IRR_STOP,
      builder: (context) => IRRPage(
        controllerId: controllerId,
      ),
    );
  }

  const IRRPage({
    Key key,
    @required this.controllerId,
  }) : super(key: key);

  final int controllerId;

  @override
  _IRRPageState createState() => _IRRPageState();
}

class _IRRPageState extends State<IRRPage> {
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
      ),
    );
  }
}
