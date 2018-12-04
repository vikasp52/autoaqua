import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:fluttertoast/fluttertoast.dart';

String dateFormatted(){
  var now = DateTime.now();

  var formatter = new DateFormat("EEE, MMM d, ''yy, HH, m");
  String formatted = formatter.format(now);

  return formatted;
}

AppendZero(String etController) {
  if (etController.length < 2) {
    return '0' + '$etController';
  } else {
    return etController;
  }
}


Widget LabelForTextBoxes(String label){
  return Padding(
    padding: const EdgeInsets.only(bottom:8.0),
    child: Text("$label",style: TextStyle(
      fontSize: 20.0,
    ),),
  );
}

commonDivider(){
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Divider(
      height: 1.0,
    ),
  );
}

void showColoredToast(String errormessage) {
  Fluttertoast.showToast(
      msg: errormessage,
      timeInSecForIos: 4,
      toastLength: Toast.LENGTH_SHORT,
      bgcolor: "#e74c3c",
      textcolor: '#ffffff'
  );
}

void showPositiveToast(String errormessage) {
  Fluttertoast.showToast(
      msg: errormessage,
      timeInSecForIos: 4,
      toastLength: Toast.LENGTH_SHORT,
      bgcolor: "#008000",
      textcolor: '#ffffff'
  );
}