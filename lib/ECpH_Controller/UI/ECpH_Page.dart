import 'package:autoaqua/ECpH_Controller/Model/ECpHModel.dart';
import 'package:autoaqua/ECpH_Controller/Utils/ECpHDatabaseHelper.dart';
import 'package:autoaqua/Model/TimerModel.dart';
import 'package:autoaqua/UI/ControllerDetails/ControllerDetails.dart';
import 'package:autoaqua/UI/ControllerDetails/ProgramPage.dart';
import 'package:autoaqua/Utils/APICallMethods.dart';
import 'package:autoaqua/Utils/Database_Client.dart';
import 'package:autoaqua/Utils/CommonlyUserMethod.dart';
import 'package:flutter/material.dart';


class ECpH_Page extends StatefulWidget {

  @override
  _ECpH_PageState createState() => _ECpH_PageState();
}

class _ECpH_PageState extends State<ECpH_Page> {

  final _ecValueController = TextEditingController();
  final _pHValueController = TextEditingController();
  final _sensingDelayValueController = TextEditingController();
  ECpHDataBaseHelper db = new ECpHDataBaseHelper();
  ECpHModel _oldECpHModel;
  Future _loading;

  //Get the data to display
  Future<void> _getECpHData()async{
    _loading = db.getECpHItems().then((ecphData) {
    _oldECpHModel = ecphData;
      print("ecphData data is $ecphData");
      if(ecphData != null) {
        setState(() {
          _ecValueController.value = TextEditingValue(text: ecphData.ECVal);
          _pHValueController.value = TextEditingValue(text: ecphData.pHVal);
          _sensingDelayValueController.value = TextEditingValue(text: ecphData.sensignDelay);
        });
      }
    });
  }

  //Save the data
  Future<void> _saveECpH() async{
    if(_oldECpHModel == null){
      ECpHModel saveMobNo = new ECpHModel(
          _ecValueController.text,
          _pHValueController.text,
          _sensingDelayValueController.text,
          dateFormatted()
      );
      db.saveECpHItem(saveMobNo);
      db.getECpHItems();
    }else{
      ECpHModel updateMobNo = new ECpHModel(
          _ecValueController.text,
          _pHValueController.text,
          _sensingDelayValueController.text,
          dateFormatted(),
        _oldECpHModel.ECpHID
      );
      db.updateECpHData(updateMobNo);
      db.getECpHItems();
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getECpHData();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _loading,
        builder: (context, snapshot){
          if(snapshot.connectionState == ConnectionState.done){
            return BuildContent();
          }else{
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        }
    );
  }

  Widget BuildContent(){
    return CommonBodyStrecture(
      text: "SET EC/pH",
      child: Form(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                LabelForTextBoxes("Enter EC Value"),
                TextFieldForECpH(
                  _ecValueController,
                      (value) {
                    if (validateEmpty(value)) {
                      return "Please enter the EC Value"; //showSnackBar(context, "Please enter the Max program");
                    }
                  },
                    TextAlign.start,
                  "mS/Cm"
                ),
                LabelForTextBoxes("Enter pH Value"),
                TextFieldForECpH(
                  _pHValueController,
                      (value) {
                    if (validateEmpty(value)) {
                      return "Please enter the pH Value"; //showSnackBar(context, "Please enter the Max program");
                    }
                  },
                    TextAlign.start,
                    "pH"
                ),
                LabelForTextBoxes("Enter Sensing Delay"),
                TextFieldForECpH(
                  _sensingDelayValueController,
                      (value) {
                    if (validateEmpty(value)) {
                      return "Please enter the Sensing Delay"; //showSnackBar(context, "Please enter the Max program");
                    }
                  },
                    TextAlign.start,
                    "sec"
                ),

                Center(child: commonButton((){
                  _saveECpH();
                  Navigator.of(context).pop();
                }, _oldECpHModel != null ? "Update" : "Save",))
              ],
            ),
          ),
        ),
      ),
    );
  }
}


