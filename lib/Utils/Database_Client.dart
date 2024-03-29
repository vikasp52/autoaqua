import 'dart:io';
import 'package:autoaqua/Model/ConfigurationModel.dart';
import 'package:autoaqua/Model/ControllerItems.dart';
import 'package:autoaqua/Model/FoggerModel.dart';
import 'package:autoaqua/Model/HeadUnitModel.dart';
import 'package:autoaqua/Model/MobNoModel.dart';
import 'package:autoaqua/Model/ProgramModel.dart';
import 'package:autoaqua/Model/StringModel.dart';
import 'package:autoaqua/Model/TimerModel.dart';
import 'package:autoaqua/Model/ValvesModel.dart';
import 'package:path/path.dart';
import 'dart:async';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DataBaseHelper {
  static final DataBaseHelper _instance = DataBaseHelper.internal();
  factory DataBaseHelper() => _instance;

  //Head Unit variable
  final String tableHeadUnit = "HeadUnitTable";
  final String HUIdcol = "HUId";
  final String HUNameCol = "HUName";
  final String HUCreatedDateCol = "HUCreatedDate";

  //Controller Variable
  final String tableName = "ControllerTable";
  final String columnId = "id";
  final String columnHUId = "columnHUId";
  final String columnItemName = "itemName";
  final String columnItemNumber = "itemNumber";
  final String columnDateCreated = "dateCreated";

  //Configuration Variable
  final String tableConfigName = "ConfigurationTabe";
  final String controllerIdCol = "controllerId";
  final String configId = "configid";
  final String configMaxProg = "configMaxProg";
  final String configMaxOut = "configMaxOutput";
  final String configMaxInjectorCol = "configMaxInjector";
  final String configEcpHStatusCol = "configEcpHStatus";
  final String configMaxRTUOnOffCol = "configMaxRTUOnOff";
  final String configMaxRTU = "configMaxRTU";
  final String configNoOfSlaves = "configNoOfSlaves";
  final String configSlaveMobNos = "configSlaveMobNos";
  final String configDateCreated = "ConfigDateCreated";
  final String configStringCol = "ConfigString";
  final String configTotalFoggerValvesCol = "ConfigmaxFogger";
  final String configTotalIrrigationValvesCol = "ConfigTotalIrrigationValves";
  final String configTotalValvesCol = "configTotalValves";
  final String configRemaningValvesCol = "configRemaningValves";
  final String configfoggerDelayCol = "ConfigfoggerDelay";

  //Slaves Variable
  final String tableSlaves = "Slave_Table";
  final String slavesidCol = "slaveId";
  final String slave_controllerIdCol = "slave_controller_id";
  final String slave_mobnoCol = "slave_mobNo";
  final String slave_datecreatedCol = "slave_DateCreated";

  //Program Variable
  final String tableProgram = "Program_Table";
  final String programIDCol = "programID";
  final String program_controllerIdCol = "program_controller_id";
  final String program_modelCol = "program_mode";
  final String program_flushModeCol = "program_flushMode";
  final String program_flushtypeCol = "program_flushtype";
  final String program_sensorOverrideCol = "program_sensorOverride";
  final String program_intervalCol = "program_interval";
  final String program_flushonCol = "program_flushon";
  final String program_irrigationtypeCol = "program_irrigationtype";
  final String program_fertilizationtypeCol = "program_fertilizationtype";
  final String program_DateCreatedCol = "program_DateCreated";
  final String program_StringCol = "program_String";

  //VALVES Variable
  final String tableValves = "Valves_Table";
  final String valvesIdCol = "valvesId";
  final String valves_controllerIdCol = "valves_controller_id";
  final String valvesProgramNoCol = "valves_ProgramNo";
  final String valvesSeqNoCol = "valves_SeqNo";
  final String valvesUniteTypeCol = "valves_UniteType";
  final String valves_VolveNo1Col = "valves_VolveNo1";
  final String valves_VolveNo2Col = "valves_VolveNo2";
  final String valves_VolveNo3Col = "valves_VolveNo3";
  final String valves_VolveNo4Col = "valves_VolveNo4";
  final String valves_fieldNo1Col = "valves_fieldNo_1";
  final String valves_fieldNo2Col = "valves_fieldNo_2";
  final String valves_fieldNo3Col = "valves_fieldNo_3";
  final String valves_fieldNo4Col = "valves_fieldNo_4";
  final String valves_tank1_Col = "valves_tank_1";
  final String valves_tank2_Col = "valves_tank_2";
  final String valves_tank3_Col = "valves_tank_3";
  final String valves_tank4_Col = "valves_tank_4";
  final String valves_FertlizerProgramming_Col = "valves_FertlizerProgramming";
  final String valves_FertlizerPreDelay_Col = "valves_FertlizerPreDelay";
  final String valves_FertlizerPostDelay_Col = "valves_FertlizerPostDelay";
  final String valves_ECSetp_Col = "valves_ECSetp";
  final String valves_PHSetp_Col = "valves_PHSetp";
  final String valves_DateCreatedCol = "valves_DateCreated";
  final String valves_StringCol = "valves_String";

  //Timer Variable
  final String tableTimer = "Timer_Table";
  final String timerIdCol = "timerId";
  final String timer_ControllerIdCol = "timer_controller_id";
  final String timer_programNo_Col = "timer_programNo";
  final String timer_StartTimeHrs_Col = "timer_StartTimer_Hrs";
  final String timer_StartTimeMin_Col = "timer_StartTimer_Min";
  final String timer_IntegrationDay_Mon_Col = "timer_IntegrationDay_Mon";
  final String timer_IntegrationDay_Tues_Col = "timer_IntegrationDay_Tue";
  final String timer_IntegrationDay_Wed_Col = "timer_IntegrationDay_Wed";
  final String timer_IntegrationDay_Thurs_Col = "timer_IntegrationDay_Thur";
  final String timer_IntegrationDay_Fri_Col = "timer_IntegrationDay_Fri";
  final String timer_IntegrationDay_Sat_Col = "timer_IntegrationDay_Sat";
  final String timer_IntegrationDay_Sun_Col = "timer_IntegrationDay_Sun";
  final String timer_FertDay_Mon_Col = "timer_FertDay_Mon";
  final String timer_FertDay_Tue_Col = "timer_FertDay_Tue";
  final String timer_FertDay_Wed_Col = "timer_FertDay_Wed";
  final String timer_FertDay_Thurs_Col = "timer_FertDay_Thurs";
  final String timer_FertDay_Fri_Col = "timer_FertDay_Fri";
  final String timer_FertDay_Sat_Col = "timer_FertDay_Sat";
  final String timer_FertDay_Sun_Col = "timer_FertDay_Sun";
  final String timer_StringCol = "timer_String";
  final String timer_DateCreatedCol = "timer_DateCreated";

  //Phone No Variables
  final String tableMobNo = "MobNo_Table";
  final String mobNoIdCol = "mobNoId";
  final String mobNo_controllerIdCol = "mobNo_controllerId";
  final String mobNoCol = "mobNo";
  final String mobNo_DateCreatedCol = "mobNo_DateCreated";

  //Fogger Variables
  final String tableFogger = "Fogger_Table";
  static String foggerIdCol = "foggerId";
  static String fogger_controllerCol = "fogger_controllerId";
  static String foggingTypeCol = "fogger_maxRTU";
  static String fogger_foggerDelayCol = "fogger_foggerDelay";
  static String fogger_FieldCol = "fogger_Field";
  static String fogger_onSecCol = "fogger_onSec";
  static String fogger_minTempCol = "fogger_tempDegree";
  static String fogger_maxTempCol = "fogger_maxTemp";
  static String fogger_minHumCol = "fogger_hum";
  static String fogger_maxHumCol = "fogger_maxHum";
  static String fogger_dateCreated = "fogger_DateCreated";
  static String fogger_configStringCol = "fogger_configString";

  //Strings variable
  final String tableStrings = "tableStrings";
  final String stringIdCol = "stringId";
  final String stringControllerIdCol = "stringControllerId";
  final String stringTypeCol = "stringType";
  final String stringTypeIdCol = "stringTypeId";
  final String stringValveSeqNoCol = "stringValveSeqNo";
  final String controllerStringCol = "controllerString";

  static Database _db;

  Future<Database> get db async {
    if (_db == null) {
      _db = await initDb();
    }
    return _db;
  }

  DataBaseHelper.internal();

  initDb() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, "AutoAquaDB.db");
    var ourDb = await openDatabase(path, version: 1, onCreate: _onConfigure);
    return ourDb;
  }

  void _onConfigure(Database db, int version) async {
    await db.execute("PRAGMA foreign_keys = ON");

    //Head Unit Table
    await db.execute("""
    CREATE TABLE $tableHeadUnit(
    $HUIdcol INTEGER PRIMARY KEY AUTOINCREMENT,
    $HUNameCol TEXT,
    $HUCreatedDateCol TEXT)
    """
    );

    // Controller Table
    await db.execute(
        """
        CREATE TABLE $tableName(
        id INTEGER PRIMARY KEY, 
        $columnHUId INTEGER NOT NULL, 
        $columnItemName TEXT, 
        $columnItemNumber TEXT, 
        $columnDateCreated TEXT)
        """);

    // Configuration Table
    await db.execute("""
        CREATE TABLE $tableConfigName(
        configid INTEGER PRIMARY KEY AUTOINCREMENT,
        controllerId INTEGER NOT NULL,
        $configMaxProg TEXT, 
        $configMaxOut TEXT,
        $configMaxInjectorCol TEXT, 
        $configEcpHStatusCol TEXT,
        $configMaxRTUOnOffCol TEXT,
        $configMaxRTU TEXT, 
        $configSlaveMobNos TEXT,
        $configNoOfSlaves TEXT, 
        $configDateCreated TEXT,
        $configStringCol TEXT,
        $configTotalFoggerValvesCol TEXT,
        $configTotalIrrigationValvesCol TEXT,
        $configTotalValvesCol TEXT,
        $configRemaningValvesCol TEXT,
        $configfoggerDelayCol TEXT,
        CONSTRAINT controllerId_FK FOREIGN KEY (controllerId) REFERENCES $tableName(id) ON DELETE CASCADE)
        """);
    print("Table is created for Config");

    // Slave Table
    await db.execute("""
      CREATE TABLE $tableSlaves(
      $slavesidCol INTEGER PRIMARY KEY,
      $slave_controllerIdCol INTEGER NOT NULL,
      $slave_mobnoCol TEXT,
      $slave_datecreatedCol TEXT,
      FOREIGN KEY ($slave_controllerIdCol) REFERENCES $tableName (id) ON DELETE CASCADE)
      """);
    print("Slave table is created");

    // Program Table
    await db.execute("""
        CREATE TABLE $tableProgram(
        $programIDCol INTEGER PRIMARY KEY AUTOINCREMENT,
        $program_controllerIdCol INTEGER NOT NULL,
        $program_modelCol TEXT,
        $program_flushModeCol TEXT,
        $program_flushtypeCol TEXT,
        $program_sensorOverrideCol TEXT,
        $program_intervalCol TEXT,
        $program_flushonCol TEXT,
        $program_irrigationtypeCol TEXT,
        $program_fertilizationtypeCol TEXT,
        $program_DateCreatedCol TEXT,
        $program_StringCol TEXT,
        FOREIGN KEY ($program_controllerIdCol) REFERENCES $tableName(id) ON DELETE CASCADE)
        """);
    print("Program table is created");

    //Valves Table
    await db.execute("""
      CREATE TABLE $tableValves(
       $valvesIdCol INTEGER PRIMARY KEY,
       $valves_controllerIdCol INTEGER NOT NULL,
       $valvesProgramNoCol INTEGER NOT NULL,
       $valvesSeqNoCol INTEGER NOT NULL,
       $valvesUniteTypeCol TEXT,
       $valves_VolveNo1Col TEXT,
       $valves_VolveNo2Col TEXT,
       $valves_VolveNo3Col TEXT,
       $valves_VolveNo4Col TEXT,
       $valves_fieldNo1Col TEXT,
       $valves_fieldNo2Col TEXT,
       $valves_fieldNo3Col TEXT,
       $valves_fieldNo4Col TEXT,
       $valves_tank1_Col TEXT,
       $valves_tank2_Col TEXT,
       $valves_tank3_Col TEXT,
       $valves_tank4_Col TEXT,
       $valves_FertlizerProgramming_Col TEXT,
       $valves_FertlizerPreDelay_Col TEXT,
       $valves_FertlizerPostDelay_Col TEXT,
       $valves_ECSetp_Col TEXT,
       $valves_PHSetp_Col TEXT,
       $valves_DateCreatedCol TEXT,
       $valves_StringCol TEXT,
       FOREIGN KEY ($valves_controllerIdCol) REFERENCES $tableName(id) ON DELETE CASCADE)
      """);

    //Timer Table
    await db.execute(
      """
      CREATE TABLE $tableTimer(
      $timerIdCol INTEGER PRIMARY KEY,
      $timer_ControllerIdCol INTEGER NOT NULL,
      $timer_programNo_Col INTEGER NOT NULL,
      $timer_StartTimeHrs_Col TEXT,
      $timer_StartTimeMin_Col TEXT,
      $timer_IntegrationDay_Mon_Col TEXT,
      $timer_IntegrationDay_Tues_Col TEXT,
      $timer_IntegrationDay_Wed_Col TEXT,
      $timer_IntegrationDay_Thurs_Col TEXT,
      $timer_IntegrationDay_Fri_Col TEXT,
      $timer_IntegrationDay_Sat_Col TEXT,
      $timer_IntegrationDay_Sun_Col TEXT,
      $timer_FertDay_Mon_Col TEXT,
      $timer_FertDay_Tue_Col TEXT,
      $timer_FertDay_Wed_Col TEXT,
      $timer_FertDay_Thurs_Col TEXT,
      $timer_FertDay_Fri_Col TEXT,
      $timer_FertDay_Sat_Col TEXT,
      $timer_FertDay_Sun_Col TEXT,
      $timer_StringCol TEXT,
      $timer_DateCreatedCol TEXT,
      FOREIGN KEY ($timer_ControllerIdCol) REFERENCES $tableName(id) ON DELETE CASCADE)
      """
    );

    //Table Fogger
    await db.execute(
      """
      CREATE TABLE $tableFogger(
      $foggerIdCol INTEGER PRIMARY KEY,
      $fogger_controllerCol INTEGER NOT NULL,
      $foggingTypeCol TEXT,
      $fogger_foggerDelayCol TEXT,
      $fogger_FieldCol TEXT,
      $fogger_onSecCol TEXT,
      $fogger_minTempCol TEXT,
      $fogger_maxTempCol TEXT,
      $fogger_minHumCol TEXT,
      $fogger_maxHumCol TEXT,
      $fogger_dateCreated TEXT,
      $fogger_configStringCol TEXT,
      FOREIGN KEY ($fogger_controllerCol) REFERENCES $tableName(id) ON DELETE CASCADE)
      """
    );

    //MobNo Table
    await db.execute(
        """
        CREATE TABLE $tableMobNo(
        $mobNoIdCol INTEGER PRIMARY KEY,
        $mobNo_controllerIdCol INTEGER NOT NULL,
        $mobNoCol TEXT,
        $mobNo_DateCreatedCol TEXT,
        FOREIGN KEY ($mobNo_controllerIdCol) REFERENCES $tableName(id) ON DELETE CASCADE)
        """
        );

    //Table String
    await db.execute(
        """
        CREATE TABLE $tableStrings(
        $stringIdCol INTEGER PRIMARY KEY,
        $stringControllerIdCol INTEGER NOT NULL,
        $stringTypeCol TEXT,
        $stringTypeIdCol TEXT,
        $stringValveSeqNoCol TEXT,
        $controllerStringCol TEXT,
        FOREIGN KEY ($stringControllerIdCol) REFERENCES $tableName(id) ON DELETE CASCADE)
        """
        );
  }

  // Insertion into HeadUnit
  Future<int> saveHUItem(HUModel item) async {
    var dbClient = await db;
    int res = await dbClient.insert("$tableHeadUnit", item.toMap());
    return res;
  }

  // Insertion into Controller
  Future<int> saveItem(ControllerItem item) async {
    var dbClient = await db;
    int res = await dbClient.insert("$tableName", item.toMap());
    return res;
  }

  // Insertion into Configuration
  Future<int> saveConfigurationItem(ConfigurationModel config) async {
    return (await db).insert("$tableConfigName", config.toDbMap());
    /*if(config.configid != null){
      return (await db).update('$tableConfigName', config.toDbMap());
    }else {
      return (await db).insert("$tableConfigName", config.toDbMap());
    }*/
  }

  // Update the Configuration
  Future<int> updateConfigurationItems(ConfigurationModel item) async {
    var dbClient = await db;
    print("Updated config data ${item.toDbMap()}");
    return await dbClient.update("$tableConfigName", item.toDbMap(),
        where: "$configId = ?", whereArgs: [item.configid]);
  }

  // Update the Configuration for FOgger
  Future<int> updateConfigurationItemsforFogger(ConfigurationModel item) async {
    var dbClient = await db;
    print("Updated config data ${item.toDbMap()}");
    return await dbClient.rawUpdate(
        'UPDATE $tableConfigName SET $configTotalFoggerValvesCol = ?, $configfoggerDelayCol = ? WHERE $configId = ?',
        [item.ConfigmaxFogger, item.ConfigfoggerDelay, item.configid]);
  }
