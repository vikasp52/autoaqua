import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:fluttertoast/fluttertoast.dart';

String dateFormatted() {
  var now = DateTime.now();

  var formatter = new DateFormat("EEE, MMM d, ''yy, HH, m");
  String formatted = formatter.format(now);

  return formatted;
}

AppendZero(String etController) {
  if (etController.length < 2 && etController.isNotEmpty) {
    return '0' + '$etController';
  } else {
    return etController;
  }
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

bool validateEmpty(String val){
return val.isEmpty || int.parse(val) < 1;
}

Widget CommonTextField(
    TextEditingController controller, FormFieldValidator<String> validator,
    [TextAlign textAlign = TextAlign.start, String suffixText, String prefixText]) {
  return TextFormField(
    textAlign: textAlign,
    keyboardType: TextInputType.number,
    inputFormatters: [
      BlacklistingTextInputFormatter(new RegExp('[\\.|\\,-]')),
    ],
    controller: controller,
    style:TextStyle(fontSize: 20.0, color: Colors.black),
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
      msg: errormessage, timeInSecForIos: 4, toastLength: Toast.LENGTH_SHORT, bgcolor: "#008000", textcolor: '#ffffff');
}

//Close the App on back press
Future<bool> willPop(BuildContext context){
  return showDialog(
      context: context,
      builder: (context)=> AlertDialog(
        title: Text("Do you really want to exit"),
        actions: <Widget>[
          FlatButton(
              onPressed: () => Navigator.pop(context, false),
              child: Text("No")),
          FlatButton(
              onPressed: () => Navigator.pop(context, true),
              child: Text("Yes")),
        ],
      )
  );
}
