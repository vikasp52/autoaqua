import 'package:autoaqua/UI/ControllerDetails/ControllerDetails.dart';
import 'package:autoaqua/Utils/APICallMethods.dart';
import 'package:autoaqua/Utils/CommonlyUserMethod.dart';
import 'package:flutter/material.dart';

class IRRPage extends StatefulWidget {

  static Route<dynamic> route(int controllerId, String controllerName) {
    return ControllerDetailsPageRoute(
      pageId: ControllerDetailsPageId.IRR_STOP,
      builder: (context) => IRRPage(
        controllerId: controllerId,
          controllerName:controllerName
      ),
    );
  }

  const IRRPage({
    Key key,
    @required this.controllerId,
    @required this.controllerName,
  }) : super(key: key);

  final int controllerId;
  final String controllerName;

  @override
  _IRRPageState createState() => _IRRPageState();
}

class _IRRPageState extends State<IRRPage> {

  APIMethods apiMethods = new APIMethods();

  @override
  Widget build(BuildContext context) {
    return ControllerDetailsPageFrame(
      hasBackground: false,
      child: Column(
        children: <Widget>[
          controllerName(widget.controllerName),
          commonDivider(),
          Expanded(
            flex: 9,
              child:Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    RaisedButton(
                      color: Color.fromRGBO(0, 84, 179, 1.0),
                      padding: const EdgeInsets.all(24.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          new Icon(Icons.stop,color: Colors.white,size: 40.0,),
                          Text(
                            "STOP",
                            style: TextStyle(fontSize: 20.0,color: Colors.white),
                          ),
                        ],
                      ),
                      onPressed: () {
                        _showDialogforStop();
                      },
                    ),
                    SizedBox(height: 16.0),
                    RaisedButton(
                      color: Color.fromRGBO(0, 84, 179, 1.0),
                      padding: const EdgeInsets.all(24.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          new Icon(Icons.pause,color: Colors.white,size: 40.0,),
                          Text(
                            "PAUSE",
                            style: TextStyle(fontSize: 20.0,color: Colors.white),
                          ),
                        ],
                      ),
                      onPressed: () {
                        _showDialogforPause();
                      },
                    ),
                  ],
                ),
              ),
          )
        ],
      ),
    );
  }


  void _showDialogforStop() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          //title: new Text("Alert Dialog title"),
          content: new Text("Do you really want to stop?",style: TextStyle(
            fontWeight: FontWeight.bold,fontSize: 20.0)),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: Row(
                children: <Widget>[
                  new Text("Yes",style: TextStyle(
                    fontSize: 20.0,fontWeight: FontWeight.bold,
                  ),),
                ],
              ),
              onPressed: () {
                //apiMethods.onOffPouseController(widget.controllerId, "0");
                sendSmsForAndroid("QA", widget.controllerId);
                showPositiveToast("SMS Sent Successfully");
                Navigator.of(context).pop();
              },
            ),
            new FlatButton(
              child: new Text("No",style: TextStyle(
        fontWeight: FontWeight.bold,fontSize: 20.0)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showDialogforPause() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          //title: new Text("Alert Dialog title"),
          content: new Text("Do you really want to Pause?",style: TextStyle(
            fontWeight: FontWeight.bold,fontSize: 20.0
          ),),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Yes",style: TextStyle(
          fontSize: 20.0,fontWeight: FontWeight.bold,)),
              onPressed: () {
                //apiMethods.onOffPouseController(widget.controllerId, "2");
                sendSmsForAndroid("QW", widget.controllerId);
                showPositiveToast("SMS Sent Successfully");
                Navigator.of(context).pop();
              },
            ),
            new FlatButton(
              child: new Text("No",style: TextStyle(
        fontSize: 20.0,fontWeight: FontWeight.bold)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

}
