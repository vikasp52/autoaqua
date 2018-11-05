class mobNoModel{

  int _mobNoId;
  int _mobNo_controllerId;
  String _mobNo;
  String _mobNo_DateCreated;

  mobNoModel(
      this._mobNo_controllerId,
      this._mobNo,
      this._mobNo_DateCreated,
      [this._mobNoId]
      );

  mobNoModel.map(dynamic obj){
    this._mobNoId = obj["mobNoId"];
    this._mobNo_controllerId = obj["mobNo_controllerId"];
    this._mobNo_DateCreated = obj["mobNo_DateCreated"];
    this._mobNo = obj["mobNo"];
  }

  int get mobNoId => _mobNoId;
  int get mobNo_controllerId => _mobNo_controllerId;
  String get mobNo => _mobNo;
  String get mobNo_DateCreated => _mobNo_DateCreated;

  Map<String, dynamic> toMap_mobNo(){
    var mapMobNo = new Map<String, dynamic>();
    if(mobNoId != null){
      mapMobNo["mobNoId"] = _mobNoId;
    }
    mapMobNo["mobNo_controllerId"] = _mobNo_controllerId;
    mapMobNo["mobNo"] = _mobNo;
    mapMobNo["mobNo_DateCreated"] = _mobNo_DateCreated;

    return mapMobNo;
  }

  mobNoModel.fromMap_mobNo(Map<String, dynamic>mapMobNo){
    this._mobNoId = mapMobNo["mobNoId"];
    this._mobNo_controllerId = mapMobNo["mobNo_controllerId"];
    this._mobNo = mapMobNo["mobNo"];
    this._mobNo_DateCreated = mapMobNo["mobNo_DateCreated"];
  }
}