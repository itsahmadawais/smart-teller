import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fyp/model/Authentication/AuthModel.dart';
import 'package:fyp/utils/ColorsPalete.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hexcolor/hexcolor.dart';

import 'Authentication/Login.dart';
import 'Dashboard/Dashboard.dart';

class SplashScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return SplashScreenState();
  }
}
class SplashScreenState extends State<SplashScreen>{
  final GetStorage session = new GetStorage();
  @override
  void initState(){
    super.initState();
    Timer(Duration(seconds: 3), (){
      var isLoggedIn = session.read('loggedIn');
      print("################LOGGEDIN#################");
      print(isLoggedIn);
      if(isLoggedIn!=null && isLoggedIn=="true")
      {
        AuthModel.check_token_validity().then((value){
          if(value)
          {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => Dashboard()),
              );
          }
          else
          {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => Login()),
            );
          }
        });
      }
      else{
        {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Login()),
        );
      }
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        color: HexColor(ColorsPalete.primary_color),
       child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset('assets/images/logo_splash.png', width: 150,),
            SizedBox(height: 10,),
            Text("Developed by Smart Team", style: TextStyle(color: Colors.white),),
            SizedBox(height: 15,),
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            )
          ],
        ),
      )
    );
  }
  
}