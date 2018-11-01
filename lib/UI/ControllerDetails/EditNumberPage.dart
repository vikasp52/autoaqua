import 'package:autoaqua/UI/ControllerDetails/ControllerDetails.dart';
import 'package:flutter/material.dart';

class EditNumberPage extends StatefulWidget {

  static Route<dynamic> route(int controllerId) {
    return ControllerDetailsPageRoute(
      pageId: ControllerDetailsPageId.EDIT_NUMBER,
      builder: (context) => EditNumberPage(
        controllerId: controllerId,
      ),
    );
  }

  const EditNumberPage({
    Key key,
    @required this.controllerId,
  }) : super(key: key);

  final int controllerId;

  @override
  _EditNumberPageState createState() => _EditNumberPageState();
}

class _EditNumberPageState extends State<EditNumberPage> {
  @override
  Widget build(BuildContext context) {
    return ControllerDetailsPageFrame(
      hasBackground: false,
      child: Padding(padding: EdgeInsets.all(10.0),
        child:Column(
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(
                  labelText: "Enter the number"
              ),
              style: TextStyle(fontSize: 20.0,
                  color: Colors.black),

              keyboardType: TextInputType.number,
            ),
            RawMaterialButton(
              onPressed: () {
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
          ],
        ),
      ),
    );
  }
}
