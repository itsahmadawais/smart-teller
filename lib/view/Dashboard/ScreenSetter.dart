import 'package:flutter/material.dart';
import 'package:fyp/controller/Dashboard/ScreenSetterController.dart';
import 'package:fyp/utils/ColorsPalete.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ScreenSetter extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return ScreenSetterState();
  }
  
}
class ScreenSetterState extends State<ScreenSetter>{
  ScreenSetterController screenSetterController = ScreenSetterController();
  int screenID;
  int optionID;
  int currentScreen;
  bool isLoaded=false;
  @override
  void initState(){
    super.initState();
    screenSetterController.screenSettingsModel.get_settings().then((value){
      setState(() {
        screenSetterController.screenSettingsModel=value;
        screenSetterController.screenSetterviaAPI();
        isLoaded=true;
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: isLoaded ? SingleChildScrollView(
        padding: EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "Screen Setter",
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
            Text("Tap on the screen grid to select any view for the Smart Mirror!"),
            SizedBox(height:20),
            GridView.count(
            primary: false,
            padding: const EdgeInsets.all(20),
            crossAxisSpacing: 0,
            mainAxisSpacing: 0,
            crossAxisCount: 3,
            shrinkWrap: true,
            children: List.generate(screenSetterController.screenNames.length, (index){
              return Card(
                child: InkWell(
                  onTap: (){
                    //screenSetterController.screenSelector(index);
                    setState(() {
                      this.screenID=screenSetterController.screenNames[index].screenID;
                      this.optionID=screenSetterController.screenNames[index].option.optionID;
                      this.currentScreen=index;
                    });
                    this.modalSheet(context);
                   
                  },
                  child:
                 
                  (screenSetterController.screenNames[index].screenID!=2 || screenSetterController.screenNames[index].screenID!=5)?
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(screenSetterController.screenNames[index].option.icon),
                      SizedBox(height:5),
                      Text(screenSetterController.screenNames[index].option.title)
                    ]
                  ):
                  Container()
                ),
              );
            }),
          )
          ],
        )
      )
      :
        Container(
          child: Center(
            child: CircularProgressIndicator(
              color: HexColor(ColorsPalete.primary_color),
            ),
          )
        )
    );
  }
  Widget modalSheet(BuildContext context){
    List<ScreenOptions> screenOptions = [];
    screenOptions = screenSetterController.screenOptions();
    if(this.screenID==2 || this.screenID==5){
      Fluttertoast.showToast(
        msg: "This screen is reserved for mirror.",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0
    );
      return null;
    }
    else{
     showModalBottomSheet(context: context,
                    builder: (context){
                      return StatefulBuilder(builder: (BuildContext context, StateSetter mystate){
                        return Container(
                        padding: EdgeInsets.all(20),
                        height: 220,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(20)
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Align(
  alignment: Alignment.topLeft,
  child: Text("Select Option", style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),)
  ),
  SizedBox(height: 20,),
                        Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: screenOptions.length,
              itemBuilder: (BuildContext context, int index) =>InkWell(
                onTap: (){
                 mystate((){
                  this.optionID=screenSetterController.screenNames[index].option.optionID;
                });
                setState((){
                  this.optionID=screenSetterController.screenNames[index].option.optionID;
                });
                setState(() {
                  this.screenSetterController.screenNames[currentScreen].option=screenOptions[index];       
                });
                screenSetterController.screenSettingsModel.update_settings().then((value){
                 if(value)
                 {
                    setState(() {
                      this.screenSetterController.screenSettingsUpdate();
                      this.screenSetterController.screenSettingsModel.update_settings();
                    });
                   Fluttertoast.showToast(
                      msg: "Settings Updated!",
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
                      msg: "Error in updating settings!",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                      fontSize: 16.0
                      );
                 }
                });
                Navigator.pop(context);
                },
                child: Card(
  shape: RoundedRectangleBorder( 
    side:(screenOptions[index].optionID==optionID)? BorderSide(color: HexColor(ColorsPalete.primary_color), width: 3) :
    BorderSide(color: Colors.white,width: 0),
    borderRadius: BorderRadius.circular(10),
  ),
                    child: Padding(
                      padding: EdgeInsets.only(
                        left: 10,
                        right: 10,
                        top:10,
                        bottom: 10
                      ),
                      child: Column(
                      children: [
                        Icon(screenOptions[index].icon,size: 80,),
                        Text(screenOptions[index].title)
                      ],
                    )
                    ),
                  )
              ),
            ),
          ),
                          ],
                        )
                      );
                      });
                    });
  }
  }
}