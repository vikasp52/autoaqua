class ECpHScheduleModel{

  int _ECpHScheduleId;
  String _ECpHStartTimeHrs;
  String _ECpHStartTimeMin;
  String _ECpHEndTimeHrs;
  String _ECpHEndTimeMin;
  String _ECpHIntegrationDay_Mon;
  String _ECpHIntegrationDay_Tues;
  String _ECpHIntegrationDay_Wed;
  String _ECpHIntegrationDay_Thurs;
  String _ECpHIntegrationDay_Fri;
  String _ECpHIntegrationDay_Sat;
  String _ECpHIntegrationDay_Sun;
  String _ECpHScheduleDay_Mon;
  String _ECpHScheduleDay_Tue;
  String _ECpHScheduleDay_Wed;
  String _ECpHScheduleDay_Thurs;
  String _ECpHScheduleDay_Fri;
  String _ECpHScheduleDay_Sat;
  String _ECpHScheduleDay_Sun;
  String _ECpHString;
  String _ECpHDateCreated;

  ECpHScheduleModel(
      this._ECpHStartTimeHrs,
      this._ECpHStartTimeMin,
      this._ECpHEndTimeHrs,
      this._ECpHEndTimeMin,
      this._ECpHIntegrationDay_Mon,
      this._ECpHIntegrationDay_Tues,
      this._ECpHIntegrationDay_Wed,
      this._ECpHIntegrationDay_Thurs,
      this._ECpHIntegrationDay_Fri,
      this._ECpHIntegrationDay_Sat,
      this._ECpHIntegrationDay_Sun,
      this._ECpHScheduleDay_Mon,
      this._ECpHScheduleDay_Tue,
      this._ECpHScheduleDay_Wed,
      this._ECpHScheduleDay_Thurs,
      this._ECpHScheduleDay_Fri,
      this._ECpHScheduleDay_Sat,
      this._ECpHScheduleDay_Sun,
      this._ECpHString,
      this._ECpHDateCreated,
      [this._ECpHScheduleId]);

    ECpHScheduleModel.map(dynamic obj) {
       this._ECpHScheduleId = obj["ECpHScheduleId"];
       this._ECpHStartTimeHrs = obj["ECpHStartTimeHrs"];
       this._ECpHStartTimeMin = obj["ECpHStartTimeMin"];
       this._ECpHEndTimeHrs = obj["ECpHEndTimeHrs"];
       this._ECpHEndTimeMin = obj["ECpHEndTimeMin"];
       this._ECpHIntegrationDay_Mon = obj["ECpHIntegrationDay_Mon"];
       this._ECpHIntegrationDay_Tues = obj["ECpHIntegrationDay_Tue"];
       this._ECpHIntegrationDay_Wed = obj["ECpHIntegrationDay_Wed"];
       this._ECpHIntegrationDay_Thurs = obj["ECpHIntegrationDay_Thur"];
       this._ECpHIntegrationDay_Fri = obj["ECpHIntegrationDay_Fri"];
       this._ECpHIntegrationDay_Sat = obj["ECpHIntegrationDay_Sat"];
       this._ECpHIntegrationDay_Sun = obj["ECpHIntegrationDay_Sun"];
       this._ECpHScheduleDay_Mon = obj["ECpHScheduleDay_Mon"];
       this._ECpHScheduleDay_Tue = obj["ECpHScheduleDay_Tue"];
       this._ECpHScheduleDay_Wed = obj["ECpHScheduleDay_Wed"];
       this._ECpHScheduleDay_Thurs = obj["ECpHScheduleDay_Thur"];
       this._ECpHScheduleDay_Fri = obj["ECpHScheduleDay_Fri"];
       this._ECpHScheduleDay_Sat = obj["ECpHScheduleDay_Sat"];
       this._ECpHScheduleDay_Sun = obj["ECpHScheduleDay_Sun"];
       this._ECpHString = obj["ECpHString"];
       this._ECpHDateCreated = obj["ECpHDateCreated"];
     }

  String get ECpHDateCreated => _ECpHDateCreated;

  String get ECpHString => _ECpHString;

  String get ECpHScheduleDay_Sun => _ECpHScheduleDay_Sun;

  String get ECpHScheduleDay_Sat => _ECpHScheduleDay_Sat;

  String get ECpHScheduleDay_Fri => _ECpHScheduleDay_Fri;

  String get ECpHScheduleDay_Thur => _ECpHScheduleDay_Thurs;

  String get ECpHScheduleDay_Wed => _ECpHScheduleDay_Wed;

  String get ECpHScheduleDay_Tue => _ECpHScheduleDay_Tue;

  String get ECpHScheduleDay_Mon => _ECpHScheduleDay_Mon;

  String get ECpHIntegrationDay_Sun => _ECpHIntegrationDay_Sun;

  String get ECpHIntegrationDay_Sat => _ECpHIntegrationDay_Sat;

  String get ECpHIntegrationDay_Fri => _ECpHIntegrationDay_Fri;

  String get ECpHIntegrationDay_Thur => _ECpHIntegrationDay_Thurs;

  String get ECpHIntegrationDay_Wed => _ECpHIntegrationDay_Wed;

  String get ECpHIntegrationDay_Tue => _ECpHIntegrationDay_Tues;

  String get ECpHIntegrationDay_Mon => _ECpHIntegrationDay_Mon;

  String get ECpHEndTimeMin => _ECpHEndTimeMin;

  String get ECpHEndTimeHrs => _ECpHEndTimeHrs;

  String get ECpHStartTimeMin => _ECpHStartTimeMin;

  String get ECpHStartTimeHrs => _ECpHStartTimeHrs;

  int get ECpHScheduleId => _ECpHScheduleId;

  Map<String, dynamic> toMapECpHSchedule(){
    var mapECpH = Map<String, dynamic>();
    if(ECpHScheduleId != null){
      mapECpH["ECpHScheduleId"] = _ECpHScheduleId;
    }
    mapECpH["ECpHStartTimeHrs"] = _ECpHStartTimeHrs;
    mapECpH["ECpHStartTimeMin"] = _ECpHStartTimeMin;
    mapECpH["ECpHEndTimeHrs"] = _ECpHEndTimeHrs;
    mapECpH["ECpHEndTimeMin"] = _ECpHEndTimeMin;
    mapECpH["ECpHIntegrationDay_Mon "] = _ECpHIntegrationDay_Mon ;
    mapECpH["ECpHIntegrationDay_Tue"] = _ECpHIntegrationDay_Tues;
    mapECpH["ECpHIntegrationDay_Wed "] = _ECpHIntegrationDay_Wed ;
    mapECpH["ECpHIntegrationDay_Thur"] = _ECpHIntegrationDay_Thurs;
    mapECpH["ECpHIntegrationDay_Fri"] = _ECpHIntegrationDay_Fri;
    mapECpH["ECpHIntegrationDay_Sat"] = _ECpHIntegrationDay_Sat;
    mapECpH["ECpHIntegrationDay_Sun"] = _ECpHIntegrationDay_Sun;
    mapECpH["ECpHScheduleDay_Mon"] =  _ECpHScheduleDay_Mon;
    mapECpH["ECpHScheduleDay_Tue"] =  _ECpHScheduleDay_Tue;
    mapECpH["ECpHScheduleDay_Wed"] =  _ECpHScheduleDay_Wed;
    mapECpH["ECpHScheduleDay_Thur"] =  _ECpHScheduleDay_Thurs;
    mapECpH["ECpHScheduleDay_Fri"] =  _ECpHScheduleDay_Fri;
    mapECpH["ECpHScheduleDay_Sat"] =  _ECpHScheduleDay_Sat;
    mapECpH["ECpHScheduleDay_Sun"] =  _ECpHScheduleDay_Sun;
    mapECpH["ECpHString"] = _ECpHString;
    mapECpH["ECpHDateCreated"] = _ECpHDateCreated;

    return mapECpH;
  }

  ECpHScheduleModel.fromMapECpHSchedule(Map<String, dynamic>mapECpH){
    this._ECpHScheduleId = mapECpH["ECpHScheduleId"];
    this._ECpHStartTimeHrs = mapECpH["ECpHStartTimeHrs"];
    this._ECpHStartTimeMin = mapECpH["ECpHStartTimeMin"];
    this._ECpHEndTimeHrs = mapECpH["ECpHEndTimeHrs"];
    this._ECpHEndTimeMin = mapECpH["ECpHEndTimeMin"];
    this._ECpHIntegrationDay_Mon = mapECpH["ECpHIntegrationDay_Mon"];
    this._ECpHIntegrationDay_Tues = mapECpH["ECpHIntegrationDay_Tue"];
    this._ECpHIntegrationDay_Wed = mapECpH["ECpHIntegrationDay_Wed"];
    this._ECpHIntegrationDay_Thurs = mapECpH["ECpHIntegrationDay_Thur"];
    this._ECpHIntegrationDay_Fri = mapECpH["ECpHIntegrationDay_Fri"];
    this._ECpHIntegrationDay_Sat = mapECpH["ECpHIntegrationDay_Sat"];
    this._ECpHIntegrationDay_Sun = mapECpH["ECpHIntegrationDay_Sun"];
    this._ECpHScheduleDay_Mon = mapECpH["ECpHScheduleDay_Mon"];
    this._ECpHScheduleDay_Tue = mapECpH["ECpHScheduleDay_Tue"];
    this._ECpHScheduleDay_Wed = mapECpH["ECpHScheduleDay_Wed"];
    this._ECpHScheduleDay_Thurs = mapECpH["ECpHScheduleDay_Thur"];
    this._ECpHScheduleDay_Fri = mapECpH["ECpHScheduleDay_Fri"];
    this._ECpHScheduleDay_Sat = mapECpH["ECpHScheduleDay_Sat"];
    this._ECpHScheduleDay_Sun = mapECpH["ECpHScheduleDay_Sun"];
    this._ECpHString = mapECpH["ECpHString"];
    this._ECpHDateCreated = mapECpH["ECpHDateCreated"];
  }

}