/*

int count = await database.rawUpdate(
    'UPDATE Test SET name = ?, VALUE = ? WHERE name = ?',
    ["updated name", "9876", "some name"]);
print("updated: $count");

  Future<bool> deleteConfiguationItem(int configId) async {
    int result = await (await db).delete(
      '$tableConfigName',
      where: '$configId = ?',
      whereArgs: [configId],
    );
    return result != 0;
  }
*/
  // Insertion into Program Table
  Future<int> saveProgramData(ProgramModel item) async {
    print("Program Items");
    print("table id ${item.toMap_program()}");
    return (await db).insert("$tableProgram", item.toMap_program());
  }

  //Update the program data
  Future<int> updateProgramData(ProgramModel modelProgram)async {
    return (await db).update("$tableProgram", modelProgram.toMap_program(),
        where: "$programIDCol = ?", whereArgs: [modelProgram.programID]);
  }

  // Insertion into Valves Table
  Future<int> saveValvesData(ValvesModel item) async {
    var dbClient = await db;
    print("Valves Data from database");
    print(item.toMap_Valves());
    return (await db).insert("$tableValves", item.toMap_Valves());
  }

  //Update Valves Data
  Future<int> updateValvesData(ValvesModel modelValve)async{
    return (await db).update("$tableValves", modelValve.toMap_Valves(),
        where: "$valvesProgramNoCol = ? and $valvesSeqNoCol = ?", whereArgs: [modelValve.valves_ProgramNo, modelValve.valves_SeqNo]);
  }

  //Insertion into timer table
  Future<int> saveTimerData(TimerModel modelTimer) async{
    print("save timer data is ${modelTimer.toMap_Timer()}");
    return (await db).insert('$tableTimer', modelTimer.toMap_Timer());
  }

  //Update Timer Data
  Future<int> updateTimerData(TimerModel modelTimer)async {
    return (await db).update('$tableTimer', modelTimer.toMap_Timer(),
                where: "$timerIdCol = ?", whereArgs: [modelTimer.timerId]);
  }

  //Insertion into mobNo table
  Future<int> saveMobNo(mobNoModel ModelmobNo)async{
    print("save mobno data is ${ModelmobNo.toMap_mobNo()}");
    return (await db).insert('$tableMobNo', ModelmobNo.toMap_mobNo());
  }

  //Update MobNo
  Future<int> updateMobNo(mobNoModel ModelmobNo)async{
    return (await db).update('$tableMobNo', ModelmobNo.toMap_mobNo(),
                    where: "$timerIdCol = ?", whereArgs: [ModelmobNo.mobNoId]);
  }

  //Insertion into Fogger Table
  Future<int> saveFoggerData(FoggerModel foggerModel)async{
    print("saved fogger data is ${foggerModel.tomap_Fogger()}");
    if(foggerModel.foggerId != null) {
      return (await db).update('$tableFogger', foggerModel.tomap_Fogger(),
          where: "$foggerIdCol = ?", whereArgs: [foggerModel.foggerId]);
    }else{
      return (await db).insert("$tableFogger", foggerModel.tomap_Fogger());
    }
  }

  //Insert String from every Controller Details
  saveStrings(StringModel stringModel)async{
    //print("Inserted String data ${stringModel.string_toMap()}");
    /*var result = (await db).rawQuery(
        'INSERT INTO $tableStrings(stringControllerId, controllerString,stringDateCreated ) SELECT controllerId, ConfigString, ConfigDateCreated FROM $tableConfigName WHERE controllerId = $controllerId');
    print("resultString: $result");*/
    return (await db).insert('$tableStrings', stringModel.string_toMap());
    /*if(stringModel.stringId != null){
      print("Inserted String data ${stringModel.string_toMap()}");
      return (await db).update('$tableStrings', stringModel.string_toMap(),
          where: "$stringIdCol = ?", whereArgs: [stringModel.stringId]);
    }else{
      print("Updating String data ${stringModel.string_toMap()}");
      return (await db).insert('$tableStrings', stringModel.string_toMap());
    }*/

  }

  updateConfigString(StringModel stringModel)async{

    var result =  (await db).update('$tableStrings', stringModel.string_toMap(),
        where: "$stringControllerIdCol = ? and $stringTypeCol = ? and $stringTypeIdCol = ? and $stringValveSeqNoCol = ?", whereArgs: [stringModel.stringControllerId, stringModel.stringType, stringModel.stringTypeId, stringModel.stringValveSeqNo]);
    print("Res: $result");
    return result;
    /*var dbClient  = await db;
    var result = await dbClient.rawQuery('SELECT controllerId, ConfigString, ConfigDateCreated FROM $tableConfigName WHERE controllerId = $controllerId');
    print("Updated resultString1111: ${result[0]['ConfigDateCreated']}");
    var a = ['1','2','3','1'];
    var resultConfigUpdate = await dbClient.rawUpdate(
        'UPDATE $tableStrings SET stringControllerId=?, controllerString=?, stringDateCreated=? WHERE stringControllerId = ?', a);
//var result = await dbClient.rawQuery('SELECT controllerId, ConfigString, ConfigDateCreated FROM $tableConfigName WHERE controllerId = $controllerId');
    //var resultConfigUpdate1 = await dbClient.rawUpdate(
    //    'UPDATE $tableStrings SET stringControllerId=?, controllerString=?, stringDateCreated=?', ['1','QQQQq','12.090']);

    //print("TEST: $resultConfigUpdate1");
    //print("Updated resultString: $result");
    //print("Updated resultString1: $resultConfigUpdate");
    //return resultConfigUpdate;*/
  }

  saveProgramString(controllerId)async{
    var result1 = (await db).rawQuery(
        'INSERT INTO $tableStrings(stringControllerId, controllerString,stringDateCreated ) SELECT program_controller_id, program_String, program_DateCreated FROM $tableProgram WHERE program_controller_id = $controllerId');
    print("resultStringProgram: $result1");
  }

  //Update String from every Controller Details
  Future<int> updateString(StringModel stringModel)async{
    print("Updated String data ${stringModel.string_toMap()}");
    return (await db).update('$tableStrings', stringModel.string_toMap(),
        where: "$stringIdCol = ?", whereArgs: [stringModel.stringId]);
  }

  Future<bool> deleteFoggerData(int id) async {
    int result = await (await db).delete('$tableFogger',
        where: '$foggerIdCol = ?', whereArgs: [id]);
    return result != 0;
  }

