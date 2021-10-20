
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:fyp/controller/Dashboard/DashboardController.dart';
import 'package:fyp/utils/ColorsPalete.dart';
import 'package:hexcolor/hexcolor.dart';

class Dashboard extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return DashboardState();
  }
  
}
class DashboardState extends State<Dashboard>{
  DashboardController dashboardController = DashboardController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: CurvedNavigationBar(
        key: dashboardController.bottomNavigationKey,
        index: 1,
        backgroundColor: Colors.transparent,
        color: HexColor(ColorsPalete.primary_color),
        height:55,
        items: <Widget>[
          Icon(Icons.gesture, size: 30, color: Colors.white,),
          Icon(Icons.home, size: 30, color: Colors.white,),
          Icon(Icons.settings, size: 30, color: Colors.white,),
        ],
        onTap: (index) {
          setState(() {
            dashboardController.index=index;
          });
        },
      ),
      body: SafeArea(
        child: Container(
          child: dashboardController.widgetsList[dashboardController.index],
          )
        )
      );
  }
  
}