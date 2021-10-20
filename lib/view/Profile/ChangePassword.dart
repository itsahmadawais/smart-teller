
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fyp/model/Authentication/AuthModel.dart';
import 'package:fyp/utils/ColorsPalete.dart';
import 'package:fyp/utils/ProjectUtils.dart';
import 'package:hexcolor/hexcolor.dart';


class ChangePassword extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return ChangePasswordState();
  }
  
}
class ChangePasswordState extends State<ChangePassword>{

  final TextEditingController passwordController = new TextEditingController();
  final TextEditingController passwordController1 = new TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  GlobalKey<FormState> _form = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    ProjectUtils projectUtils = new ProjectUtils();
    projectUtils.mediaSize(context);
    return Scaffold(
      body: new Container(
        color: Colors.white,
        padding: EdgeInsets.all(40),
        child: new Column(
          children: <Widget>[
            new SizedBox(height: 100,),
            new Align(
              alignment: Alignment.bottomLeft,
              child: new Text(
                "Change Password",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold
                ),
                )
            ),
            new SizedBox(height: 40,),
            new Form(
              key: _form,
              child: new Container(
                child: new Column(
                  children: <Widget>[
                    new TextFormField(
                      controller: passwordController,
                      decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12.0)),
                        borderSide: BorderSide(color: Color.fromRGBO(231, 241, 239, 0.8), width: 1),
                      ),
                        hintText: "Password",
                        border:OutlineInputBorder(),
                        prefixIcon: Icon(Icons.pages_outlined)
                      ),
                      validator: (String value) {
                          if (value.trim().isEmpty) {
                            return 'Password is missing';
                          }
                          else if(passwordController1.text.trim().isNotEmpty && passwordController1.text.trim().toString()!=value)
                          {
                            return "Password mismatch!";
                          }
                      }
                    ),
                    new SizedBox(height:20),
                    new TextFormField(
                      controller: passwordController1,
                      decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12.0)),
                        borderSide: BorderSide(color: Color.fromRGBO(231, 241, 239, 0.8), width: 1),
                      ),
                        hintText: "Confirm Password",
                        border:OutlineInputBorder(),
                        prefixIcon: Icon(Icons.pages_outlined)
                      ),
                      validator: (String value) {
                          if (value.trim().isEmpty) {
                            return 'Confirm password is missing';
                          } 
                          else
                          {
                            
                          }
                      }
                    ),
                    new SizedBox(height:20),
                    new Container(
                    width: (projectUtils.screenWidth<=375) ? projectUtils.screenWidth : 400,
                    child: new ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: new FlatButton(
                        padding: (projectUtils.screenWidth<=375) ? 
                        EdgeInsets.symmetric(vertical:  projectUtils.screenHeight / 40 ,horizontal: projectUtils.screenWidth/10)
                        :
                        EdgeInsets.symmetric(vertical: 30 ,horizontal: projectUtils.screenWidth/10)
                        ,
                        color: HexColor(ColorsPalete.primary_color),
                        onPressed: (){
                          var is_validated = _form.currentState.validate();
                          if(is_validated)
                          {
                            AuthModel.update_password(passwordController.text.trim().toString()).then((value){
                              if(value)
                              {
                                _form.currentState.reset();
                                passwordController.text="";
                                passwordController1.text="";
                                Fluttertoast.showToast(
                                msg: "Password updated!",
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
                                msg: "Error: Password could not be updated!",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.CENTER,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                                fontSize: 16.0
                                );
                              }
                            });
                          }
                        },
                        child: new Text(
                          "Update Password",
                          style: new TextStyle(
                            color: Colors.white
                          ),
                          )
                        )
                    )
                    )
                  ],
                ),
              )
            )],
          )
      )
    );
  }
  
}