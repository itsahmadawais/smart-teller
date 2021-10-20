
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_validator/form_validator.dart';
import 'package:fyp/model/ProfileModel.dart';
import 'package:fyp/utils/ColorsPalete.dart';
import 'package:fyp/utils/ProjectUtils.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';

class EditProfile extends StatefulWidget{
  ProfileModel profileModel = new ProfileModel();
  EditProfile(this.profileModel);
  @override
  State<StatefulWidget> createState() {
    return EditProfileState(this.profileModel);
  }
  
}

class EditProfileState extends State<EditProfile>{

  final TextEditingController usernameController = new TextEditingController();
  final TextEditingController emailController = new TextEditingController();
  final TextEditingController fnameController = new TextEditingController();
  final TextEditingController lnameController = new TextEditingController();
  final TextEditingController addressController = new TextEditingController();
  final TextEditingController cityController = new TextEditingController();
  final TextEditingController phoneController = new TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  GlobalKey<FormState> _form = GlobalKey<FormState>();
  String selectedvalue;
  ProfileModel profileModel = new ProfileModel();
  
  EditProfileState(this.profileModel);

  @override
  void initState(){
    setState(() {
      usernameController.text=profileModel.profileData.username;
      emailController.text=profileModel.profileData.email;
      fnameController.text=profileModel.profileData.firstname;
      lnameController.text=profileModel.profileData.lastname;
      addressController.text=profileModel.profileData.address;
      cityController.text=profileModel.profileData.city;
      phoneController.text=profileModel.profileData.phone1;
    });
  }
  
