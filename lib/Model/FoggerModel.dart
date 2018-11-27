import 'package:autoaqua/Utils/Database_Client.dart';

class FoggerModel {
  int _foggerId;
  int fogger_controllerID;
  String _foggingType;
  String _fogger_foggerDelay;
  String _fogger_Field;
  String _fogger_onSec;
  String _fogger_minTemp;
  String _fogger_maxTemp;
  String _fogger_minHum;
  String _fogger_maxHum;
  String _fogger_DateCreated;
  String _fogger_configString;

  FoggerModel(
      this.fogger_controllerID,
      this._foggingType,
      this._fogger_foggerDelay,
      this._fogger_Field,
      this._fogger_onSec,
      this._fogger_minTemp,
      this._fogger_maxTemp,
      this._fogger_minHum,
      this._fogger_maxHum,
      this._fogger_DateCreated,
      this._fogger_configString);

  FoggerModel.map(dynamic obj) {
    this._foggerId = obj["foggerId"];
    this.fogger_controllerID = obj["fogger_controllerId"];
    this._foggingType = obj["fogger_maxRTU"];
    this._fogger_foggerDelay= obj["fogger_foggerDelay"];
    this._fogger_Field = obj["fogger_Field"];
    this._fogger_onSec = obj["fogger_onSec"];
    this._fogger_minTemp = obj["fogger_tempDegree"];
    this._fogger_maxTemp = obj["fogger_maxTemp"];
    this._fogger_minHum = obj["fogger_hum"];
    this._fogger_maxHum = obj["fogger_maxHum"];
    this._fogger_DateCreated = obj["fogger_DateCreated"];
    this._fogger_configString = obj["fogger_configString"];
  }

  set foggerId(int value) => _foggerId = value;

  int get foggerId => _foggerId;
  int get fogger_controllerId => fogger_controllerID;
  String get fogger_maxRTU => _foggingType;
  String get fogger_foggerDelay => _fogger_foggerDelay;
  String get  fogger_Field => _fogger_Field;
  String get fogger_onSec => _fogger_onSec;
  String get fogger_tempDegree => _fogger_minTemp;
  String get fogger_maxTemp => _fogger_maxTemp;
  String get fogger_hum => _fogger_minHum;
  String get fogger_maxHum => _fogger_maxHum;
  String get fogger_DateCreated => _fogger_DateCreated;
  String get fogger_configString => _fogger_configString;

  Map<String, dynamic> tomap_Fogger(){
    var mapFogger = new Map<String, dynamic>();
    if(foggerId != null){
      mapFogger["foggerId"] = _foggerId;
    }
    mapFogger[DataBaseHelper.fogger_controllerCol] = fogger_controllerID;
    mapFogger[DataBaseHelper.foggingTypeCol] = _foggingType;
    mapFogger[DataBaseHelper.fogger_foggerDelayCol] = _fogger_foggerDelay;
    mapFogger[DataBaseHelper.fogger_FieldCol] = _fogger_Field;
    mapFogger[DataBaseHelper.fogger_onSecCol] = _fogger_onSec;
    mapFogger[DataBaseHelper.fogger_minTempCol] = _fogger_minTemp;
    mapFogger[DataBaseHelper.fogger_maxTempCol] = _fogger_maxTemp;
    mapFogger[DataBaseHelper.fogger_minHumCol] = _fogger_minHum;
    mapFogger[DataBaseHelper.fogger_maxHumCol] = _fogger_maxHum;
    mapFogger[DataBaseHelper.fogger_dateCreated] = _fogger_DateCreated;
    mapFogger[DataBaseHelper.fogger_configStringCol] = _fogger_configString;
    return mapFogger;
  }

  FoggerModel.fromMap_Fogger(Map<String, dynamic>mapFogger){
    this._foggerId = mapFogger["foggerId"];
    this.fogger_controllerID = mapFogger["fogger_controllerId"];
    this._foggingType = mapFogger["fogger_maxRTU"];
    this._fogger_foggerDelay= mapFogger["fogger_foggerDelay"];
    this._fogger_Field = mapFogger["fogger_Field"];
    this._fogger_onSec = mapFogger["fogger_onSec"];
    this._fogger_minTemp = mapFogger["fogger_tempDegree"];
    this._fogger_maxTemp = mapFogger["fogger_maxTemp"];
    this._fogger_minHum = mapFogger["fogger_hum"];
    this._fogger_maxHum = mapFogger["fogger_maxHum"];
    this._fogger_DateCreated = mapFogger["fogger_DateCreated"];
    this._fogger_configString = mapFogger["fogger_configString"];
  }
}
