import 'package:autoaqua/ECpH_Controller/Model/ECpHMobNo.dart';
import 'package:autoaqua/ECpH_Controller/Utils/ECpHDatabaseHelper.dart';
import 'package:autoaqua/UI/ControllerDetails/ControllerDetails.dart';
import 'package:autoaqua/Utils/CommonlyUserMethod.dart';
import 'package:flutter/material.dart';

class SetMobNo extends StatefulWidget {
  @override
  _SetMobNoState createState() => _SetMobNoState();
}

class _SetMobNoState extends State<SetMobNo> {
  TextEditingController _mobNoController = new TextEditingController();

  ECpHmobNoModel _oldnoModel;
  ECpHDataBaseHelper db = new ECpHDataBaseHelper();
  Future _loading;

  Future<void> _getMobNo()async{
    _loading = db.getECpHMobItems().then((mobNo) {
      _oldnoModel = mobNo;
      print(mobNo);
      if(mobNo != null) {
        setState(() {
          _mobNoController.value = TextEditingValue(text: mobNo.ECpHmobNo);
        });
      }
    });
  }

  Future<void> _saveMobNo() async{
    if(_oldnoModel == null){
      ECpHmobNoModel saveMobNo = new ECpHmobNoModel(
          _mobNoController.text,
          dateFormatted()
      );
      db.saveECpHMobNoItem(saveMobNo);
      db.getECpHMobItems();
    }else{
      ECpHmobNoModel updateMobNo = new ECpHmobNoModel(
          _mobNoController.text,
          dateFormatted(),
        _oldnoModel.ECpHmobNoId
      );
      db.updateMobNoData(updateMobNo);
      db.getECpHMobItems();
    }
  }

  @override
  void initState() {
    super.initState();
    _getMobNo();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _loading,
        builder: (context, snapshot){
        if(snapshot.connectionState == ConnectionState.done){
          return BuildMobNoComponent();
        }else{
          return Center(child: CircularProgressIndicator(),);
        }
        });
  }

  Widget BuildMobNoComponent(){
    return CommonBodyStrecture(
      text: "SET MOBILE NO",
      child: Padding(padding: EdgeInsets.all(10.0),
        child:Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[

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
                   if(_mobNoController.text.length < 10){
                    showColoredToast("Please enter valid mobile no");
                  }else{
                    _saveMobNo();
                    Navigator.of(context).pop();
                    _oldnoModel != null ? showPositiveToast("Data is updated successfully") : showColoredToast("Data is saved successfully");
                  }
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
