import 'dart:convert' show json;
import 'package:scoped_model/scoped_model.dart';

class ConfigurationModel{
  int _configId;
  String _configMaxProg;
  String _configMaxOutput;
  String _configMobNo;
  String _configNoOfSlaves;
  List<String> _configSlaveMobNos;
  String _configDateCreated;
  int _controllerId;

  ConfigurationModel(
      this._controllerId,
      this._configMaxProg,
      this._configMaxOutput,
      this._configMobNo,
      this._configNoOfSlaves,
      this._configSlaveMobNos,
      this._configDateCreated,
      [this._configId]);

  ConfigurationModel.map(dynamic obj) {
    this._configId = obj["configid"];
    this._controllerId = obj["controllerId"];
    this._configMaxProg = obj["configMaxProg"];
    this._configMaxOutput = obj["configMaxOutput"];
    this._configMobNo = obj["configMobNo"];
    this._configSlaveMobNos = obj["configSlaveMobNos"];
    this._configNoOfSlaves = obj["configNoOfSlaves"];
    this._configDateCreated = obj["ConfigDateCreated"];
  }

  String get configMaxProg => _configMaxProg;

  String get configMaxOutput => _configMaxOutput;

  String get configMobNo => _configMobNo;

  String get configNoOfSlaves => _configNoOfSlaves;

  List<String> get slaveMobNos => List.unmodifiable(_configSlaveMobNos);

  String get ConfigDateCreated => _configDateCreated;

  int get configid => _configId;

  int get controllerId => _controllerId;

  Map<String, dynamic> toDbMap() {
    final map = new Map<String, dynamic>();
    if (_configId != null) {
      map["configid"] = _configId;
    }
    map["controllerId"] = _controllerId;
    map["configMaxProg"] = _configMaxProg;
    map["configMaxOutput"] = _configMaxOutput;
    map["configMobNo"] = _configMobNo;
    map["configNoOfSlaves"] = _configNoOfSlaves;
    map["configSlaveMobNos"] = json.encode(_configSlaveMobNos);
    map["ConfigDateCreated"] = _configDateCreated;
    return map;
  }

  ConfigurationModel.fromDbMap(Map<String, dynamic> map) {
    this._configId = map["configid"];
    this._controllerId = map["controllerId"];
    this._configMaxProg = map["configMaxProg"];
    this._configMaxOutput = map["configMaxOutput"];
    this._configMobNo = map["configMobNo"];
    this._configNoOfSlaves = map["configNoOfSlaves"];
    this._configSlaveMobNos = List.castFrom<dynamic, String>(
      json.decode(map["configSlaveMobNos"]),
    );
    this._configDateCreated = map["ConfigDateCreated"];
  }

  @override
  String toString() {
    return 'ConfigurationModel${toDbMap().toString()}';
  }
}
