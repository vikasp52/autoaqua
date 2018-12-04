class TimerModel {
  int _timerId;
  int timer_ControllerID;
  int _timer_programNo;
  String _timer_StartTimeHrs;
  String _timer_StartTimeMin;
  String _timer_IntegrationDay_Mon;
  String _timer_IntegrationDay_Tues;
  String _timer_IntegrationDay_Wed;
  String _timer_IntegrationDay_Thurs;
  String _timer_IntegrationDay_Fri;
  String _timer_IntegrationDay_Sat;
  String _timer_IntegrationDay_Sun;
  String _timer_FertDay_Mon;
  String _timer_FertDay_Tue;
  String _timer_FertDay_Wed;
  String _timer_FertDay_Thurs;
  String _timer_FertDay_Fri;
  String _timer_FertDay_Sat;
  String _timer_FertDay_Sun;
  String _timer_DateCreated;

  TimerModel(
      this.timer_ControllerID,
      this._timer_programNo,
      this._timer_StartTimeHrs,
      this._timer_StartTimeMin,
      this._timer_IntegrationDay_Mon,
      this._timer_IntegrationDay_Tues,
      this._timer_IntegrationDay_Wed,
      this._timer_IntegrationDay_Thurs,
      this._timer_IntegrationDay_Fri,
      this._timer_IntegrationDay_Sat,
      this._timer_IntegrationDay_Sun,
      this._timer_FertDay_Mon,
      this._timer_FertDay_Tue,
      this._timer_FertDay_Wed,
      this._timer_FertDay_Thurs,
      this._timer_FertDay_Fri,
      this._timer_FertDay_Sat,
      this._timer_FertDay_Sun,
      this._timer_DateCreated,
      [this._timerId]
      );

  TimerModel.map(dynamic obj) {
    this._timerId = obj["timerId"];
    this.timer_ControllerID = obj["timer_controller_id"];
    this._timer_programNo = obj["timer_programNo"];
    this._timer_StartTimeHrs = obj["timer_StartTimer_Hrs"];
    this._timer_StartTimeMin = obj["timer_StartTimer_Min"];
    this._timer_IntegrationDay_Mon = obj["timer_IntegrationDay_Mon"];
    this._timer_IntegrationDay_Tues = obj["timer_IntegrationDay_Tue"];
    this._timer_IntegrationDay_Wed = obj["timer_IntegrationDay_Wed"];
    this._timer_IntegrationDay_Thurs = obj["timer_IntegrationDay_Thur"];
    this._timer_IntegrationDay_Fri = obj["timer_IntegrationDay_Fri"];
    this._timer_IntegrationDay_Sat = obj["timer_IntegrationDay_Sat"];
    this._timer_IntegrationDay_Sun = obj["timer_IntegrationDay_Sun"];
    this._timer_FertDay_Mon = obj["timer_FertDay_Mon"];
    this._timer_FertDay_Tue = obj["timer_FertDay_Tue"];
    this._timer_FertDay_Wed = obj["timer_FertDay_Wed"];
    this._timer_FertDay_Thurs = obj["timer_FertDay_Thurs"];
    this._timer_FertDay_Fri = obj["timer_FertDay_Fri"];
    this._timer_FertDay_Sat = obj["timer_FertDay_Sat"];
    this._timer_FertDay_Sun = obj["timer_FertDay_Sun"];
    this._timer_DateCreated = obj["timer_DateCreated"];
    this._timer_DateCreated = obj["timer_DateCreated"];
  }

  int get timerId => _timerId;
  int get  timer_controller_id => timer_ControllerID;
  int get timer_programNo => _timer_programNo;
  String get timer_StartTimer_Hrs => _timer_StartTimeHrs;
  String get timer_StartTimer_Min => _timer_StartTimeMin;
  String get timer_IntegrationDay_Mon => _timer_IntegrationDay_Mon;
  String get timer_IntegrationDay_Tue => _timer_IntegrationDay_Tues;
  String get timer_IntegrationDay_Wed => _timer_IntegrationDay_Wed;
  String get timer_IntegrationDay_Thur => _timer_IntegrationDay_Thurs;
  String get timer_IntegrationDay_Fri => _timer_IntegrationDay_Fri;
  String get timer_IntegrationDay_Sat => _timer_IntegrationDay_Sat;
  String get timer_IntegrationDay_Sun => _timer_IntegrationDay_Sun;
  String get timer_FertDay_Mon => _timer_FertDay_Mon;
  String get timer_FertDay_Tue => _timer_FertDay_Tue;
  String get timer_FertDay_Wed => _timer_FertDay_Wed;
  String get timer_FertDay_Thurs => _timer_FertDay_Thurs;
  String get timer_FertDay_Fri => _timer_FertDay_Fri;
  String get timer_FertDay_Sat => _timer_FertDay_Sat;
  String get timer_FertDay_Sun => _timer_FertDay_Sun;
  String get timer_DateCreated => _timer_DateCreated;

  Map<String, dynamic> toMap_Timer(){
    var mapTimer = new Map<String, dynamic>();
      if(timerId != null){
        mapTimer["timerId"] = _timerId;
      }
      //mapTimer["timerId"] = _timerId;
      mapTimer["timer_controller_id"] = timer_ControllerID;
      mapTimer["timer_programNo"] = _timer_programNo;
      mapTimer["timer_StartTimer_Hrs"] = _timer_StartTimeHrs;
      mapTimer["timer_StartTimer_Min"] = _timer_StartTimeMin;
      mapTimer["timer_IntegrationDay_Mon"] = _timer_IntegrationDay_Mon;
      mapTimer["timer_IntegrationDay_Tue"] = _timer_IntegrationDay_Tues;
      mapTimer["timer_IntegrationDay_Wed"] = _timer_IntegrationDay_Wed;
      mapTimer["timer_IntegrationDay_Thur"] = _timer_IntegrationDay_Thurs;
      mapTimer["timer_IntegrationDay_Fri"] = _timer_IntegrationDay_Fri;
      mapTimer["timer_IntegrationDay_Sat"] = _timer_IntegrationDay_Sat;
      mapTimer["timer_IntegrationDay_Sun"] = _timer_IntegrationDay_Sun;
      mapTimer["timer_FertDay_Mon"] = _timer_FertDay_Mon;
      mapTimer["timer_FertDay_Tue"] = _timer_FertDay_Tue;
      mapTimer["timer_FertDay_Wed"] = _timer_FertDay_Wed;
      mapTimer["timer_FertDay_Thurs"] = _timer_FertDay_Thurs;
      mapTimer["timer_FertDay_Fri"] = _timer_FertDay_Fri;
      mapTimer["timer_FertDay_Sat"] = _timer_FertDay_Sat;
      mapTimer["timer_FertDay_Sun"] = _timer_FertDay_Sun;
      mapTimer["timer_DateCreated"] = _timer_DateCreated;

      return mapTimer;
  }

  TimerModel.fromMap_timer(Map<String, dynamic>mapTimer){
    this._timerId = mapTimer["timerId"];
    this.timer_ControllerID = mapTimer["timer_controller_id"];
    this._timer_programNo = mapTimer["timer_programNo"];
    this._timer_StartTimeHrs = mapTimer["timer_StartTimer_Hrs"];
    this._timer_StartTimeMin = mapTimer["timer_StartTimer_Min"];
    this._timer_IntegrationDay_Mon = mapTimer["timer_IntegrationDay_Mon"];
    this._timer_IntegrationDay_Tues = mapTimer["timer_IntegrationDay_Tue"];
    this._timer_IntegrationDay_Wed = mapTimer["timer_IntegrationDay_Wed"];
    this._timer_IntegrationDay_Thurs = mapTimer["timer_IntegrationDay_Thur"];
    this._timer_IntegrationDay_Fri = mapTimer["timer_IntegrationDay_Fri"];
    this._timer_IntegrationDay_Sat = mapTimer["timer_IntegrationDay_Sat"];
    this._timer_IntegrationDay_Sun = mapTimer["timer_IntegrationDay_Sun"];
    this._timer_FertDay_Mon = mapTimer["timer_FertDay_Mon"];
    this._timer_FertDay_Tue = mapTimer["timer_FertDay_Tue"];
    this._timer_FertDay_Wed = mapTimer["timer_FertDay_Wed"];
    this._timer_FertDay_Thurs = mapTimer["timer_FertDay_Thurs"];
    this._timer_FertDay_Fri = mapTimer["timer_FertDay_Fri"];
    this._timer_FertDay_Sat = mapTimer["timer_FertDay_Sat"];
    this._timer_FertDay_Sun = mapTimer["timer_FertDay_Sun"];
    this._timer_DateCreated = mapTimer["timer_DateCreated"];
  }



}