//Get data for Controller
  Future<List> getItems(int HUId) async {
    var dbClient = await db;
    var result = await dbClient.rawQuery("SELECT * FROM $tableName WHERE $columnHUId = $HUId");
    print("DataBase Table \n $result");
    return result.toList();
  }

  //Get data for Controller
  Future<List> getALLItems() async {
    var dbClient = await db;
    var result = await dbClient.rawQuery("SELECT * FROM $tableName");
    print("ALL Data for Controller Table \n $result");
    return result.toList();
  }

  //Get the Max program data from ConfigurationTabe table
/*
   Future getMaxProgrmCount(int controllerID) async{
    var dbClient = await db;
    var maxprogramcount = await
    dbClient.rawQuery("SELECT $configMaxProg FROM $tableConfigName WHERE $ControllerIdCol = $controllerID");
    print("Max Program is $maxprogramcount and controller id is $controllerID");
    return maxprogramcount;
  }
*/

  //Get data for Hub Unit
  Future<List> getHeadUnitItems() async {
    var dbClient = await db;
    var result = await dbClient.rawQuery("SELECT * FROM $tableHeadUnit");
    print("Configuration DataBase Table \n $result");
    return result.toList();
  }

  //Get data for Configuration
  Future<List> getConfigItems() async {
    var dbClient = await db;
    var result = await dbClient.rawQuery("SELECT * FROM ConfigurationTabe");
    print("Configuration DataBase Table \n $result");
    return result.toList();
  }

  //Get data for Program
  Future<List> getProgramItems() async {
    var dbClient = await db;
    var result = await dbClient.rawQuery("SELECT * FROM $tableProgram");
    print("Program DataBase Table \n $result");
    return result.toList();
  }

