import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';
import 'package:hexcolor/hexcolor.dart';
import '../../utils/ColorsPalete.dart';
import '../Dashboard/Dashboard.dart';

import '../../controller/Authentication/AuthController.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Login extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return LoginState();
  }
}
class LoginState extends State<Login>{

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  GlobalKey<FormState> _form = GlobalKey<FormState>();
  AuthController authController = new AuthController();

  var inputBorder= OutlineInputBorder(
    borderRadius: BorderRadius.circular(25.0),
    borderSide: BorderSide(
      color: HexColor(
        ColorsPalete.primary_text_color),
      ),
    );
  var inputWhite=TextStyle(
    color: Colors.white
    );
  @override
  Widget build(Object context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Container(
        padding: EdgeInsets.all(20),
        color: HexColor(ColorsPalete.primary_color),
        child:Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                "assets/images/logo.png",
                width: 200,
                ),
                Form(
                  key: _form,
                  child: Column(
                    children: [
                      /* Email */
                      TextFormField(
                        controller: authController.emailController,
                        decoration : InputDecoration(
                          prefixIcon: Icon(
                            Icons.email,
                            color: HexColor(ColorsPalete.primary_text_color),
                            ),
                          hintText: "Your email address",
                          labelText: "Email",
                          hintStyle: inputWhite,
                          labelStyle: inputWhite,
                          focusedBorder: inputBorder,
                          enabledBorder: inputBorder,
                          ),
                      ),
                      SizedBox(height:20),
                      /* Password */
                      TextFormField(
                        controller: authController.passwordController,
                        obscureText: true,
                        decoration : InputDecoration(
                          prefixIcon: Icon(
                            Icons.lock,
                            color: HexColor(ColorsPalete.primary_text_color)
                          ),
                          hintText: "Account's password",
                          labelText: "Password",
                          focusedBorder: inputBorder,
                          enabledBorder: inputBorder,
                          hintStyle: inputWhite,
                          labelStyle: inputWhite
                          ),
                      ),
                      SizedBox(height:20),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(25.0),
                              ),
                            primary: HexColor(ColorsPalete.btn_color)
                          ),
                          onPressed: () async {
                            bool emailValid = false;
                            if(authController.emailController.text.isEmpty || authController.passwordController.text.isEmpty)
                            {
                               Fluttertoast.showToast(
                                  msg: "Login details required!",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.CENTER,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.red,
                                  textColor: Colors.white,
                                  fontSize: 16.0
                                );
                            }
                            else if(emailValid)
                            {
                              Fluttertoast.showToast(
                                  msg: "Email is invalid!",
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
                              authController.authmodel.set_login(
                                authController.emailController.text.trim(),
                                authController.passwordController.text.trim())
                              .then((isLoggedIn){
                                 print("#################IS LOGGED IN @@@@@@@@@@@@@@@@");
                                 print(isLoggedIn.toString());
                                if(isLoggedIn){
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(builder: (context) => Dashboard()),
                                  );
                                }
                                else{
                                  Fluttertoast.showToast(
                                    msg: "Login error, please check login details or try later!",
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
                          child:Container(
                            padding: EdgeInsets.all(15),
                            child: Text("Login"),
                          )
                        )
                      )
                    ],
                  ),
                )
            ],
          )
      )
      )
    );
  }
  
}