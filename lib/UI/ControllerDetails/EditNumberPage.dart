import 'package:autoaqua/Model/MobNoModel.dart';
import 'package:autoaqua/UI/ControllerDetails/ControllerDetails.dart';
import 'package:autoaqua/Utils/Database_Client.dart';
import 'package:autoaqua/Utils/CommonlyUserMethod.dart';
import 'package:flutter/material.dart';

class EditNumberPage extends StatefulWidget {

  static Route<dynamic> route(int controllerId, String controllerName) {
    return ControllerDetailsPageRoute(
      pageId: ControllerDetailsPageId.EDIT_NUMBER,
      builder: (context) => EditNumberPage(
        controllerId: controllerId,
          controllerName:controllerName
      ),
    );
  }

  const EditNumberPage({
    Key key,
    @required this.controllerId,
    @required this.controllerName,
  }) : super(key: key);

  final int controllerId;
  final String controllerName;

  @override
  _EditNumberPageState createState() => _EditNumberPageState();
}

class _EditNumberPageState extends State<EditNumberPage> {

  TextEditingController _mobNoController = new TextEditingController();

  mobNoModel _oldnoModel;
  DataBaseHelper db = new DataBaseHelper();
  Future _loading;

  @override
  void initState() {
    super.initState();
    _loading = db.getMobNo(widget.controllerId).then((mobNo) {
      _oldnoModel = mobNo;
      print(mobNo);
      if(mobNo != null) {
        setState(() {
          _mobNoController.value = TextEditingValue(text: mobNo.mobNo);
        });
      }
    });
  }


  Future<void> _saveMobNo() async{
    if(_oldnoModel == null){
      mobNoModel saveMobNo = new mobNoModel(
          widget.controllerId,
          _mobNoController.text,
          dateFormatted()
      );
      db.saveMobNo(saveMobNo);
      db.getMobNo(widget.controllerId);
    }else{
      mobNoModel updateMobNo = new mobNoModel(
        widget.controllerId,
        _mobNoController.text,
          dateFormatted()
      );
      db.updateMobNo(updateMobNo);
      db.getMobNo(widget.controllerId);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ControllerDetailsPageFrame(
      hasBackground: false,
      child: Padding(padding: EdgeInsets.all(10.0),
        child:Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Center(
                child: Text(widget.controllerName,style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                    fontWeight: FontWeight.bold
                ),),
              ),
            ),
            commonDivider(),
            Text("Enter the Mob No. of Controller",style: TextStyle(
              fontSize: 20.0
            ),),

            TextFormField(
              maxLength: 10,
              controller: _mobNoController,
              decoration: InputDecoration(
                  //labelText: "Enter the number",
                counterText: "",
                border: OutlineInputBorder()
              ),
              style: TextStyle(fontSize: 20.0,
                  color: Colors.black),
              keyboardType: TextInputType.number,
            ),
            Center(
              child: RawMaterialButton(
                onPressed: () {
                  _saveMobNo();
                  _oldnoModel != null ? showPositiveToast("Data is updated successfully") : showColoredToast("Data is saved successfully");
                  ControllerDetails.navigateToNext(context);
                },
                fillColor: Color.fromRGBO(0, 84, 179, 1.0),
                splashColor: Colors.white,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: 15.0),
                  child: Text(
                    _oldnoModel != null? "Update": "Save",
                    style: TextStyle(
                      fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
                shape: const StadiumBorder(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
