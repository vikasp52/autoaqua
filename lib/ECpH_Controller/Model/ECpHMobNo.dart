class ECpHmobNoModel{

  int _ECpHmobNoId;
  String _ECpHmobNo;
  String _ECpHmobNo_DateCreated;

  ECpHmobNoModel(
      this._ECpHmobNo,
      this._ECpHmobNo_DateCreated,
      [this._ECpHmobNoId]
      );

  ECpHmobNoModel.map(dynamic obj){
    this._ECpHmobNoId = obj["ECpHmobNoId"];
    this._ECpHmobNo_DateCreated = obj["ECpHmobNo_DateCreated"];
    this._ECpHmobNo = obj["ECpHmobNo"];
  }

  int get ECpHmobNoId => _ECpHmobNoId;
  String get ECpHmobNo => _ECpHmobNo;
  String get ECpHmobNo_DateCreated => _ECpHmobNo_DateCreated;

  Map<String, dynamic> toMap_mobNo(){
    var mapMobNo = new Map<String, dynamic>();
    if(ECpHmobNoId != null){
      mapMobNo["ECpHmobNoId"] = _ECpHmobNoId;
    }
    mapMobNo["ECpHmobNo"] = _ECpHmobNo;
    mapMobNo["ECpHmobNo_DateCreated"] = _ECpHmobNo_DateCreated;

    return mapMobNo;
  }

  ECpHmobNoModel.fromMap_mobNo(Map<String, dynamic>mapMobNo){
    this._ECpHmobNoId = mapMobNo["ECpHmobNoId"];
    this._ECpHmobNo = mapMobNo["ECpHmobNo"];
    this._ECpHmobNo_DateCreated = mapMobNo["ECpHmobNo_DateCreated"];
  }
}