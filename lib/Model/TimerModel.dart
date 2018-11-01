class TimerModel{

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

  TimerModel(this.timer_ControllerID, this._timer_programNo,
      this._timer_StartTimeHrs, this._timer_StartTimeMin,
      this._timer_IntegrationDay_Mon, this._timer_IntegrationDay_Tues,
      this._timer_IntegrationDay_Wed, this._timer_IntegrationDay_Thurs,
      this._timer_IntegrationDay_Fri, this._timer_IntegrationDay_Sat,
      this._timer_IntegrationDay_Sun, this._timer_FertDay_Mon,
      this._timer_FertDay_Tue, this._timer_FertDay_Wed,
      this._timer_FertDay_Thurs, this._timer_FertDay_Fri,
      this._timer_FertDay_Sat, this._timer_FertDay_Sun);


}