  @override
  Widget build(BuildContext context) {
    ProjectUtils projectUtils = new ProjectUtils();
    projectUtils.mediaSize(context);
    return Scaffold(
      body: new Container(
        color: Colors.white,
        padding: EdgeInsets.all(40),
        child: new ListView(
         children: <Widget>[
            new Column(
          children: <Widget>[
            new SizedBox(height: 20,),
            new Align(
              alignment: Alignment.bottomLeft,
              child: new Text(
                "Profile Settings",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold
                ),
                )
            ),
            new SizedBox(height: 20,),
            new Form(
              key: _form,
              child: new Container(
                child: new Column(
                  children: <Widget>[
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: new Text(
                      "Username(Can't change)",
                      textAlign: TextAlign.start,
                    ),
                    ),
                    new SizedBox(height: 5,),
                    new TextFormField(
                      controller: usernameController,
                      readOnly: true,
                      decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12.0)),
                        borderSide: BorderSide(color: Color.fromRGBO(231, 241, 239, 0.8), width: 1),
                      ),
                        hintText: "Username",
                        border:OutlineInputBorder(),
                        prefixIcon: Icon(Icons.verified_user)
                      ),
                      validator: (String value) {
                          if (value.trim().isEmpty) {
                            return 'Name is missing!';
                          }
                          else
                          {
                            
                          }
                      }
                    ),
                    new SizedBox(height:20),
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: new Text(
                      "First Name",
                      textAlign: TextAlign.start,
                    ),
                    ),
                    new SizedBox(height: 5,),
                    new TextFormField(
                      controller: fnameController,
                      decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12.0)),
                        borderSide: BorderSide(color: Color.fromRGBO(231, 241, 239, 0.8), width: 1),
                      ),
                        hintText: "First Name",
                        border:OutlineInputBorder(),
                        prefixIcon: Icon(Icons.account_circle_outlined)
                      ),
                      validator: (String value) {
                          if (value.trim().isEmpty) {
                            return 'First name is missing!';
                          }
                          else
                          {
                            
                          }
                      }
                    ),
                    new SizedBox(height:20),
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: new Text(
                      "Last Name",
                      textAlign: TextAlign.start,
                    ),
                    ),
                    new SizedBox(height: 5,),
                    new TextFormField(
                      controller: lnameController,
                      decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12.0)),
                        borderSide: BorderSide(color: Color.fromRGBO(231, 241, 239, 0.8), width: 1),
                      ),
                        hintText: "Last Name",
                        border:OutlineInputBorder(),
                        prefixIcon: Icon(Icons.account_circle_outlined)
                      ),
                      validator: (String value) {
                          if (value.trim().isEmpty) {
                            return 'Last name is missing!';
                          }
                          else
                          {
                            
                          }
                      }
                    ),
                    new SizedBox(height:20),
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: new Text(
                      "Email(Can't Change)",
                      textAlign: TextAlign.start,
                    ),
                    ),
                    new SizedBox(height: 5,),
                    new TextFormField(
                      readOnly: true,
                  controller: emailController,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12.0)),
                      borderSide: BorderSide(color: Color.fromRGBO(231, 241, 239, 0.8), width: 1),
                      ),
                    hintText: "Email",
                    border:OutlineInputBorder(),
                    prefixIcon: Icon(Icons.email)
                  ),
                  validator: (String value) {
                      if (value.trim().isEmpty) {
                        return 'Email is Missing';
                      }
                      else
                      {
                        
                      }
                  }
                ),
                new SizedBox(height:20),
                Align(
                      alignment: Alignment.bottomLeft,
                      child: new Text(
                      "Phone",
                      textAlign: TextAlign.start,
                    ),
                    ),
                    new SizedBox(height: 5,),
                    new TextFormField(
                      controller: phoneController,
                      decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12.0)),
                        borderSide: BorderSide(color: Color.fromRGBO(231, 241, 239, 0.8), width: 1),
                      ),
                        hintText: "Phone",
                        border:OutlineInputBorder(),
                        prefixIcon: Icon(Icons.phone)
                      ),
                      validator: ValidationBuilder().phone("Incorrect Phone!").build()
                    ),
                    new SizedBox(height:20),
                Align(
                      alignment: Alignment.bottomLeft,
                      child: new Text(
                      "Address",
                      textAlign: TextAlign.start,
                    ),
                    ),
                    new SizedBox(height: 5,),
                    new TextFormField(
                      controller: addressController,
                      decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12.0)),
                        borderSide: BorderSide(color: Color.fromRGBO(231, 241, 239, 0.8), width: 1),
                      ),
                        hintText: "Address",
                        border:OutlineInputBorder(),
                        prefixIcon: Icon(Icons.house_outlined)
                      ),
                      validator: (String value) {
                          if (value.trim().isEmpty) {
                            return 'Address is missing';
                          } 
                          else
                          {
                            
                          }
                      }
                    ),
                    new SizedBox(height:20),
                Align(
                      alignment: Alignment.bottomLeft,
                      child: new Text(
                      "City",
                      textAlign: TextAlign.start,
                    ),
                    ),
                    new SizedBox(height: 5,),
                    new TextFormField(
                      controller: cityController,
                      decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12.0)),
                        borderSide: BorderSide(color: Color.fromRGBO(231, 241, 239, 0.8), width: 1),
                      ),
                        hintText: "City",
                        border:OutlineInputBorder(),
                        prefixIcon: Icon(Icons.house_outlined)
                      ),
                      validator: (String value) {
                          if (value.trim().isEmpty) {
                            return 'City is missing!';
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
                            profileModel.profileData.firstname=fnameController.text.trim();
                            profileModel.profileData.lastname=lnameController.text.trim();
                            profileModel.profileData.email=emailController.text.trim();
                            profileModel.profileData.phone1=phoneController.text.trim();
                            profileModel.profileData.address=addressController.text.trim();
                            profileModel.profileData.city=cityController.text.trim();
                            profileModel.update_profile_data().then((value){
                            if(value)
                            {
                              Fluttertoast.showToast(
                                msg: "Profile updated!",
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
                                msg: "Error: Profile could not be updated!",
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
                          "Update Profile",
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
         ],
        )
      )
    );

  }
  
}