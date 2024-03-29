class ValvesModel {
  int _valvesId;
  int valves_controllerId;
  int _valvesProgramNo;
  int _valvesSeqNo;
  String _valves_UniteType;
  String _valves_VolveNo1;
  String _valves_VolveNo2;
  String _valves_VolveNo3;
  String _valves_VolveNo4;
  String _valves_fieldNo_1;
  String _valves_fieldNo_2;
  String _valves_fieldNo_3;
  String _valves_fieldNo_4;
  String _valves_tank_1;
  String _valves_tank_2;
  String _valves_tank_3;
  String _valves_tank_4;
  String _valves_FertlizerProgramming;
  String _valves_FertlizerPreDelay;
  String _valves_FertlizerPostDelay;
  String _valves_ECSetp;
  String _valves_PHSetp;
  String _valves_String;
  String _valves_DateCreated;


  ValvesModel(
      this.valves_controllerId,
      this._valvesProgramNo,
      this._valvesSeqNo,
      this._valves_UniteType,
      this._valves_VolveNo1,
      this._valves_VolveNo2,
      this._valves_VolveNo3,
      this._valves_VolveNo4,
      this._valves_fieldNo_1,
      this._valves_fieldNo_2,
      this._valves_fieldNo_3,
      this._valves_fieldNo_4,
      this._valves_tank_1,
      this._valves_tank_2,
      this._valves_tank_3,
      this._valves_tank_4,
      this._valves_FertlizerProgramming,
      this._valves_FertlizerPreDelay,
      this._valves_FertlizerPostDelay,
      this._valves_ECSetp,
      this._valves_PHSetp,
      this._valves_String,
      this._valves_DateCreated);

  ValvesModel.map(dynamic obj) {
    this._valvesId = obj["valvesId"];
    this.valves_controllerId = obj["valves_controller_id"];
    this._valvesProgramNo = obj["valves_ProgramNo"];
    this._valvesSeqNo = obj["valves_SeqNo"];
    this._valves_UniteType = obj["valves_UniteType"];
    this._valves_VolveNo1 = obj["valves_VolveNo1"];
    this._valves_VolveNo2 = obj["valves_VolveNo2"];
    this._valves_VolveNo3 = obj["valves_VolveNo3"];
    this._valves_VolveNo4 = obj["valves_VolveNo4"];
    this._valves_fieldNo_1 = obj["valves_fieldNo_1"];
    this._valves_fieldNo_2 = obj["valves_fieldNo_2"];
    this._valves_fieldNo_3 = obj["valves_fieldNo_3"];
    this._valves_fieldNo_4 = obj["valves_fieldNo_4"];
    this._valves_tank_1 = obj["valves_tank_1"];
    this._valves_tank_2 = obj["valves_tank_2"];
    this._valves_tank_3 = obj["valves_tank_3"];
    this._valves_tank_4 = obj["valves_tank_4"];
    this._valves_FertlizerProgramming = obj["valves_FertlizerProgramming"];
    this._valves_FertlizerPreDelay = obj["valves_FertlizerPreDelay"];
    this._valves_FertlizerPostDelay = obj["valves_FertlizerPostDelay"];
    this._valves_ECSetp = obj["valves_ECSetp"];
    this._valves_PHSetp = obj["valves_PHSetp"];
    this._valves_String = obj["valves_String"];
    this._valves_DateCreated = obj["valves_DateCreated"];
  }

  set valvesId(int value) => _valvesId = value;

  int get valvesId => _valvesId;
  int get valves_controller_id => valves_controllerId;
  int get valves_ProgramNo => _valvesProgramNo;
  int get valves_SeqNo => _valvesSeqNo;
  String get valves_UniteType => _valves_UniteType;
  String get valves_VolveNo1 => _valves_VolveNo1;
  String get valves_VolveNo2 => _valves_VolveNo2;
  String get valves_VolveNo3 => _valves_VolveNo3;
  String get valves_VolveNo4 => _valves_VolveNo4;
  String get valves_fieldNo_1 => _valves_fieldNo_1;
  String get valves_fieldNo_2 => _valves_fieldNo_2;
  String get valves_fieldNo_3 => _valves_fieldNo_3;
  String get valves_fieldNo_4 => _valves_fieldNo_4;
  String get valves_tank_1 => _valves_tank_1;
  String get valves_tank_2 => _valves_tank_2;
  String get valves_tank_3 => _valves_tank_3;
  String get valves_tank_4 => _valves_tank_4;
  String get valves_FertlizerProgramming => _valves_FertlizerProgramming;
  String get valves_FertlizerPreDelay => _valves_FertlizerPreDelay;
  String get valves_FertlizerPostDelay => _valves_FertlizerPostDelay;
  String get valves_ECSetp => _valves_ECSetp;
  String get valves_PHSetp => _valves_PHSetp;
  String get valves_String => _valves_String;
  String get valves_DateCreated => _valves_DateCreated;

  Map<String, dynamic> toMap_Valves() {
    var map_Valves = new Map<String, dynamic>();
    map_Valves["valves_controller_id"] = valves_controllerId;
    map_Valves["valves_ProgramNo"] = _valvesProgramNo;
    map_Valves["valves_SeqNo"] = _valvesSeqNo;
    map_Valves["valves_UniteType"] = _valves_UniteType;
    map_Valves["valves_VolveNo1"] = _valves_VolveNo1;
    map_Valves["valves_VolveNo2"] = _valves_VolveNo2;
    map_Valves["valves_VolveNo3"] = _valves_VolveNo3;
    map_Valves["valves_VolveNo4"] = _valves_VolveNo4;
    map_Valves["valves_fieldNo_1"] = _valves_fieldNo_1;
    map_Valves["valves_fieldNo_2"] = _valves_fieldNo_2;
    map_Valves["valves_fieldNo_3"] = _valves_fieldNo_3;
    map_Valves["valves_fieldNo_4"] = _valves_fieldNo_4;
    map_Valves["valves_tank_1"] = _valves_tank_1;
    map_Valves["valves_tank_2"] = _valves_tank_2;
    map_Valves["valves_tank_3"] = _valves_tank_3;
    map_Valves["valves_tank_4"] = _valves_tank_4;
    map_Valves["valves_FertlizerProgramming"] = _valves_FertlizerProgramming;
    map_Valves["valves_FertlizerPreDelay"] = _valves_FertlizerPreDelay;
    map_Valves["valves_FertlizerPostDelay"] = _valves_FertlizerPostDelay;
    map_Valves["valves_ECSetp"] = _valves_ECSetp;
    map_Valves["valves_PHSetp"] = _valves_PHSetp;
    map_Valves["valves_String"] = _valves_String;
    map_Valves["valves_DateCreated"] = _valves_DateCreated;

    if (_valvesId != null) {
      map_Valves["valvesId"] = _valvesId;
    }
    return map_Valves;
  }

  ValvesModel.fromMap_Valves(Map<String, dynamic> map) {
    this._valvesId = map["valvesId"];
    this.valves_controllerId = map["valves_controller_id"];
    this._valvesProgramNo = map["valves_ProgramNo"];
    this._valvesSeqNo = map["valves_SeqNo"];
    this._valves_UniteType = map["valves_UniteType"];
    this._valves_VolveNo1 = map["valves_VolveNo1"];
    this._valves_VolveNo2 = map["valves_VolveNo2"];
    this._valves_VolveNo3 = map["valves_VolveNo3"];
    this._valves_VolveNo4 = map["valves_VolveNo4"];
    this._valves_fieldNo_1 = map["valves_fieldNo_1"];
    this._valves_fieldNo_2 = map["valves_fieldNo_2"];
    this._valves_fieldNo_3 = map["valves_fieldNo_3"];
    this._valves_fieldNo_4 = map["valves_fieldNo_4"];
    this._valves_tank_1 = map["valves_tank_1"];
    this._valves_tank_2 = map["valves_tank_2"];
    this._valves_tank_3 = map["valves_tank_3"];
    this._valves_tank_4 = map["valves_tank_4"];
    this._valves_FertlizerProgramming = map["valves_FertlizerProgramming"];
    this._valves_FertlizerPreDelay = map["valves_FertlizerPreDelay"];
    this._valves_FertlizerPostDelay = map["valves_FertlizerPostDelay"];
    this._valves_ECSetp = map["valves_ECSetp"];
    this._valves_PHSetp = map["valves_PHSetp"];
    this._valves_String = map["valves_String"];
    this._valves_DateCreated = map["valves_DateCreated"];
  }
}
