import 'package:flutter/material.dart';

class HUModel extends StatelessWidget {

  int _HUId;
  String _HUName;
  String _HUCreatedDate;

  HUModel(this._HUName, this._HUCreatedDate);

  HUModel.map(dynamic obj){
    this._HUId = obj["HUId"];
    this._HUName = obj["HUName"];
    this._HUCreatedDate = obj["HUCreatedDate"];
  }

  int get HUId => _HUId;

  String get HUName => _HUName;

  String get HUCreatedDate => _HUCreatedDate;

  Map<String, dynamic> toMap(){
    var map = Map<String, dynamic>();
    map["HUName"] = _HUName;
    map["HUCreatedDate"] = _HUCreatedDate;

    if(_HUId != null){
      map["HUId"] = _HUId;
    }
    return map;
  }

  HUModel.fromMap(Map<String, dynamic> map){
    this._HUId = map["HUId"];
    this._HUName = map["HUName"];
    this._HUCreatedDate = map["HUCreatedDate"];
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Color.fromRGBO(0, 84, 179, 1.0),
        child:  Text(
          _HUName[0].toUpperCase(),
          style: new TextStyle(color: Colors.white),
        ),
      ),
      title: Text(_HUName.toUpperCase(), style: TextStyle(
          color: Colors.black, fontWeight: FontWeight.bold
      ),),
    );
  }
}


