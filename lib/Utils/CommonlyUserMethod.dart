import 'package:intl/intl.dart';

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
