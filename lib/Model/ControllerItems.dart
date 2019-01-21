import 'package:flutter/material.dart';

class ControllerItem extends StatelessWidget {
  String _itemName;
  String _itemNumber;
  String _dateCreated;
  int _id;
  int _columnHUId;


  ControllerItem(this._columnHUId, this._itemName,this._itemNumber, this._dateCreated);

  ControllerItem.map(dynamic obj){
    this._columnHUId = obj["columnHUId"];
    this._itemName = obj["itemName"];
    this._itemNumber = obj["itemNumber"];
    this._dateCreated = obj["dateCreated"];
    this._id  = obj["id"];
  }

  String get itemName => _itemName;
  String get itemNumber => _itemNumber;
  String get dateCreated => _dateCreated;
  int get id => _id;
  int get columnHUId => _columnHUId;

  Map<String, dynamic> toMap(){
    var map = new Map<String, dynamic>();
    map["columnHUId"] = _columnHUId;
    map["itemName"] = _itemName;
    map["itemNumber"] = _itemNumber;
    map["dateCreated"] = _dateCreated;

    if(_id != null){
      map["id"] = _id;
    }

    return map;
  }

  ControllerItem.fromMap(Map<String, dynamic> map){
    this._columnHUId = map["columnHUId"];
    this._itemName = map["itemName"];
    this._itemNumber = map["itemNumber"];
    this._dateCreated = map["dateCreated"];
    this._id = map["id"];

  }

  @override
  Widget build(BuildContext context) {

    return new ListTile(
      leading: CircleAvatar(
        backgroundColor: Color.fromRGBO(0, 84, 179, 1.0),
        child:  Text(
          _itemName[0].toUpperCase(),
          style: new TextStyle(color: Colors.white),
        ),
      ),
      title: Text(_itemName.toUpperCase(), style: TextStyle(
          color: Colors.black, fontWeight: FontWeight.bold
      ),),
      subtitle: Text(_itemNumber, style: TextStyle(
          color: Colors.black, fontWeight: FontWeight.bold
      ),),
    );
  }
}
