class ValvesModel{

  int _valvesId;
  int valves_controllerId;
  int _valvesProgramNo;
  int _valvesSeqNo;
  String _valves_fieldNoLtr;
  String _valves_field_for_Liters;
  String _valves_fieldNoMins;
  String _valves_field_for_Mins;
  String _valves_tank1_Ltr;
  String _valves_tank1_Min;
  String _valves_tank2_Ltr;
  String _valves_tank2_Min;
  String _valves_tank3_Ltr;
  String _valves_tank3_Min;
  String _valves_tank4_Ltr;
  String _valves_tank4_Min;
  String _valves_FertlizerType;
  String _valves_FertlizerDelay_Ltr;
  String _valves_FertlizerDelay_Min;
  String _valves_ECSetp;
  String _valves_PHSetp;
  String _valves_DateCreated;

  ValvesModel(this.valves_controllerId, this._valvesProgramNo,
      this._valvesSeqNo, this._valves_fieldNoLtr, this._valves_field_for_Liters,
      this._valves_fieldNoMins, this._valves_field_for_Mins,
      this._valves_tank1_Ltr, this._valves_tank1_Min, this._valves_tank2_Ltr,
      this._valves_tank2_Min, this._valves_tank3_Ltr, this._valves_tank3_Min,
      this._valves_tank4_Ltr, this._valves_tank4_Min,
      this._valves_FertlizerType, this._valves_FertlizerDelay_Ltr,
      this._valves_FertlizerDelay_Min, this._valves_ECSetp,
      this._valves_PHSetp, this._valves_DateCreated);

  ValvesModel.map(dynamic obj){
    this._valvesId = obj["valvesId"];
    this.valves_controllerId = obj["valves_controller_id"];
    this._valvesProgramNo = obj["valves_ProgramNo"];
    this._valvesSeqNo = obj["valves_SeqNo"];
    this._valves_fieldNoLtr = obj["valves_fieldNo_for_Ltrs"];
    this._valves_field_for_Liters = obj["valves_field_Ltrs"];
    this._valves_fieldNoMins = obj["valves_fieldNo_for_Mins"];
    this._valves_field_for_Mins = obj["valves_field_Mins"];
    this._valves_tank1_Ltr = obj["valves_tank1_Ltr"];
    this._valves_tank1_Min = obj["valves_tank1_Min"];
    this._valves_tank2_Ltr = obj["valves_tank2_Ltr"];
    this._valves_tank2_Min = obj["valves_tank2_Min"];
    this._valves_tank3_Ltr = obj["valves_tank3_Ltr"];
    this._valves_tank3_Min = obj["valves_tank3_Min"];
    this._valves_tank4_Ltr = obj["valves_tank4_Ltr"];
    this._valves_tank4_Min = obj["valves_tank4_Min"];
    this._valves_FertlizerType = obj["valves_FertlizerType"];
    this._valves_FertlizerDelay_Ltr = obj["valves_FertlizerDelay_Litr"];
    this._valves_FertlizerDelay_Min = obj["valves_FertlizerDelay_Min"];
    this._valves_ECSetp = obj["valves_ECSetp"];
    this._valves_PHSetp = obj["valves_PHSetp"];
    this._valves_DateCreated = obj["valves_DateCreated"];
  }

  int get valvesId => _valvesId;
  int get valves_controller_id => valves_controllerId;
  int get valves_ProgramNo => _valvesProgramNo;
  int get valves_SeqNo => _valvesSeqNo;
  String get valves_fieldNo_for_Ltrs => _valves_fieldNoLtr;
  String get valves_field_Ltrs => _valves_field_for_Liters;
  String get valves_fieldNo_for_Mins => _valves_fieldNoMins;
  String get valves_field_Mins => _valves_field_for_Mins;
  String get valves_tank1_Ltr => _valves_tank1_Ltr;
  String get valves_tank1_Min => _valves_tank1_Min;
  String get valves_tank2_Ltr => _valves_tank2_Ltr;
  String get valves_tank2_Min => _valves_tank2_Min;
  String get valves_tank3_Ltr => _valves_tank3_Ltr;
  String get valves_tank3_Min => _valves_tank3_Min;
  String get valves_tank4_Ltr => _valves_tank4_Ltr;
  String get valves_tank4_Min => _valves_tank4_Min;
  String get valves_FertlizerType => _valves_FertlizerType;
  String get valves_FertlizerDelay_Litr => _valves_FertlizerDelay_Ltr;
  String get valves_FertlizerDelay_Min => _valves_FertlizerDelay_Min;
  String get valves_ECSetp => _valves_ECSetp;
  String get valves_PHSetp => _valves_PHSetp;
  String get valves_DateCreated => _valves_DateCreated;

