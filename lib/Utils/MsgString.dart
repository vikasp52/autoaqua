import 'package:autoaqua/Utils/Database_Client.dart';

class MsgString {

  var _configuration;
  var _maxFoggerString;
  var _maxfoggerDelayString;
  int _MaxFogger;
  var testString;

  final DataBaseHelper dataBaseHelper = DataBaseHelper();

  void getFoggerData(int controllerID){
    dataBaseHelper.getFoggerData(1).then((foggerData){
      if(foggerData != null){
        for(int i=0;i<=_MaxFogger;i++){
          final model = foggerData[i];
          _maxFoggerString = model.fogger_maxRTU;
          _maxfoggerDelayString = model.fogger_foggerDelay;
        }
      }
    });
  }

  void getDataforConfiguration(int controllerID){
    dataBaseHelper.getConfigDataForController(controllerID).then((data){
      _configuration = ''''"QD"
          + data.configMaxProg
          + data.configMaxOutput
          + data.configNoOfSlaves
          + "1"
          + "2"
          + data.configMaxRTU;
          ''';
      testString = "VIkas";
    });

    print("This is config String $_configuration");
  }


  void SendMsg(){
    print("This is config String $testString");
  }
}