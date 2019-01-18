class ECpHModel{

  int _ECpHID;
  String _ECVal;
  String _pHVal;
  String _sensignDelay;
  String _ECpHDateTime;

  ECpHModel(this._ECVal, this._pHVal, this._sensignDelay, this._ECpHDateTime, [this._ECpHID]);

  ECpHModel.map(dynamic, obj){
    this._ECpHID = obj["ECpHID"];
    this._ECVal  = obj["ECVal"];
    this._pHVal  = obj["pHVal"];
    this._sensignDelay = obj["sensignDelay"];
    this._ECpHDateTime = obj["ECpHDateTime"];
  }

  int get ECpHID => _ECpHID;

  String get ECpHDateTime => _ECpHDateTime;

  String get sensignDelay => _sensignDelay;

  String get pHVal => _pHVal;

  String get ECVal => _ECVal;

  Map<String, dynamic> toECpHMap(){
    final map = Map<String, dynamic>();

    if(_ECpHID != null){
      map["ECpHID"] = _ECpHID;
    }
    map["ECVal"] = _ECVal;
    map["pHVal"] = _pHVal;
    map["sensignDelay"] = _sensignDelay;
    map["ECpHDateTime"] = _ECpHDateTime;

    return map;
  }

  ECpHModel.fromECpHMap(Map<String, dynamic>map){
    this._ECpHID = map["ECpHID"];
    this._ECVal  = map["ECVal"];
    this._pHVal  = map["pHVal"];
    this._sensignDelay = map["sensignDelay"];
    this._ECpHDateTime = map["ECpHDateTime"];
  }

}