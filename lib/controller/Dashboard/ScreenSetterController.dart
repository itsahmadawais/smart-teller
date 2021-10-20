import 'package:flutter/material.dart';
import '../../model/ScreenSettingsModel.dart';

class ScreenOptions{
  String title;
  IconData icon;
  int optionID;
 static  ScreenOptions setOption(int option_id){
    ScreenOptions temp_option = ScreenOptions();
    switch(option_id){
      case 1:
        temp_option.optionID=1;
        temp_option.title="News Feed";
        temp_option.icon=Icons.new_releases_outlined;
        break;
      case 2:
        temp_option.optionID=2;
        temp_option.title="Timeline";
        temp_option.icon=Icons.timeline_outlined;
        break;
      case 3:
        temp_option.optionID=3;
        temp_option.title="Date Time";
        temp_option.icon=Icons.timer_outlined;
        break;
      case 4:
        temp_option.optionID=4;
        temp_option.title="Time Table";
        temp_option.icon=Icons.table_chart_outlined;
        break;
      case 5:
        temp_option.optionID=5;
        temp_option.title="Attendence";
        temp_option.icon=Icons.check_circle_outline_sharp;
        break;
      case 6:
        temp_option.optionID=6;
        temp_option.title="Weather";
        temp_option.icon=Icons.wb_sunny_outlined;
        break;
      case 7:
        temp_option.optionID=7;
        temp_option.title="Motivation";
        temp_option.icon=Icons.lightbulb_outline;
        break;
      case 8:
        temp_option.optionID=8;
        temp_option.title="Alert";
        temp_option.icon=Icons.add_alert_outlined;
        break;
      case 9:
        temp_option.optionID=9;
        temp_option.title="A.Calendar";
        temp_option.icon=Icons.list_alt_outlined;
        break;
      case 10:
        temp_option.optionID=10;
        temp_option.title="Calander";
        temp_option.icon=Icons.calendar_today_outlined;
        break;
    }
    return temp_option;
  }
}
class ScreenName{
  ScreenOptions option = new ScreenOptions();
  int screenID;
}
class ScreenSetterController{
  List<ScreenName> screenNames =[];
  ScreenSettingsModel screenSettingsModel = new ScreenSettingsModel();
  ScreenSetterController(){
  }
  void screenSetterviaAPI(){
    ScreenName sname = new ScreenName();
    screenNames.clear();
    screenSettingsModel.screenData.screenChoice.forEach((element) {
      sname = new ScreenName();
      sname.screenID=element.screenId;
      if(element.screenId==2 || element.screenId==5)
      {
        sname.option.title="";
      }
      else
      {
        sname.option = ScreenOptions.setOption(element.option);
      }
      screenNames.add(sname);
    });
  }
  void screenSetter(){
    ScreenName sname = new ScreenName();
    int i=1;
    sname = new ScreenName();
    sname.screenID=i;
    sname.option = ScreenOptions.setOption(i);
    screenNames.add(sname);

    i=2;
    sname = new ScreenName();
    sname.screenID=i;
    sname.option.title="";
    screenNames.add(sname);

    i=3;
    sname = new ScreenName();
    sname.screenID=i;
    sname.option = ScreenOptions.setOption(2);
    screenNames.add(sname);

    i=4;
    sname = new ScreenName();
    sname.screenID=i;
    sname.option = ScreenOptions.setOption(3);
    screenNames.add(sname);

    i=5;
    sname = new ScreenName();
    sname.screenID=i;
    sname.option.title="";
    screenNames.add(sname);

    i=6;
    sname = new ScreenName();
    sname.screenID=i;
    sname.option = ScreenOptions.setOption(4);
    screenNames.add(sname);

    i=7;
    sname = new ScreenName();
    sname.screenID=i;
    sname.option = ScreenOptions.setOption(5);
    screenNames.add(sname);

    i=8;
    sname = new ScreenName();
    sname.screenID=i;
    sname.option = ScreenOptions.setOption(6);
    screenNames.add(sname);

    i=9;
    sname = new ScreenName();
    sname.screenID=i;
    sname.option = ScreenOptions.setOption(7);
    screenNames.add(sname);

    i=10;
    sname = new ScreenName();
    sname.screenID=i;
    sname.option = ScreenOptions.setOption(8);
    screenNames.add(sname);

    i=11;
    sname = new ScreenName();
    sname.screenID=i;
    sname.option = ScreenOptions.setOption(9);
    screenNames.add(sname);

    i=12;
    sname = new ScreenName();
    sname.screenID=i;
    sname.option = ScreenOptions.setOption(10);
    screenNames.add(sname);
  }
  List<ScreenOptions> screenOptions(){
    List<ScreenOptions> options = [];
    ScreenOptions temp_option = new ScreenOptions();
    for(int i=1;i<=10;i++)
    {
      temp_option = new ScreenOptions();
      temp_option = ScreenOptions.setOption(i);
      options.add(temp_option);
    }
    return options;
  }
  void screenSettingsUpdate()
  {
    screenSettingsModel.screenData.screenChoice.clear();
    screenNames.forEach((element) {
      ScreenChoice screenChoice = new ScreenChoice();
      screenChoice.screenId=element.screenID;
      screenChoice.option=element.option.optionID;
      screenSettingsModel.screenData.screenChoice.add(screenChoice);
    });
  }
}