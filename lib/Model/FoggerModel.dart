import 'package:autoaqua/Utils/Database_Client.dart';

class FoggerModel {
  int _foggerId;
  int fogger_controllerID;
  String _fogger_Field;
  String _fogger_onSec;
  String _fogger_tempDegree;
  String _fogger_hum;
  String _fogger_DateCreated;

  FoggerModel(
      this.fogger_controllerID, this._fogger_Field, this._fogger_onSec, this._fogger_tempDegree, this._fogger_hum, this._fogger_DateCreated);

  FoggerModel.map(dynamic obj) {
    this._foggerId = obj["foggerId"];
    this.fogger_controllerID = obj["fogger_controllerId"];
    this._fogger_Field = obj["fogger_Field"];
    this._fogger_onSec = obj["fogger_onSec"];
    this._fogger_tempDegree = obj["fogger_tempDegree"];
    this._fogger_hum = obj["fogger_hum"];
    this._fogger_DateCreated = obj["fogger_DateCreated"];
  }

  set foggerId(int value) => _foggerId = value;

  int get foggerId => _foggerId;
  int get fogger_controllerId => fogger_controllerID;
  String get  fogger_Field => _fogger_Field;
  String get fogger_onSec => _fogger_onSec;
  String get fogger_tempDegree => _fogger_tempDegree;
  String get fogger_hum => _fogger_hum;
  String get fogger_DateCreated => _fogger_DateCreated;

  Map<String, dynamic> tomap_Fogger(){
    var mapFogger = new Map<String, dynamic>();
    if(foggerId != null){
      mapFogger["foggerId"] = _foggerId;
    }
    mapFogger[DataBaseHelper.fogger_controllerCol] = fogger_controllerID;
    mapFogger[DataBaseHelper.fogger_FieldCol] = _fogger_Field;
    mapFogger[DataBaseHelper.fogger_onSecCol] = _fogger_onSec;
    mapFogger[DataBaseHelper.fogger_tempDegreeCol] = _fogger_tempDegree;
    mapFogger[DataBaseHelper.fogger_humCol] = _fogger_hum;
    mapFogger[DataBaseHelper.fogger_dateCreated] = _fogger_DateCreated;
    return mapFogger;
  }

  FoggerModel.fromMap_Fogger(Map<String, dynamic>mapFogger){
    this._foggerId = mapFogger["foggerId"];
    this.fogger_controllerID = mapFogger["fogger_controllerId"];
    this._fogger_Field = mapFogger["fogger_Field"];
    this._fogger_onSec = mapFogger["fogger_onSec"];
    this._fogger_tempDegree = mapFogger["fogger_tempDegree"];
    this._fogger_hum = mapFogger["fogger_hum"];
    this._fogger_DateCreated = mapFogger["fogger_DateCreated"];
  }
}
