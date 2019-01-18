import 'dart:io';
import 'package:autoaqua/ECpH_Controller/Model/ECpHMobNo.dart';
import 'package:autoaqua/ECpH_Controller/Model/ECpHModel.dart';
import 'package:autoaqua/ECpH_Controller/Model/ECpHScheduleModel.dart';
import 'package:path/path.dart';
import 'dart:async';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class ECpHDataBaseHelper {
  static final ECpHDataBaseHelper _instance = ECpHDataBaseHelper.internal();

  factory ECpHDataBaseHelper() => _instance;

  //Variable for ECpH Table
  final String tableECpH = "ECphTable";
  final String ECpHIDCol = "ECpHID";
  final String ECValCol = "ECVal";
  final String pHValCol = "pHVal";
  final String sensignDelayCol = "sensignDelay";
  final String ECpHDateTimeCol = "ECpHDateTime";

  //Variable for ECpHSchedule Table
  final String tableECpHScheduleCol = "ECpHScheduleTable";
  final String ECpHScheduleIdCol = "ECpHScheduleId";
  final String ECpHStartTimeHrsCol = "ECpHStartTimeHrs";
  final String ECpHStartTimeMinCol = "ECpHStartTimeMin";
  final String ECpHEndTimeHrsCol = "ECpHEndTimeHrs";
  final String ECpHEndTimeMinCol = "ECpHEndTimeMin";
  final String ECpHIntegrationDay_Mon_Col = "ECpHIntegrationDay_Mon";
  final String ECpHIntegrationDay_Tues_Col = "ECpHIntegrationDay_Tue";
  final String ECpHIntegrationDay_Wed_Col = "ECpHIntegrationDay_Wed";
  final String ECpHIntegrationDay_Thurs_Col = "ECpHIntegrationDay_Thur";
  final String ECpHIntegrationDay_Fri_Col = "ECpHIntegrationDay_Fri";
  final String ECpHIntegrationDay_Sat_Col = "ECpHIntegrationDay_Sat";
  final String ECpHIntegrationDay_Sun_Col = "ECpHIntegrationDay_Sun";
  final String ECpHScheduleDay_Mon_Col = "ECpHScheduleDay_Mon";
  final String ECpHScheduleDay_Tue_Col = "ECpHScheduleDay_Tue";
  final String ECpHScheduleDay_Wed_Col = "ECpHScheduleDay_Wed";
  final String ECpHScheduleDay_Thurs_Col = "ECpHScheduleDay_Thur";
  final String ECpHScheduleDay_Fri_Col = "ECpHScheduleDay_Fri";
  final String ECpHScheduleDay_Sat_Col = "ECpHScheduleDay_Sat";
  final String ECpHScheduleDay_Sun_Col = "ECpHScheduleDay_Sun";
  final String ECpHStringCol = "ECpHString";
  final String ECpHDateCreatedCol = "ECpHDateCreated";

  //Variables for Phone No Table
  final String tableECpHMobNoCol = "ECpHMobNoTable";
  final String ECpHmobNoIdCol = "ECpHmobNoId";
  final String ECpHmobNoCol = "ECpHmobNo";
  final String ECpHmobNo_DateCreatedCol = "ECpHmobNo_DateCreated";

  static Database _db;

  Future<Database> get db async {
    if (_db == null) {
      _db = await initDb();
    }
    return _db;
  }

  ECpHDataBaseHelper.internal();

  initDb() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, "ECpHDatabase.db");
    var ourDb = await openDatabase(path, version: 1, onCreate: _onConfigure);
    return ourDb;
  }

  void _onConfigure(Database db, int version) async {
    //ECpH Table
    await db.execute("""
    CREATE TABLE $tableECpH(
    $ECpHIDCol INTEGER PRIMARY KEY,
    $ECValCol Text,
    $pHValCol Text,
    $sensignDelayCol TEXT,
    $ECpHDateTimeCol TEXT)
    """);

    //ECpHSchedule Table
    await db.execute("""
    CREATE TABLE $tableECpHScheduleCol(
    $ECpHScheduleIdCol INTEGER PRIMARY KEY,
    $ECpHStartTimeHrsCol TEXT,
    $ECpHStartTimeMinCol TEXT,
    $ECpHEndTimeHrsCol TEXT,
    $ECpHEndTimeMinCol TEXT,
    $ECpHIntegrationDay_Mon_Col TEXT,
    $ECpHIntegrationDay_Tues_Col TEXT,
    $ECpHIntegrationDay_Wed_Col TEXT,
    $ECpHIntegrationDay_Thurs_Col TEXT,
    $ECpHIntegrationDay_Fri_Col TEXT,
    $ECpHIntegrationDay_Sat_Col TEXT,
    $ECpHIntegrationDay_Sun_Col TEXT,
    $ECpHScheduleDay_Mon_Col TEXT,
    $ECpHScheduleDay_Tue_Col TEXT,
    $ECpHScheduleDay_Wed_Col TEXT,
    $ECpHScheduleDay_Thurs_Col TEXT,
    $ECpHScheduleDay_Fri_Col TEXT, 
    $ECpHScheduleDay_Sat_Col TEXT, 
    $ECpHScheduleDay_Sun_Col TEXT, 
    $ECpHStringCol TEXT,
    $ECpHDateCreatedCol TEXT)
    """);

    //Phone No Table
    await db.execute("""
    CREATE TABLE $tableECpHMobNoCol(
    $ECpHmobNoIdCol INTEGER PRIMARY KEY,
    $ECpHmobNoCol TEXT,
    $ECpHmobNo_DateCreatedCol TEXT)
    """);
  }

  // Save ECpH Data
  Future<int> saveECpHItem(ECpHModel item) async {
    var dbClient = await db;
    int res = await dbClient.insert("$tableECpH", item.toECpHMap());
    return res;
  }

  // Save ECpHSchedule Data
  Future<int> saveECpHScheduleItem(ECpHScheduleModel item) async {
    var dbClient = await db;
    int res = await dbClient.insert("$tableECpHScheduleCol", item.toMapECpHSchedule());
    print("ECpHScheduleModel Data is: \n $res");
    return res;
  }

  // Save ECpHMobNo Data
  Future<int> saveECpHMobNoItem(ECpHmobNoModel item) async {
    var dbClient = await db;
    int res = await dbClient.insert("$tableECpHMobNoCol", item.toMap_mobNo());
    print("ECpHMobNo Data is: \n $res");
    return res;
  }

  //Update ECpH Data
  Future<int> updateECpHData(ECpHModel modelECpH) async {
    return (await db)
        .update("$tableECpH", modelECpH.toECpHMap(), where: "$ECpHIDCol = ?", whereArgs: [modelECpH.ECpHID]);
  }

  //Update ECpHSchedule Data
  Future<int> updateECpHScheduleData(ECpHScheduleModel modelECpHSchedule) async {
    return (await db).update("$tableECpHScheduleCol", modelECpHSchedule.toMapECpHSchedule(),
        where: "$ECpHScheduleIdCol = ?", whereArgs: [modelECpHSchedule.ECpHScheduleId]);
  }

  //Update ECpHMob Data
  Future<int> updateMobNoData(ECpHmobNoModel modelECpHMobNo) async {
    return (await db).update("$tableECpHMobNoCol", modelECpHMobNo.toMap_mobNo(),
        where: "$ECpHmobNoIdCol = ?", whereArgs: [modelECpHMobNo.ECpHmobNoId]);
  }

  //Get ECpH Data
  Future<ECpHModel> getECpHItems() async {
    var dbClient = await db;
    var result = await dbClient.rawQuery("SELECT * FROM $tableECpH");
    if (result.length == 0) return null;
    print("ECpH Data is: \n $result");
    return ECpHModel.fromECpHMap(result.first);
  }

  //Get ECpHSchedule Data
  Future<ECpHScheduleModel> getECpHScheduleItems() async {
    var dbClient = await db;
    var result = await dbClient.rawQuery("SELECT * FROM $tableECpHScheduleCol");
    if (result.length == 0) return null;
    print("ECpHScheduleModel Data is: \n $result");
    return ECpHScheduleModel.fromMapECpHSchedule(result.first);
  }

  //Get ECpHMob Data
  Future<ECpHmobNoModel> getECpHMobItems() async {
    var dbClient = await db;
    var result = await dbClient.rawQuery("SELECT * FROM $tableECpHMobNoCol");
    if (result.length == 0) return null;
    print("ECpHmobNoModel Data is: \n $result");
    return ECpHmobNoModel.fromMap_mobNo(result.first);
  }
}
