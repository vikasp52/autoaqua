import 'package:autoaqua/Model/StringModel.dart';
import 'package:autoaqua/Utils/Database_Client.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_sms/flutter_sms.dart';
import 'package:intl/intl.dart';
import 'package:fluttertoast/fluttertoast.dart';

String dateFormatted() {
  var now = DateTime.now();

  var formatter = new DateFormat("EEE, MMM d, ''yy, HH, m");
  String formatted = formatter.format(now);

  return formatted;
}

//Append 0 & return 00 for textvalues.
AppendZero(String etController) {
  if (etController.length < 2 && etController.isNotEmpty) {
    return '0' + '$etController';
  } else if (etController.isEmpty) {
    return '00';
  } else {
    return etController;
  }
}

//Add 6 digit
AppendSixZero(String eController) {
  return eController.padLeft(6, '0');
}

//Add 4 digit
AppendFourDigit(String eController) {
  return eController.padLeft(4, '0');
}

//Add 3 digit
AppendThreeDigit(String eController) {
  return eController.padLeft(3, '0');
}

//Common list for Programs
Widget CommonList(int index){
  return Card(
      color: Colors.blue,
      shape: StadiumBorder(),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Text(
          "PROGRAM ${index + 1}",
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Colors.white,
              fontSize: 20.0),
        ),
      ));
}

//Controller Name
Widget controllerName(name){
  return Flexible(
    child: Column(
      children: <Widget>[
        Flexible(
            child: Center(
              child: Text(
                name,
                style: TextStyle(fontSize: 30.0, color: Color.fromRGBO(0, 84, 179, 1.0), fontWeight: FontWeight.bold),
              ),
            )),
      ],
    ),
  );
}

Widget LabelForTextBoxes(String label) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 8.0),
    child: Text(
      "$label",
      style: TextStyle(
        fontSize: 20.0,
      ),
    ),
  );
}

bool validateEmpty(String val) {
  return val.isEmpty || int.parse(val) < 1;
}

Widget CommonTextField(TextEditingController controller, FormFieldValidator<String> validator,
    [TextAlign textAlign = TextAlign.start, String suffixText, String prefixText]) {
  return TextFormField(
    textAlign: textAlign,
    keyboardType: TextInputType.number,
    inputFormatters: [
      BlacklistingTextInputFormatter(new RegExp('[\\.|\\,-]')),
    ],
    controller: controller,
    style: TextStyle(fontSize: 20.0, color: Colors.black),
    validator: validator,
    maxLength: 2,
    decoration: new InputDecoration(
      //labelText: "Total Programs per Day",
      counterText: "",
      suffixText: suffixText,
      prefixText: prefixText,
      border: OutlineInputBorder(),
      fillColor: Colors.black,
    ),
  );
}

commonDivider() {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Divider(
      height: 1.0,
    ),
  );
}

void showColoredToast(String errormessage) {
  Fluttertoast.showToast(
      msg: errormessage, timeInSecForIos: 4, toastLength: Toast.LENGTH_SHORT, bgcolor: "#e74c3c", textcolor: '#ffffff');
}

void showPositiveToast(String errormessage) {
  Fluttertoast.showToast(
      msg: errormessage, timeInSecForIos: 4, toastLength: Toast.LENGTH_SHORT, bgcolor: "#ffffff", textcolor: '#000000');
}

//Close the App on back press
Future<bool> willPop(BuildContext context) {
  return showDialog(
      context: context,
      builder: (context) => AlertDialog(
            title: Text("Do you really want to exit"),
            actions: <Widget>[
              FlatButton(onPressed: () => Navigator.pop(context, false), child: Text("No")),
              FlatButton(onPressed: () => Navigator.pop(context, true), child: Text("Yes")),
            ],
          ));
}

//Buttons for every page
Widget commonButton(VoidCallback onPressed, String child) {
  return RawMaterialButton(
    onPressed: onPressed,
    textStyle: TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 20.0,
    ),
    child: Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.0),
      child: Text(
        child,
        style: TextStyle(color: Colors.white),
      ),
    ),
    fillColor: Color.fromRGBO(0, 84, 179, 1.0),
    shape: StadiumBorder(),
  );
}

//Get the controller Number to send the sms.
Future<String> getControllerNum(controllerID) async {
  DataBaseHelper db = DataBaseHelper();
  final ctrlNum = await db.getItem(controllerID);
  print("CTRL NO: ${ctrlNum.itemNumber}");
  return ctrlNum != null ? ctrlNum.itemNumber : null;
}

void sendSMS(String message, controllerID) async {
  String ctrlNo = await getControllerNum(controllerID);
  String _result = await FlutterSms.sendSMS(message: message, recipients: ["$ctrlNo"]).catchError((onError) {
    print(onError);
  });
  print(_result);
}

Future<Null> sendSmsForAndroid(String sms, controllerID) async {
  const platform = const MethodChannel('sendSms');
  String ctrlNo = await getControllerNum(controllerID);
  print("SendSMS");
  //String sms = "Hello! I'm sent it programatically.";
  try {
    final String result = await platform.invokeMethod(
        'send', <String, dynamic>{"phone": "+91$ctrlNo", "msg": sms}); //Replace a 'X' with 10 digit phone number
    print(result);
    print("+91$ctrlNo");
  } on PlatformException catch (e) {
    print(e.toString());
  }
}

//Method the save the String in StringTable
saveStringData(controllerId, stringType, stringTypeId,valSeq, string) async {
  final db = new DataBaseHelper();
  StringModel saveStringData = new StringModel(controllerId,stringType,stringTypeId,valSeq,string);
  await db.saveStrings(saveStringData);
  await db.getStringData(controllerId);
}

updateStringData(controllerId, stringType, stringTypeId,valSeq, string) async {
  final db = new DataBaseHelper();
  StringModel saveStringData = new StringModel(controllerId,stringType,stringTypeId,valSeq,string);
  await db.updateConfigString(saveStringData);
  await db.getStringData(controllerId);
}
