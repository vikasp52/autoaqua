import 'package:autoaqua/UI/ControllerDetails/ControllerDetails.dart';
import 'package:autoaqua/Utils/CommonlyUserMethod.dart';
import 'package:autoaqua/Utils/Database_Client.dart';
import 'package:flutter/material.dart';

class StatusPage extends StatefulWidget {
  static Route<dynamic> route(int controllerId, String controllerName) {
    return ControllerDetailsPageRoute(
      pageId: ControllerDetailsPageId.STATUS,
      builder: (context) => StatusPage(
            controllerId: controllerId,
          controllerName:controllerName
          ),
    );
  }

  const StatusPage({
    Key key,
    @required this.controllerId,
    @required this.controllerName,
  }) : super(key: key);

  final int controllerId;
  final String controllerName;

  @override
  _StatusPageState createState() => _StatusPageState();
}

class _StatusPageState extends State<StatusPage> {
  DataBaseHelper dbh = DataBaseHelper();
  var _maxFogger = 0;
  var _ECpHStatus;

  @override
  void initState() {
    super.initState();
    print("THis is database table for Configuration ${dbh.getProgramItems}");

    dbh.getConfigDataForController(widget.controllerId).then((configDetails){
      if(configDetails != null){
        setState(() {
          _ECpHStatus = configDetails.configEcpHStatus;
        });
      }

      print("ECph Status ${_ECpHStatus}");
    });

    dbh.getFoggerData(widget.controllerId).then((foggerdetails) {
      if (foggerdetails != null) {
        setState(() {
          for (int i = 0; i < 1; i++) {
            final model = foggerdetails[i];
            _maxFogger = int.parse(model.fogger_maxRTU);
          }
          print("Fogger data is : $_maxFogger");
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ControllerDetailsPageFrame(
      child: Column(
        children: <Widget>[
          Flexible(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(widget.controllerName,style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                    fontWeight: FontWeight.bold
                ),),
              ),
            ),
          ),
          commonDivider(),
          Expanded(
            flex: 8,
            child: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  RaisedButton(
                    color: Color.fromRGBO(0, 84, 179, 1.0),
                    padding: const EdgeInsets.all(24.0),
                    child: Text(
                      "IRRIGATION STATUS",
                      style: TextStyle(fontSize: 20.0,color: Colors.white),
                    ),
                    onPressed: () {
                      sendSmsForAndroid("QC", widget.controllerId);
                      Navigator.of(context).popUntil((route) => route is ControllerDetailsMainRoute);
                    },
                  ),
                  SizedBox(height: 16.0),
                  _maxFogger > 0 && _maxFogger != null
                      ? RaisedButton(
                          color: Color.fromRGBO(0, 84, 179, 1.0),
                          padding: const EdgeInsets.all(24.0),
                          child: Text(
                            "WEATHER STATUS",
                            style: TextStyle(fontSize: 20.0,color: Colors.white),
                          ),
                          onPressed: () {
                            //ControllerDetails.navigateToNext(context);
                            //sendSmsForAndroid("QE", widget.controllerId);
                            Navigator.of(context).popUntil((route) => route is ControllerDetailsMainRoute);
                          },
                        )
                      : SizedBox(
                          height: 0.0,
                        ),
                  SizedBox(height: 16.0),
                  _ECpHStatus == "true" ?RaisedButton(
                    color: Color.fromRGBO(0, 84, 179, 1.0),
                    padding: const EdgeInsets.all(24.0),
                    child: Text(
                      "EC/pH STATUS",
                      style: TextStyle(fontSize: 20.0,color: Colors.white),
                    ),
                    onPressed: () {
                      sendSmsForAndroid("QE", widget.controllerId);
                      Navigator.of(context).popUntil((route) => route is ControllerDetailsMainRoute);
                    },
                  ):SizedBox(
                    height: 0.0,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
