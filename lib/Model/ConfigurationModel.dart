import 'dart:convert' show json;
import 'package:scoped_model/scoped_model.dart';

class ConfigurationModel {
  int _configId;
  String _configMaxProg;
  String _configMaxOutput;
  String _configMaxInjector;
  String _ConfigTotalFoggerValves;
  String _ConfigTotalIrrigationValves;
  String _configEcpHStatus;
  String _configMaxRTUOnOff;
  String _configMaxRTU;
  String _configNoOfSlaves;
  String _ConfigString;
  List<String> _configSlaveMobNos;
  String _configDateCreated;
  String _ConfigfoggerDelay;
  String _configTotalValves;
  String _configRemaningValves;
  int _controllerId;

  ConfigurationModel(
      this._controllerId,
      this._configMaxProg,
      this._configMaxOutput,
      this._configMaxInjector,
      this._ConfigTotalFoggerValves,
      this._ConfigTotalIrrigationValves,
      this._configTotalValves,
      this._configRemaningValves,
      this._configEcpHStatus,
      this._configMaxRTUOnOff,
      this._configMaxRTU,
      this._configNoOfSlaves,
      this._configSlaveMobNos,
      this._configDateCreated,
      this._ConfigString,
      [this._configId]);

  ConfigurationModel.map(dynamic obj) {
    this._configId = obj["configid"];
    this._controllerId = obj["controllerId"];
    this._configMaxProg = obj["configMaxProg"];
    this._configMaxOutput = obj["configMaxOutput"];
    this._configMaxInjector = obj["configMaxInjector"];
    this._configEcpHStatus = obj["configEcpHStatus"];
    this._configMaxRTUOnOff = obj["configMaxRTUOnOff"];
    this._configMaxRTU = obj["configMaxRTU"];
    this._configSlaveMobNos = obj["configSlaveMobNos"];
    this._configNoOfSlaves = obj["configNoOfSlaves"];
    this._configDateCreated = obj["ConfigDateCreated"];
    this._ConfigString = obj["ConfigString"];
    this._ConfigTotalFoggerValves = obj["ConfigmaxFogger"];
    this._ConfigTotalIrrigationValves = obj["ConfigTotalIrrigationValves"];
    this._configTotalValves = obj["configTotalValves"];
    this._configRemaningValves = obj["configRemaningValves"];
    this._ConfigfoggerDelay = obj["ConfigfoggerDelay"];
  }

  String get configMaxProg => _configMaxProg;

  String get configMaxOutput => _configMaxOutput;

  String get configMaxInjector => _configMaxInjector;

  String get configEcpHStatus => _configEcpHStatus;

  String get configMaxRTUOnOff => _configMaxRTUOnOff;

  String get configMaxRTU => _configMaxRTU;

  String get configNoOfSlaves => _configNoOfSlaves;

  List<String> get slaveMobNos => List.unmodifiable(_configSlaveMobNos);

  String get ConfigDateCreated => _configDateCreated;

  int get configid => _configId;

  int get controllerId => _controllerId;

  String get ConfigString => _ConfigString;

  String get ConfigmaxFogger => _ConfigTotalFoggerValves;

  String get ConfigTotalIrrigationValves => _ConfigTotalIrrigationValves;

  String get configTotalValves => _configTotalValves;

  String get configRemaningValves => _configRemaningValves;

  String get ConfigfoggerDelay => _ConfigfoggerDelay;

  Map<String, dynamic> toDbMap() {
    final map = new Map<String, dynamic>();
    if (_configId != null) {
      map["configid"] = _configId;
    }
    map["controllerId"] = _controllerId;
    map["configMaxProg"] = _configMaxProg;
    map["configMaxOutput"] = _configMaxOutput;
    map["configMaxInjector"] = _configMaxInjector;
    map["configEcpHStatus"] = _configEcpHStatus;
    map["configMaxRTUOnOff"] = _configMaxRTUOnOff;
    map["configMaxRTU"] = _configMaxRTU;
    map["configNoOfSlaves"] = _configNoOfSlaves;
    map["configSlaveMobNos"] = json.encode(_configSlaveMobNos);
    map["ConfigDateCreated"] = _configDateCreated;
    map["ConfigString"] = _ConfigString;
    map["ConfigmaxFogger"] = _ConfigTotalFoggerValves;
    map["ConfigfoggerDelay"] = _ConfigfoggerDelay;
    map["ConfigTotalIrrigationValves"] = _ConfigTotalIrrigationValves;
    map["configTotalValves"] = _configTotalValves;
    map["configRemaningValves"] = _configRemaningValves;
    return map;
  }

  ConfigurationModel.fromDbMap(Map<String, dynamic> map) {
    this._configId = map["configid"];
    this._controllerId = map["controllerId"];
    this._configMaxProg = map["configMaxProg"];
    this._configMaxOutput = map["configMaxOutput"];
    this._configMaxInjector = map["configMaxInjector"];
    this._configEcpHStatus = map["configEcpHStatus"];
    this._configMaxRTUOnOff = map["configMaxRTUOnOff"];
    this._configMaxRTU = map["configMaxRTU"];
    this._configNoOfSlaves = map["configNoOfSlaves"];
    this._configSlaveMobNos = List.castFrom<dynamic, String>(
      json.decode(map["configSlaveMobNos"]),
    );
    this._configDateCreated = map["ConfigDateCreated"];
    this._ConfigString = map["ConfigString"];
    this._ConfigTotalFoggerValves = map["ConfigmaxFogger"];
    this._ConfigTotalIrrigationValves = map["ConfigTotalIrrigationValves"];
    this._configTotalValves = map["configTotalValves"];
    this._ConfigfoggerDelay = map["ConfigfoggerDelay"];
    this._configRemaningValves = map["configRemaningValves"];
  }

  @override
  String toString() {
    return 'ConfigurationModel${toDbMap().toString()}';
  }
}