//Get Count
  Future<int> getCount(int id) async {
    var dbClient = await db;
    return Sqflite.firstIntValue(
        await dbClient.rawQuery("SELECT COUNT(*) FROM $tableName"));
  }

  // GET HUData
  Future<HUModel> getHubUnitItem(int id) async {
    var dbClient = await db;
    var result =
    await dbClient.rawQuery("SELECT * FROM $tableHeadUnit WHERE $HUIdcol = $id");
    if (result.length == 0) return null;
    return HUModel.fromMap(result.first);
  }

  // GET CONTROLLERDATA
  Future<ControllerItem> getItem(int id) async {
    var dbClient = await db;
    var result =
        await dbClient.rawQuery("SELECT * FROM $tableName WHERE $columnId = $id");
    if (result.length == 0) return null;
    return ControllerItem.fromMap(result.first);
  }

  /*Future<int> getControllerNum(id)async{
    var dbClient = await db;
    var result = await dbClient.rawQuery("SELECT $columnItemNumber FROM $tableName WHERE $columnId = $id");
    if(result.length == 0) return null;
    return result;
  }
*/
  //Get Configuration Data
  Future<ConfigurationModel> getConfigDataForController(
      int controllerId) async {
    var dbClient = await db;
    var result = await dbClient.rawQuery(
        "SELECT * FROM $tableConfigName WHERE $controllerIdCol = $controllerId");
    if (result.length == 0) return null;
    return  ConfigurationModel.fromDbMap(result.first);
  }


  //Get Config String
  Future<ConfigurationModel> getConfigString(int controllerId)async{
    var dbClient = await db;
    var resultConfigString = await dbClient.rawQuery("SELECT $configStringCol FROM $tableConfigName WHERE $controllerIdCol = $controllerId");
    if(resultConfigString.length == 0) return null;
    print("Program String List: $resultConfigString");
    return ConfigurationModel.fromDbMap(resultConfigString.first);
  }

  //Get Program Data
  Future<ProgramModel> getProgramData(
      int controllerId, int programId) async {
    var dbClient = await db;
    var result = await dbClient.rawQuery(
        "SELECT * FROM $tableProgram WHERE $program_controllerIdCol = $controllerId");
    if (result.length == 0 || programId+1 > result.length) {
      return null;
    };
    return ProgramModel.fromMap_program(result[programId]);
  }

  //Get Program String
  Future getProgramString(int controllerId)async{
    var dbClient = await db;
    List data = await dbClient.query('$tableProgram', columns: ['$program_StringCol'], where: "$program_controllerIdCol = ?", whereArgs: [controllerId]);
    List data1 = await dbClient.rawQuery(
        "SELECT group_concat($program_StringCol, ',')AS Strings FROM $tableProgram WHERE $program_controllerIdCol = $controllerId");
    //data1.toString().substring(10, data1);

    //List data = await dbClient.rawQuery(
    //    "SELECT $program_StringCol FROM $tableProgram WHERE $program_controllerIdCol = $controllerId");
    print("Program String List: $data");
    print("Program String List: $data1");
    //print(data1.toString().substring(10, data1.length-2));
    return data1;
    /*var resultProgramString = await dbClient.rawQuery(
        "SELECT $program_StringCol FROM $tableProgram WHERE $program_controllerIdCol = $controllerId");
    if(resultProgramString == 0)return null;
    print("Program String List: $resultProgramString");
    return resultProgramString.map((pString) => ProgramModel.fromMap_program(pString)).toList(growable: false);
*/
  }

  //Get Valves Data
  Future<ValvesModel> getValvesData(int controllerId, int valvesProgramNo, int seqNo) async{
    var dbClient = await db;
    var valvesResult = await dbClient.rawQuery(
        "SELECT * FROM $tableValves WHERE $valves_controllerIdCol = $controllerId AND $valvesProgramNoCol = $valvesProgramNo AND $valvesSeqNoCol = $seqNo");
    print("Valve result ${valvesResult}");
    if(valvesResult.length == 0){
      // || seqNo > valvesResult.length || valvesProgramNo > valvesResult.length
      return null;
    }else{
      //print("Valves 2 data is ${ValvesModel.fromMap_Valves(valvesResult[valvesProgramNo])}");
      print("Valves 1 data is ${valvesResult.first}");
      return ValvesModel.fromMap_Valves(valvesResult.first);
    }
  }

  //Get Timer Data
  Future<TimerModel> getTimerData(int controllerId, int timerId)async{
    var dbClient = await db;
    var timerResult = await dbClient.rawQuery(
      "SELECT * FROM $tableTimer WHERE $timer_ControllerIdCol = $controllerId"
    );
    if(timerResult.length == 0 || timerId + 1 > timerResult.length){
      return null;
    }
    print("Timer data is $timerResult");
    return TimerModel.fromMap_timer(timerResult[timerId]);
  }

  //Get Mob No
  Future<mobNoModel> getMobNo(int controllerId)async{
    var dbClient = await db;
    var mobNoResult = await dbClient.rawQuery(
        "SELECT * FROM $tableMobNo WHERE $mobNo_controllerIdCol = $controllerId"
    );
    if(mobNoResult.length == 0){
      return null;
    }
    return mobNoModel.fromMap_mobNo(mobNoResult.first);
  }

  //Get Fogger Data
  Future<List<FoggerModel>> getFoggerData(int controllerId)async{
    var dbClient = await db;
    var foggerResult = await dbClient.rawQuery(
        "SELECT * FROM $tableFogger WHERE $fogger_controllerCol = $controllerId"
    );
    if(foggerResult.length == 0){
      return null;
    }
    return foggerResult
        .map((data) => FoggerModel.fromMap_Fogger(data))
        .toList(growable: false);
  }

  Future<FoggerModel> getFoggerDetailsforConfig(int controllerId)async{
    var dbClient = await db;
    var foggerResult = await dbClient.rawQuery(
        "SELECT $fogger_foggerDelayCol FROM $tableFogger WHERE $fogger_controllerCol = $controllerId"
    );
    if(foggerResult.length == 0){
      return null;
    }
    return FoggerModel.fromMap_Fogger(foggerResult.first);
  }


  //Get the String data
  Future<StringModel> getStrings(controllerId)async{
    var dbClient = await db;
    var stringResult = await dbClient.rawQuery(
        "SELECT * FROM $tableStrings");
    print("String ersult: $stringResult");
    if(stringResult.length == 0) return null;
    return StringModel.string_fromMap(stringResult.first);
  }


  //Get ALl the Strings
  Future<List<StringModel>> getStringData(int controllerId)async{
    var dbClient = await db;
    var stringResult = await dbClient.rawQuery(
        "SELECT * FROM $tableStrings WHERE $stringControllerIdCol = $controllerId");
    print("String Data is $stringResult");
    if(stringResult.length == 0)return null;
    return stringResult
        .map((data)=> StringModel.string_fromMap(data))
        .toList(growable: false);
  }

  //Delete HU Items
  Future<int> deleteHUItems(int id) async {
    var dbClient = await db;
    return await dbClient
        .delete(tableHeadUnit, where: "$HUIdcol = ?", whereArgs: [id]);
  }

  //Call this method if Item is deleted from HU
  Future<int> deleteControllerItems(int id) async {
    var dbClient = await db;
    await dbClient.execute("PRAGMA foreign_keys = ON");
    return await dbClient
        .delete(tableName, where: "$columnHUId = ?", whereArgs: [id]);
  }

  //Delete Items
  Future<int> deleteItems(int id) async {
    var dbClient = await db;
    await dbClient.execute("PRAGMA foreign_keys = ON");
    return await dbClient
        .delete(tableName, where: "$columnId = ?", whereArgs: [id]);
  }

  //Update HU Item
  Future<int> updateHUItems(HUModel item) async {
    var dbClient = await db;
    return await dbClient.update("$tableHeadUnit", item.toMap(),
        where: "$HUIdcol = ?", whereArgs: [item.HUId]);
  }

  //Update controller Item
  Future<int> updateItems(ControllerItem item) async {
    var dbClient = await db;
    return await dbClient.update("$tableName", item.toMap(),
        where: "$columnId = ?", whereArgs: [item.id]);
  }

  //Get the HU data to show in dropdown on Dashboard Page
  Future<List<String>> getHUDataAsString() async {
    var dbClient = await db;

    var results = await dbClient.rawQuery('SELECT $HUNameCol FROM $tableHeadUnit');

    return results.map((Map<String, dynamic> row) {
      return row["$HUNameCol"] as String;
    }).toList();
  }

  //Get the Controller data to show in dropdown on Dashboard Page
  Future<List<String>> getControllerDataAsString(String selectedHU) async {
    var dbClient = await db;

    var results = await dbClient.rawQuery('SELECT $columnItemName FROM $tableName WHERE $columnHUId = $selectedHU');

    return results.map((Map<String, dynamic> row) {
      return row["$columnItemName"] as String;
    }).toList();
  }

  //Get the Controller data to show in dropdown on Dashboard Page
  Future<List<String>> getAllControllerDataAsString() async {
    var dbClient = await db;

    var results = await dbClient.rawQuery('SELECT $columnItemName FROM $tableName');

    return results.map((Map<String, dynamic> row) {
      return row["$columnItemName"] as String;
    }).toList();
  }

  //Get the valves data to show on dashboard page
  Future<int> getValves1LtrCount(int controllerId) async {
    var dbClient = await db;
    int total = Sqflite.firstIntValue(
        await dbClient.rawQuery("SELECT SUM($valves_fieldNo1Col) FROM $tableValves WHERE $valves_controllerIdCol = $controllerId and $valvesUniteTypeCol == 'Ltr'"));
    print("Valves total is $total");
    return total;
  }
  //Get the valves data to show on dashboard page
  Future<int> getValves2LtrCount(int controllerId) async {
    var dbClient = await db;
    int total = Sqflite.firstIntValue(
        await dbClient.rawQuery("SELECT SUM($valves_fieldNo2Col) FROM $tableValves WHERE $valves_controllerIdCol = $controllerId and $valvesUniteTypeCol == 'Ltr'"));
    print("Valves total is $total");
    return total;
  }
  //Get the valves data to show on dashboard page
  Future<int> getValves3LtrCount(int controllerId) async {
    var dbClient = await db;
    int total = Sqflite.firstIntValue(
        await dbClient.rawQuery("SELECT SUM($valves_fieldNo3Col) FROM $tableValves WHERE $valves_controllerIdCol = $controllerId and $valvesUniteTypeCol == 'Ltr'"));
    print("Valves total is $total");
    return total;
  }
  //Get the valves data to show on dashboard page
  Future<int> getValves4LtrCount(int controllerId) async {
    var dbClient = await db;
    int total = Sqflite.firstIntValue(
        await dbClient.rawQuery("SELECT SUM($valves_fieldNo4Col) FROM $tableValves WHERE $valves_controllerIdCol = $controllerId and $valvesUniteTypeCol == 'Ltr'"));
    print("Valves total is $total");
    return total;
  }

  Future close() async {
    var dbClient = await db;
    return dbClient.close();
  }
}
