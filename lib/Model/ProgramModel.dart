class ProgramModel{

  int _programID;
  int program_Controller_Id;
  String _proramMode;
  String _programFlushType;
  String _programInterval;
  String _programFlushOn;
  String _programIntegrationType;
  String _programDateCreated;

  ProgramModel(
      this.program_Controller_Id,
      this._proramMode,
      this._programFlushType,
      this._programInterval,
      this._programFlushOn,
      this._programIntegrationType,
      this._programDateCreated,
      [this._programID]
      );

  ProgramModel.map(dynamic obj){
    this._programID = obj["programID"];
    this.program_Controller_Id = obj["program_controller_id"];
    this._proramMode = obj["program_mode"];
    this._programFlushType = obj["program_flushtype"];
    this._programInterval = obj["program_interval"];
    this._programFlushOn = obj["program_flushon"];
    this._programIntegrationType = obj["program_integrationtype"];
    this._programDateCreated = obj["program_DateCreated"];
  }

  int get programID => _programID;
  int get program_controller_id => program_Controller_Id;
  String get program_mode => _proramMode;
  String get program_flushtype => _programFlushType;
  String get program_interval => _programInterval;
  String get program_flushon => _programFlushOn;
  String get program_integrationtype => _programIntegrationType;
  String get program_DateCreated => _programDateCreated;

  Map<String, dynamic> toMap_program(){
    var map_program = new Map<String, dynamic>();
    if(_programID != null){
      map_program["programID"] = _programID;
    }
    map_program["program_controller_id"] = program_Controller_Id;
    map_program["program_mode"] = _proramMode;
    map_program["program_flushtype"] = _programFlushType;
    map_program["program_interval"] = _programInterval;
    map_program["program_flushon"] = _programFlushOn;
    map_program["program_integrationtype"] = _programIntegrationType;
    map_program["program_DateCreated"] = _programDateCreated;
    return map_program;
  }

  ProgramModel.fromMap_program(Map<String, dynamic> map){
    this._programID = map["programID"];
    this.program_Controller_Id = map["program_controller_id"];
    this._proramMode = map["program_mode"];
    this._programFlushType = map["program_flushtype"];
    this._programInterval = map["program_interval"];
    this._programFlushOn = map["program_flushon"];
    this._programIntegrationType = map["program_integrationtype"];
    this._programDateCreated = map["program_DateCreated"];
  }


}