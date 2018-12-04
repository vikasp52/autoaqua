import 'package:http/http.dart' as http;

class APIMethods {
  //Save the Controller data to server
  void saveDataToServer(String text, String number) {
    var url = "http://www.adevole.com/clients/autoaqua/autoaqua/api/controller/create/2";

    http.post(url, body: {"c_name": text, "c_number": number}).then((response) {
      if (response.statusCode == 200) {
        print("Success");
      } else {
        print("There is some problem");
      }
    });
    print("Response data");
  }

  //Update the Controller data to server
  void updateControllerOnServer(String controllerName, String controllerNumber, int controllerId) {
    var url = "http://www.adevole.com/clients/autoaqua/autoaqua/api/controller/update/2/$controllerId";

    http.post(url, body: {
      "c_name": controllerName,
      "c_number": controllerNumber,
    }).then((response) {
      if (response.statusCode == 200) {
        print("Success");
      } else {
        print("There is some problem");
      }
    });
    print("Response data");
  }

  //Delete the Controller data to server

  //Save and Update the Configuration Data
  void saveAndUpdateConfigDataOnServer(
    String maxPrograms,
    String maxOutputs,
    //String mobileNo,
    String numberOfSlave,
    String totalInjectors,
    String totalIrrigationValves,
    String totalFoggerValves,
    String totalValves,
    String freeOutput,
    String ecPhOn,
    String rtuOn,
    String phDelay,
    String slaveMoNo,
    //String mobile_No,
    String controllerId,
  ) {
    var url = "http://www.adevole.com/clients/autoaqua/autoaqua/api/controller/configuration/create/$controllerId";

    http.post(url, body: {
      "max_programs": maxPrograms,
      "max_outputs": maxOutputs,
      //"mobile_no": slaveId,
      "no_of_slaves": numberOfSlave,
      "total_Injectors": totalInjectors,
      "total_IrrigationValves": totalIrrigationValves,
      "total_FoggerValves": totalFoggerValves,
      "total_Valves": totalValves,
      "free_Output": freeOutput,
      "ecPh_on": ecPhOn,
      "rtu_on": rtuOn,
      "ph_delay": phDelay,
      "configRTUMobNo": slaveMoNo,
      //"mobile_no1": mobile_No
    }).then((response) {
      print("Response status: ${response.statusCode}");
      print("Response body: ${response.body}");
    });
    print("Response data");
  }

  //Save and Update the program data
  void saveAndUpdateProgramDataOnServer(
    program_number,
    noOfValve,
    irrigationBy,
    fertigationBy,
    sersorOverride,
    filterBackFlushOn,
    filterbackflushType,
    intervalAfter,
    timeFor,
    controllerID,
  ) {
    var url = "http://www.adevole.com/clients/autoaqua/autoaqua/api/controller/program/create/$controllerID";

    http.post(url, body: {
      "program_number": program_number,
      "outputs": noOfValve,
      "intervals": intervalAfter,
      "time": timeFor,
      "IrrigationBy": irrigationBy,
      "FertigationBy": fertigationBy,
      "SensorOverride": sersorOverride,
      "FilterBackflush_On": filterBackFlushOn,
      "filterbackflushType": filterbackflushType
    }).then((response) {
      print("Program Response status: ${response.statusCode}");
      print("Program Response body: ${response.body}");
    });
  }

  //Save and Update the Valves data
void saveAndUpdateValvesDataOnServer(
    programNo,
    seqNo,
    valveUnitType,
    tankUnitType,
    valveNo1,
    valveNo2,
    valveNo3,
    valveNo4,
    valveDetails1,
    valveDetails2,
    valveDetails3,
    valveDetails4,
    fertProgramming,
    preDelay,
    postDelay,
    tank1,
    tank2,
    tank3,
    tank4,
    ecValues,
    pHValues,
    controllerId
    ){

    var url = "http://www.adevole.com/clients/autoaqua/autoaqua/api/controller/valves/create/$controllerId";

    http.post(url,body: {
    "seq":seqNo,
    "valves_unit_type":valveUnitType,
    "tank_unit_type":tankUnitType,
    "tank_1":tank1,
    "tank_2":tank2,
    "tank_3":tank3,
    "tank_4":tank4,
    "fertilizer_delays":preDelay,
    "fertilizer_type":fertProgramming,
    "ecset":ecValues,
    "phset":pHValues,
    "valveNo1":valveNo1,
    "valveNo2":valveNo2,
    "valveNo3":valveNo3,
    "valveNo4":valveNo4,
    "valveFieldNo1":valveDetails1,
    "valveFieldNo2":valveDetails2,
    "valveFieldNo3":valveDetails3,
    "valveFieldNo4":valveDetails4,
    "fertilizer_delays_post":postDelay,
    "program_no":programNo
    }).then((response) {
      print("Valves Response status: ${response.statusCode}");
      print("Valves Response body: ${response.body}");
    });
}

//Save and Update the timer data
void saveAndUpdateTimerData(
    controllerId,
    programId,
    timeHrs,
    timeMins,
    irrson,
    irrmon,
    irrtue,
    irrwed,
    irrthu,
    irrfri,
    irrsat,
    frdson,
    frdmon,
    frdtue,
    frdwed,
    frdthu,
    frdfri,
    frdsat){

    var url = "http://www.adevole.com/clients/autoaqua/autoaqua/api/controller/timing/create/$controllerId";

    http.post(url, body: {
    "program_id": programId,
    "start_time_hr": timeHrs,
    "start_time_min": timeMins,
    "irr_sun":irrson,
    "irr_mon":irrmon,
    "irr_tue":irrtue,
    "irr_wed":irrwed,
    "irr_thu":irrthu,
    "irr_fri":irrfri,
    "irr_sat":irrsat,
    "fer_sun":frdson,
    "fer_mon":frdmon,
    "fer_tue":frdtue,
    "fer_wed":frdwed,
    "fer_thu":frdthu,
    "fer_fri":frdfri,
    "fer_sat":frdsat
    }).then((response) {
      print("Program Response status: ${response.statusCode}");
      print("Program Response body: ${response.body}");
    });
}

}
