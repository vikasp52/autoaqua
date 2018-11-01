import 'package:autoaqua/UI/ControllerDetails/ControllerDetails.dart';
import 'package:flutter/material.dart';

class FoggerPage extends StatefulWidget {

  static Route<dynamic> route(int controllerId) {
    return ControllerDetailsPageRoute(
      pageId: ControllerDetailsPageId.FOGGER,
      builder: (context) => FoggerPage(
        controllerId: controllerId,
      ),
    );
  }

  const FoggerPage({
    Key key,
    @required this.controllerId,
  }) : super(key: key);

  final int controllerId;

  @override
  _FoggerPageState createState() => _FoggerPageState();
}

class _FoggerPageState extends State<FoggerPage> {
  @override
  Widget build(BuildContext context) {
    return ControllerDetailsPageFrame(
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  //width: 60.0,
                  child: Text("Field", style: TextStyle(fontSize: 20.0),)
                ),
                Container(
                  //width: 60.0,
                    child: Text("On Sec", style: TextStyle(fontSize: 20.0),)
                ),
                Container(
                  //width: 60.0,
                    child: Text("Temp \n Degree", style: TextStyle(fontSize: 20.0),)
                ),
                Container(
                 // width: 60.0,
                    child: Text("Hum \n %", style: TextStyle(fontSize: 20.0),)
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
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
            SizedBox.fromSize(
              size: Size(10.0, 10.0),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                RawMaterialButton(
                  onPressed: (){
                    ControllerDetails.navigateToNext(context);
                  },
                  fillColor: Colors.indigo,
                  splashColor: Colors.white,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: 15.0),
                    child: Text(
                      "SAVE",
                      style: TextStyle(
                          color: Colors.white),
                    ),
                  ),
                  shape: const StadiumBorder(),
                ),
                SizedBox.fromSize(
                  size: Size(10.0, 10.0),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
