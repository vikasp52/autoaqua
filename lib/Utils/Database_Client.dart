import 'dart:io';
import 'package:autoaqua/Model/ConfigurationModel.dart';
import 'package:autoaqua/Model/ControllerItems.dart';
import 'package:autoaqua/Model/ProgramModel.dart';
import 'package:autoaqua/Model/ValvesModel.dart';
import 'package:path/path.dart';
import 'dart:async';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DataBaseHelper {
  static final DataBaseHelper _instance = new DataBaseHelper.internal();
  factory DataBaseHelper() => _instance;

  //Controller Variable
  final String tableName = "ControllerTable";
  final String columnId = "id";
  final String columnItemName = "itemName";
  final String columnItemNumber = "itemNumber";
  final String columnDateCreated = "dateCreated";

  //Configuration Variable
  final String tableConfigName = "ConfigurationTabe";
  final String ControllerIdCol = "controllerId";
  final String configId = "configid";
  final String configMaxProg = "configMaxProg";
  final String configMaxOut = "configMaxOutput";
  final String configMobNo = "configMobNo";
  final String configNoOfSlaves = "configNoOfSlaves";
  final String configSlaveMobNos = "configSlaveMobNos";
  final String ConfigDateCreated = "ConfigDateCreated";

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
  final String program_flushtypeCol = "program_flushtype";
  final String program_intervalCol = "program_interval";
  final String program_flushonCol = "program_flushon";
  final String program_integrationtypeCol = "program_integrationtype";
  final String program_DateCreatedCol = "program_DateCreated";

  //VALVES Variable
  final String tableValves = "Valves_Table";
  final String valvesIdCol = "valvesId";
  final String valves_controllerIdCol = "valves_controller_id";
  final String valvesProgramNoCol = "valves_ProgramNo";
  final String valvesSeqNoCol = "valves_SeqNo";
  final String valves_fieldNoLtrCol = "valves_fieldNo_for_Ltrs";
  final String valves_field_for_LitersCol = "valves_field_Ltrs";
  final String valves_fieldNoMinsCol = "valves_fieldNo_for_Mins";
  final String valves_field_for_MinsCol = "valves_field_Mins";
  final String valves_tank1_Ltr_Col = "valves_tank1_Ltr";
  final String valves_tank1_Min_Col = "valves_tank1_Min";
  final String valves_tank2_Ltr_Col = "valves_tank2_Ltr";
  final String valves_tank2_Min_Col = "valves_tank2_Min";
  final String valves_tank3_Ltr_Col = "valves_tank3_Ltr";
  final String valves_tank3_Min_Col = "valves_tank3_Min";
  final String valves_tank4_Ltr_Col = "valves_tank4_Ltr";
  final String valves_tank4_Min_Col = "valves_tank4_Min";
  final String valves_FertlizerType_Col = "valves_FertlizerType";
  final String valves_FertlizerDelay_Litr_Col = "valves_FertlizerDelay_Litr";
  final String valves_FertlizerDelay_Min_Col = "valves_FertlizerDelay_Min";
  final String valves_ECSetp_Col = "valves_ECSetp";
  final String valves_PHSetp_Col = "valves_PHSetp";
  final String valves_DateCreatedCol = "valves_DateCreated";

  //Timer Variable
  final String tableTimer = "Timer_Table";
  final String timerIdCol = "timerId";
  final String timer_ControllerIdCol = "timer_controller_id";
  final String timer_programNo_Col = "timer_programNo";
  final String timer_StartTimeHrs_Col = "timer_StartTimer_Hrs";
  final String timer_StartTimeMin_Col = "timer_StartTimer_Min";
  final String timer_IntegrationDay_Mon_Col = "timer_IntegrationDay_Mon";
  final String timer_IntegrationDay_Tues_Col = "timer_IntegrationDay_Mon";
  final String timer_IntegrationDay_Wed_Col = "timer_IntegrationDay_Mon";
  final String timer_IntegrationDay_Thurs_Col = "timer_IntegrationDay_Mon";
  final String timer_IntegrationDay_Fri_Col = "timer_IntegrationDay_Mon";
  final String timer_IntegrationDay_Sat_Col = "timer_IntegrationDay_Mon";
  final String timer_IntegrationDay_Sun_Col = "timer_IntegrationDay_Mon";
  final String timer_FertDay_Mon_Col = "timer_FertDay_Mon";
  final String timer_FertDay_Tue_Col = "timer_FertDay_Tue";
  final String timer_FertDay_Wed_Col = "timer_FertDay_Wed";
  final String timer_FertDay_Thurs_Col = "timer_FertDay_Thurs";
  final String timer_FertDay_Fri_Col = "timer_FertDay_Fri";
  final String timer_FertDay_Sat_Col = "timer_FertDay_Sat";
  final String timer_FertDay_Sun_Col = "timer_FertDay_Sun";

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
    String path = join(documentDirectory.path, "AutoAqua.db");
    var ourDb = await openDatabase(path, version: 1, onCreate: _onConfigure);
    return ourDb;
  }

  void _onConfigure(Database db, int version) async {
    await db.execute("PRAGMA foreign_keys = ON");

    // Controller Table
    await db.execute(
        "CREATE TABLE $tableName(id INTEGER PRIMARY KEY, $columnItemName TEXT, $columnItemNumber TEXT, $columnDateCreated TEXT)");

    print("Created " + tableName);

    // Configuration Table
    await db.execute("""
        CREATE TABLE $tableConfigName(
        configid INTEGER PRIMARY KEY AUTOINCREMENT,
        controllerId INTEGER NOT NULL,
        $configMaxProg TEXT, 
        $configMaxOut TEXT, 
        $configMobNo TEXT, 
        $configSlaveMobNos TEXT,
        $configNoOfSlaves TEXT, 
        $ConfigDateCreated TEXT,
        FOREIGN KEY (controllerId) REFERENCES $tableName (id))
        """);
    print("Table is created for Config");

    // Slave Table
    await db.execute("""
      CREATE TABLE $tableSlaves(
      $slavesidCol INTEGER PRIMARY KEY,
      $slave_controllerIdCol INTEGER NOT NULL,
      $slave_mobnoCol TEXT,
      $slave_datecreatedCol TEXT,
      FOREIGN KEY ($slave_controllerIdCol) REFERENCES $tableName (id))
      """);
    print("Slave table is created");

    // Program Table
    await db.execute("""
        CREATE TABLE $tableProgram(
        $programIDCol INTEGER PRIMARY KEY AUTOINCREMENT,
        $program_controllerIdCol INTEGER NOT NULL,
        $program_modelCol TEXT,
        $program_flushtypeCol TEXT,
        $program_intervalCol TEXT,
        $program_flushonCol TEXT,
        $program_integrationtypeCol TEXT,
        $program_DateCreatedCol TEXT,
        FOREIGN KEY ($program_controllerIdCol) REFERENCES $tableName(id))
        """);
    print("Program table is created");

    //Valves Table
    await db.execute("""
      CREATE TABLE $tableValves(
       $valvesIdCol INTEGER PRIMARY KEY,
       $valves_controllerIdCol INTEGER NOT NULL,
       $valvesProgramNoCol INTEGER NOT NULL,
       $valvesSeqNoCol INTEGER NOT NULL,
       $valves_fieldNoLtrCol TEXT,
       $valves_field_for_LitersCol TEXT,
       $valves_fieldNoMinsCol TEXT,
       $valves_field_for_MinsCol TEXT,
       $valves_tank1_Ltr_Col TEXT,
       $valves_tank1_Min_Col TEXT,
       $valves_tank2_Ltr_Col TEXT,
       $valves_tank2_Min_Col TEXT,
       $valves_tank3_Ltr_Col TEXT,
       $valves_tank3_Min_Col TEXT,
       $valves_tank4_Ltr_Col TEXT,
       $valves_tank4_Min_Col TEXT,
       $valves_FertlizerType_Col TEXT,
       $valves_FertlizerDelay_Litr_Col TEXT,
       $valves_FertlizerDelay_Min_Col TEXT,
       $valves_ECSetp_Col TEXT,
       $valves_PHSetp_Col TEXT,
       $valves_DateCreatedCol TEXT,
       FOREIGN KEY ($valves_controllerIdCol) REFERENCES $tableName(id))
      """);

    //Timer Table
   /* await db.execute(
      """
      CREATE TABLE $tableTimer(
      $timerIdCol INTEGER PRIMARY KEY,
      $timer_ControllerIdCol INTEGER NOT NULL;
      $timer_programNo_Col INTEGER NOT NULL;
      $timer_StartTimeHrs_Col TEXT;
      $timer_StartTimeMin_Col TEXT;
      $timer_IntegrationDay_Mon_Col TEXT;
      $timer_IntegrationDay_Tues_Col TEXT;
      $timer_IntegrationDay_Wed_Col TEXT;
      $timer_IntegrationDay_Thurs_Col TEXT;
      $timer_IntegrationDay_Fri_Col TEXT;
      $timer_IntegrationDay_Sat_Col TEXT;
      $timer_IntegrationDay_Sun_Col TEXT;
      $timer_FertDay_Mon_Col TEXT;
      $timer_FertDay_Tue_Col TEXT;
      $timer_FertDay_Wed_Col TEXT;
      $timer_FertDay_Thurs_Col TEXT;
      $timer_FertDay_Fri_Col TEXT;
      $timer_FertDay_Sat_Col TEXT;
      $timer_FertDay_Sun_Col TEXT;
      )
      """
    );*/
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
/*
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
    print("Valves Items");
    print(item.toMap_Valves());
    int res_progrm = await dbClient.insert("$tableValves", item.toMap_Valves());
    print("Valves table id $res_progrm");
    return res_progrm;
  }

//Get data for Controller
  Future<List> getItems() async {
    var dbClient = await db;
    var result = await dbClient.rawQuery("SELECT * FROM $tableName");
    print("DataBase Table \n $result");
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

  // GET CONTROLLERDATA
  Future<ControllerItem> getItem(int id) async {
    var dbClient = await db;
    var result =
        await dbClient.rawQuery("SELECT * FROM $tableName WHERE id = $id");
    if (result.length == 0) return null;
    return new ControllerItem.fromMap(result.first);
  }

  //Get Configuration Data
  Future<ConfigurationModel> getConfigDataForController(
      int controllerId) async {
    var dbClient = await db;
    var result = await dbClient.rawQuery(
        "SELECT * FROM $tableConfigName WHERE $ControllerIdCol = $controllerId");
    if (result.length == 0) return null;
    return new ConfigurationModel.fromDbMap(result.first);
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
    print('THis is result for program ${result[programId]}');
    print(programId+1);
    print(result.length);
    print(result.first);
    return ProgramModel.fromMap_program(result[programId]);
  }

  //Delete Items
  Future<int> deleteItems(int id) async {
    var dbClient = await db;
    return await dbClient
        .delete(tableName, where: "$columnId = ?", whereArgs: [id]);
  }

  Future<int> updateItems(ControllerItem item) async {
    var dbClient = await db;
    return await dbClient.update("$tableName", item.toMap(),
        where: "$columnId = ?", whereArgs: [item.id]);
  }

  Future close() async {
    var dbClient = await db;
    return dbClient.close();
  }
}
