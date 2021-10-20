import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fyp/model/Authentication/AuthModel.dart';
import 'package:fyp/model/ProfileModel.dart';
import 'package:fyp/utils/ColorsPalete.dart';
import 'package:fyp/utils/ProjectUtils.dart';
import 'package:fyp/view/Authentication/Login.dart';
import 'package:fyp/view/Profile/ChangePassword.dart';
import 'package:fyp/view/Profile/EditProfile.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';

class AccountInfo extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return AccountInfoState();
  }
  
}
class AccountInfoState extends State<AccountInfo>{
  final GetStorage session = new GetStorage();
  ProfileModel profileModel = new ProfileModel();
  bool isLoaded=false;
  File imgFile;
  bool isNetwork=true;
  @override
  void initState(){
    super.initState();
    profileModel.get_profile_data().then((value){
      setState(() {
        isLoaded=true;
        profileModel=value;
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoaded? new Column(
        children: <Widget>[
          new SizedBox(
            height: 90,
          ),
          new Center(
           child: Stack(
            children: <Widget>[
              CircleAvatar(
                radius: 70,
                backgroundColor: Colors.white,
                child: ClipOval(child: 
                isNetwork? Image.network(profileModel.profileData.picture, height: 150, width: 150, fit: BoxFit.cover,)
                :
                Image.file(File(profileModel.profileData.picture), height: 150, width: 150, fit: BoxFit.cover,)
                ,),
              ),
              Positioned(bottom: 1, right: 1 ,child: Container(
                height: 40, width: 40,
                child: GestureDetector(
                  onTap: (){
                    _showPicker(context);
                  },
                  child: Icon(Icons.add_a_photo, color: Colors.white,),
                ),
                decoration: BoxDecoration(
                  color: HexColor(ColorsPalete.primary_color),
                  borderRadius: BorderRadius.all(Radius.circular(20))
                ),
              )),
            ],
          ),
       ),
       SizedBox(height:20),
       new Expanded(
            child: new ListView(
        children: <Widget>[
        new ProfileActionItem(
         icon: Icons.account_box_outlined,
         text : "Edit Profile",
         hasNavigation: false,
         press: (){
           Navigator.push(context, MaterialPageRoute(builder: (context) => EditProfile(profileModel)),);
         },
       ),
        new ProfileActionItem(
         icon: Icons.lock_open_rounded,
         text : "Change Password",
         hasNavigation: false,
         press: (){
           Navigator.push(context, MaterialPageRoute(builder: (context) => ChangePassword()),);
         },
       ),
        new ProfileActionItem(
         icon: Icons.logout,
         text : "Logout",
         hasNavigation: false,
         press: (){
           AuthModel.session_out();
           Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => Login()));
         },
       )
        ],
      ),
          )
        ],
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
  _imgFromCamera() async {
    final _picker = ImagePicker();
  PickedFile image = await _picker.getImage(
    source: ImageSource.camera, imageQuality: 50
  );

  setState(() {
    profileModel.profileData.picture=image.path;
    isNetwork=false;
  });
}

_imgFromGallery() async {
  final _picker = ImagePicker();
  PickedFile image = await  _picker.getImage(
      source: ImageSource.gallery, imageQuality: 50
  );

  setState(() {
    profileModel.profileData.picture=image.path;
    isNetwork=false;
  });
}
void _showPicker(context) {
  showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return SafeArea(
          child: Container(
            color: Colors.white,
            child: new Wrap(
              children: <Widget>[
                new ListTile(
                    leading: new Icon(Icons.photo_library),
                    title: new Text('Photo Library'),
                    onTap: () {
                      _imgFromGallery();
                      Navigator.of(context).pop();
                    }),
                new ListTile(
                  leading: new Icon(Icons.photo_camera),
                  title: new Text('Camera'),
                  onTap: () {
                    _imgFromCamera();
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
        );
      }
    );
}

}

class ProfileActionItem extends StatelessWidget
{
  final IconData icon;
  final String text;
  final VoidCallback press;
  final bool hasNavigation;

  const ProfileActionItem({Key key, this.icon, this.text, this.press, this.hasNavigation}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ProjectUtils projectUtils = new ProjectUtils();
    projectUtils.mediaSize(context);
    return new GestureDetector(
      onTap: (){
        this.press();
      },
      child: new Container(
      height: projectUtils.screenHeight * 0.07,
      padding: EdgeInsets.symmetric(
        horizontal : 20
      ),
      margin: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 5
      ),
      decoration: new BoxDecoration(
        color: Color.fromRGBO(245, 245, 245, 1),
        borderRadius: BorderRadius.circular(10)
      ),
      child: new Row(
        children: <Widget>[
          new Icon(
            this.icon,
            color: Color.fromRGBO(64, 63, 61, 1),
          ),
          new SizedBox(
            height: 60,
            width: 10,
          ),
          new Text(
            this.text,
            style: new TextStyle(
              color: Color.fromRGBO(64, 63, 61, 1)
            ),
          ),
          Spacer(),
          if(this.hasNavigation)
            new Icon(
              Icons.email
            )
        ]
      )
    )
    );
  }
  
}