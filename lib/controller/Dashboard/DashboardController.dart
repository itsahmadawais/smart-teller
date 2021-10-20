
import 'package:flutter/cupertino.dart';
import '../../view/Dashboard/AccountInfo.dart';
import '../../view/Dashboard/GesturesSetting.dart';
import '../../view/Dashboard/ScreenSetter.dart';

class DashboardController{
  int index=1;
  List<Widget> widgetsList = [GesturesSetting(),ScreenSetter(),AccountInfo()];
  GlobalKey bottomNavigationKey = GlobalKey();
}