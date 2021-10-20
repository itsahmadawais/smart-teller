import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fyp/controller/Dashboard/GesturesSettingController.dart';
import 'package:fyp/utils/ColorsPalete.dart';
import 'package:fyp/utils/ProjectUtils.dart';
import 'package:hexcolor/hexcolor.dart';

class GesturesSetting extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return GesturesSettingState();
  }
  
}
class GesturesSettingState extends State<GesturesSetting>{
  GesturesSettingController gesturesSettingController = new GesturesSettingController();
  bool screenLoaded=false;
  @override
  void initState(){
    super.initState();
    gesturesSettingController.screenSettingsModel.get_settings().then((value){
      setState(() {
        gesturesSettingController.screenSettingsModel = value;
        gesturesSettingController.GestureSetter();
        screenLoaded=true;
      });
    });
  }
  void updateSettings()
  {
    setState(() {
      gesturesSettingController.updateSettings();
      gesturesSettingController.screenSettingsModel.update_settings().then((value){
        if(value)
        {
          Fluttertoast.showToast(
                    msg: "Gesture updated!",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.red,
                    textColor: Colors.white,
                    fontSize: 16.0
                );
        }
        else
        {
          Fluttertoast.showToast(
                    msg: " Error while updating gesture!",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.red,
                    textColor: Colors.white,
                    fontSize: 16.0
                );
        }
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: screenLoaded ? Container(
          padding: EdgeInsets.all(10),
          child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "Gestures Setting",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.black
              ),
            ),
            Container(
              height: 5,
              width: 140,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25.0),
                color: HexColor(ColorsPalete.primary_color),
              ),
            ),
            SizedBox(height:10),
            Text("Select any gesture for the actions."),
            SizedBox(height:20),
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color:  Colors.white,
                border: Border.all(
                  width: 2.0,
                  color: Colors.white12
                ),
                boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
              ),
              child: Column(
                children: <Widget>[
                  Text(
              "Selfie Gesture",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20
              ),
            ),
            IntrinsicHeight(
            child:Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                InkWell(
                  onTap: (){
                    setState((){
                      gesturesSettingController.gestureSelfie.img1=0;
                      gesturesSettingController.gestureSelfie.img2=1;
                    });
                    this.updateSettings();
                  },
                  child: ColorFiltered(
                        colorFilter: ColorFilter.matrix((gesturesSettingController.gestureSelfie.img1==0)?  NO_FILTER : GRAY_FILTER),
                        child: new Image.asset(
                      "assets/icons/gesture_0.png",
                      width: 130,
                      colorBlendMode: BlendMode.softLight,
                    )
                ),
                ),
                Container(
                  height: 80,
                  child: VerticalDivider(
                    color: Colors.grey.withOpacity(0.3)
                  )
                ),
                InkWell(
                  onTap: (){
                    setState((){
                      gesturesSettingController.gestureSelfie.img1=1;
                      gesturesSettingController.gestureSelfie.img2=0;
                    });
                    this.updateSettings();
                  },
                  child: ColorFiltered(
                        colorFilter: ColorFilter.matrix((gesturesSettingController.gestureSelfie.img2==0)?  NO_FILTER : GRAY_FILTER),
                        child: new Image.asset(
                      "assets/icons/gesture_1.png",
                      width: 130,
                      colorBlendMode: BlendMode.softLight,
                    )
                ),
                )
              ],
            )
            )
                ],
              ),
            ),
            SizedBox(height: 20,),
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color:  Colors.white,
                border: Border.all(
                  width: 2.0,
                  color: Colors.white12
                ),
                boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
              ),
              child: Column(
                children: <Widget>[
                  Text(
              "Logout Gesture",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20
              ),
            ),
            IntrinsicHeight(
            child:Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                InkWell(
                  onTap: (){
                    setState((){
                      gesturesSettingController.gesturesLogout.img2=1;
                      gesturesSettingController.gesturesLogout.img1=0;
                    });
                    this.updateSettings();
                  },
                  child: ColorFiltered(
                        colorFilter: ColorFilter.matrix((gesturesSettingController.gesturesLogout.img1==0)?  NO_FILTER : GRAY_FILTER),
                        child: new Image.asset(
                      "assets/icons/gesture_2.png",
                      width: 130,
                      colorBlendMode: BlendMode.softLight,
                    )
                ),
                ),
                Container(
                  height: 80,
                  child: VerticalDivider(
                    color: Colors.grey.withOpacity(0.3)
                  )
                ),
               InkWell(
                  onTap: (){
                    setState((){
                      gesturesSettingController.gesturesLogout.img2=0;
                      gesturesSettingController.gesturesLogout.img1=1;
                    });
                    this.updateSettings();
                  },
                  child: ColorFiltered(
                        colorFilter: ColorFilter.matrix((gesturesSettingController.gesturesLogout.img2==0)?  NO_FILTER : GRAY_FILTER),
                        child: new Image.asset(
                      "assets/icons/gesture_3.png",
                      width: 130,
                      colorBlendMode: BlendMode.softLight,
                    )
                ),
                )
              ],
            )
            )
                ],
              ),
            )
          ]
        ),
        )
        :
        Container(
          child: Center(
            child: CircularProgressIndicator(
              color: HexColor(ColorsPalete.primary_color),
            ),
          )
        )
      )
    );
  }

}