/*
//Strings variable
  final String tableStrings = "tableStrings";
  final String stringIdCol = "stringId";
  final String stringControllerIdCol = "stringControllerId";
  final String stringTypeCol = "stringType";
  final String stringTypeIdCol = "stringTypeId";
  final String stringValveSeqNoCol = "stringValveSeqNo";
  final String controllerStringCol = "controllerString";
 */

class StringModel {
  int _stringId;
  int stringControllerIdMode;
  String _stringType;
  String _stringTypeId;
  String _stringValveSeqNo;
  String _controllerString;

  StringModel(this.stringControllerIdMode,this._stringType, this._stringTypeId, this._stringValveSeqNo, this._controllerString);

  StringModel.map(dynamic obj){
    this._stringId = obj["stringId"];
    this.stringControllerIdMode = obj["stringControllerId"];
    this._stringType = obj["stringType"];
    this._stringTypeId = obj["stringTypeId"];
    this._stringValveSeqNo = obj["stringValveSeqNo"];
    this._controllerString = obj["controllerString"];
  }

  int get stringId => _stringId;
  int get stringControllerId => stringControllerIdMode;
  String get stringType => _stringType;
  String get stringTypeId => _stringTypeId;
  String get stringValveSeqNo => _stringValveSeqNo;
  String get controllerString => _controllerString;

  Map<String, dynamic> string_toMap(){
    var mapString = Map<String, dynamic>();
    if(stringId!=null){
      mapString["stringId"] = _stringId;
    }
    mapString["stringControllerId"] = stringControllerIdMode;
    mapString["stringType"] = _stringType;
    mapString["stringTypeId"] =  _stringTypeId;
    mapString["stringValveSeqNo"] = _stringValveSeqNo;
    mapString["controllerString"] = _controllerString;

    return mapString;
  }

  StringModel.string_fromMap(Map<String, dynamic>mapString){
    this._stringId = mapString["stringId"];
    this.stringControllerIdMode = mapString["stringControllerId"];
    this._stringType = mapString["stringType"];
    this._stringTypeId = mapString["stringTypeId"];
    this._stringValveSeqNo = mapString["stringValveSeqNo"];
    this._controllerString = mapString["controllerString"];
  }

}
