import 'package:autoaqua/Utils/Database_Client.dart';

class FoggerModel {
  int _foggerId;
  int fogger_controllerID;
  String _fogger_maxRTU;
  String _fogger_foggerDelay;
  String _fogger_Field;
  String _fogger_onSec;
  String _fogger_tempDegree;
  String _fogger_hum;
  String _fogger_DateCreated;
  String _fogger_configString;

  FoggerModel(
      this.fogger_controllerID,this._fogger_maxRTU, this._fogger_foggerDelay, this._fogger_Field, this._fogger_onSec, this._fogger_tempDegree, this._fogger_hum, this._fogger_DateCreated,this._fogger_configString);

  FoggerModel.map(dynamic obj) {
    this._foggerId = obj["foggerId"];
    this.fogger_controllerID = obj["fogger_controllerId"];
    this._fogger_maxRTU = obj["fogger_maxRTU"];
    this._fogger_foggerDelay= obj["fogger_foggerDelay"];
    this._fogger_Field = obj["fogger_Field"];
    this._fogger_onSec = obj["fogger_onSec"];
    this._fogger_tempDegree = obj["fogger_tempDegree"];
    this._fogger_hum = obj["fogger_hum"];
    this._fogger_DateCreated = obj["fogger_DateCreated"];
    this._fogger_configString = obj["fogger_configString"];
  }

  set foggerId(int value) => _foggerId = value;

  int get foggerId => _foggerId;
  int get fogger_controllerId => fogger_controllerID;
  String get fogger_maxRTU => _fogger_maxRTU;
  String get fogger_foggerDelay => _fogger_foggerDelay;
  String get  fogger_Field => _fogger_Field;
  String get fogger_onSec => _fogger_onSec;
  String get fogger_tempDegree => _fogger_tempDegree;
  String get fogger_hum => _fogger_hum;
  String get fogger_DateCreated => _fogger_DateCreated;
  String get fogger_configString => _fogger_configString;

  Map<String, dynamic> tomap_Fogger(){
    var mapFogger = new Map<String, dynamic>();
    if(foggerId != null){
      mapFogger["foggerId"] = _foggerId;
    }
    mapFogger[DataBaseHelper.fogger_controllerCol] = fogger_controllerID;
    mapFogger[DataBaseHelper.fogger_maxRTUCol] = _fogger_maxRTU;
    mapFogger[DataBaseHelper.fogger_foggerDelayCol] = _fogger_foggerDelay;
    mapFogger[DataBaseHelper.fogger_FieldCol] = _fogger_Field;
    mapFogger[DataBaseHelper.fogger_onSecCol] = _fogger_onSec;
    mapFogger[DataBaseHelper.fogger_tempDegreeCol] = _fogger_tempDegree;
    mapFogger[DataBaseHelper.fogger_humCol] = _fogger_hum;
    mapFogger[DataBaseHelper.fogger_dateCreated] = _fogger_DateCreated;
    mapFogger[DataBaseHelper.fogger_configStringCol] = _fogger_configString;
    return mapFogger;
  }

  FoggerModel.fromMap_Fogger(Map<String, dynamic>mapFogger){
    this._foggerId = mapFogger["foggerId"];
    this.fogger_controllerID = mapFogger["fogger_controllerId"];
    this._fogger_maxRTU = mapFogger["fogger_maxRTU"];
    this._fogger_foggerDelay= mapFogger["fogger_foggerDelay"];
    this._fogger_Field = mapFogger["fogger_Field"];
    this._fogger_onSec = mapFogger["fogger_onSec"];
    this._fogger_tempDegree = mapFogger["fogger_tempDegree"];
    this._fogger_hum = mapFogger["fogger_hum"];
    this._fogger_DateCreated = mapFogger["fogger_DateCreated"];
    this._fogger_configString = mapFogger["fogger_configString"];
  }
}