  Map<String, dynamic> toMap_Valves(){
    var map_Valves = new Map<String, dynamic>();
    map_Valves["valves_controller_id"] = valves_controllerId;
    map_Valves["valves_ProgramNo"] = _valvesProgramNo;
    map_Valves["valves_SeqNo"] = _valvesSeqNo;
    map_Valves["valves_fieldNo_for_Ltrs"] = _valves_fieldNoLtr;
    map_Valves["valves_field_Ltrs"] = _valves_field_for_Liters;
    map_Valves["valves_fieldNo_for_Mins"] = _valves_fieldNoMins;
    map_Valves["valves_field_Mins"] = _valves_field_for_Mins;
    map_Valves["valves_tank1_Ltr"] = _valves_tank1_Ltr;
    map_Valves["valves_tank1_Min"] = _valves_tank1_Min;
    map_Valves["valves_tank2_Ltr"] = _valves_tank2_Ltr;
    map_Valves["valves_tank2_Min"] = _valves_tank2_Min;
    map_Valves["valves_tank3_Ltr"] = _valves_tank3_Ltr;
    map_Valves["valves_tank3_Min"] = _valves_tank3_Min;
    map_Valves["valves_tank4_Ltr"] = _valves_tank4_Ltr;
    map_Valves["valves_tank4_Min"] = _valves_tank4_Min;
    map_Valves["valves_FertlizerType"] = _valves_FertlizerType;
    map_Valves["valves_FertlizerDelay_Litr"] = _valves_FertlizerDelay_Ltr;
    map_Valves["valves_FertlizerDelay_Min"] = _valves_FertlizerDelay_Min;
    map_Valves["valves_ECSetp"] = _valves_ECSetp;
    map_Valves["valves_PHSetp"] = _valves_PHSetp;
    map_Valves["valves_DateCreated"] = _valves_DateCreated;

    if(_valvesId != null){
      map_Valves["valvesId"] = _valvesId;
    }
    return map_Valves;
  }

  ValvesModel.fromMap_Valves(Map<String, dynamic> map){
    this._valvesId = map["valvesId"];
    this.valves_controllerId = map["valves_controller_id"];
    this._valvesProgramNo = map["valves_ProgramNo"];
    this._valvesSeqNo = map["valves_SeqNo"];
    this._valves_fieldNoLtr = map["valves_fieldNo_for_Ltrs"];
    this._valves_field_for_Liters = map["valves_field_Ltrs"];
    this._valves_fieldNoMins = map["valves_fieldNo_for_Mins"];
    this._valves_field_for_Mins = map["valves_field_Mins"];
    this._valves_tank1_Ltr = map["valves_tank1_Ltr"];
    this._valves_tank1_Min = map["valves_tank1_Min"];
    this._valves_tank2_Ltr = map["valves_tank2_Ltr"];
    this._valves_tank2_Min = map["valves_tank2_Min"];
    this._valves_tank3_Ltr = map["valves_tank3_Ltr"];
    this._valves_tank3_Min = map["valves_tank3_Min"];
    this._valves_tank4_Ltr = map["valves_tank4_Ltr"];
    this._valves_tank4_Min = map["valves_tank4_Min"];
    this._valves_FertlizerType = map["valves_FertlizerType"];
    this._valves_FertlizerDelay_Ltr = map["valves_FertlizerDelay_Litr"];
    this._valves_FertlizerDelay_Min = map["valves_FertlizerDelay_Min"];
    this._valves_ECSetp = map["valves_ECSetp"];
    this._valves_PHSetp = map["valves_PHSetp"];
    this._valves_DateCreated = map["valves_DateCreated"];
  }

}