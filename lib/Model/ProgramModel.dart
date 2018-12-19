class ProgramModel{

  int _programID;
  int program_Controller_Id;
  String _proramMode;
  String _program_flushMode;
  String _programFlushType;
  String _programInterval;
  String _programFlushOn;
  String _programIrrigationType;
  String _program_fertilizationtype;
  String _program_sensorOverride;
  String _programDateCreated;
  String _program_String;

  ProgramModel(
      this.program_Controller_Id,
      this._proramMode,
      this._program_flushMode,
      this._programFlushType,
      this._programInterval,
      this._programFlushOn,
      this._programIrrigationType,
      this._program_fertilizationtype,
      this._program_sensorOverride,
      this._programDateCreated,
      this._program_String,
      [this._programID]
      );

  ProgramModel.map(dynamic obj){
    this._programID = obj["programID"];
    this.program_Controller_Id = obj["program_controller_id"];
    this._proramMode = obj["program_mode"];
    this._program_flushMode = obj["program_flushMode"];
    this._programFlushType = obj["program_flushtype"];
    this._programInterval = obj["program_interval"];
    this._programFlushOn = obj["program_flushon"];
    this._programIrrigationType = obj["program_irrigationtype"];
    this._program_fertilizationtype = obj["program_fertilizationtype"];
    this._program_sensorOverride = obj["program_sensorOverride"];
    this._programDateCreated = obj["program_DateCreated"];
    this._program_String = obj["program_String"];
  }

  int get programID => _programID;
  int get program_controller_id => program_Controller_Id;
  String get program_mode => _proramMode;
  String get program_flushMode => _program_flushMode;
  String get program_flushtype => _programFlushType;
  String get program_interval => _programInterval;
  String get program_flushon => _programFlushOn;
  String get program_irrigationtype => _programIrrigationType;
  String get program_fertilizationtype => _program_fertilizationtype;
  String get program_sensorOverride => _program_sensorOverride;
  String get program_DateCreated => _programDateCreated;
  String get program_String => _program_String;

  Map<String, dynamic> toMap_program(){
    var map_program = new Map<String, dynamic>();
    if(_programID != null){
      map_program["programID"] = _programID;
    }
    map_program["program_controller_id"] = program_Controller_Id;
    map_program["program_mode"] = _proramMode;
    map_program["program_flushMode"] = _program_flushMode;
    map_program["program_flushtype"] = _programFlushType;
    map_program["program_interval"] = _programInterval;
    map_program["program_flushon"] = _programFlushOn;
    map_program["program_irrigationtype"] = _programIrrigationType;
    map_program["program_fertilizationtype"] = _program_fertilizationtype;
    map_program["program_sensorOverride"] = _program_sensorOverride;
    map_program["program_DateCreated"] = _programDateCreated;
    map_program["program_String"] = _program_String;
    return map_program;
  }

  ProgramModel.fromMap_program(Map<String, dynamic> map){
    this._programID = map["programID"];
    this.program_Controller_Id = map["program_controller_id"];
    this._proramMode = map["program_mode"];
    this._program_flushMode = map["program_flushMode"];
    this._programFlushType = map["program_flushtype"];
    this._programInterval = map["program_interval"];
    this._programFlushOn = map["program_flushon"];
    this._programIrrigationType = map["program_irrigationtype"];
    this._program_fertilizationtype = map["program_fertilizationtype"];
    this._program_sensorOverride = map["program_sensorOverride"];
    this._programDateCreated = map["program_DateCreated"];
    this._program_String = map["program_String"];
  }


}