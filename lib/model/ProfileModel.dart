// To parse this JSON data, do
//
//     final profileModel = profileModelFromJson(jsonString);

import 'dart:convert';

import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

import 'BaseAPI.dart';

ProfileModel profileModelFromJson(String str) => ProfileModel.fromJson(json.decode(str));

String profileModelToJson(ProfileModel data) => json.encode(data.toJson());

class ProfileModel {
    ProfileModel({
        this.profileData,
    });

    ProfileData profileData;

    factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
        profileData: ProfileData.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "data": profileData.toJson(),
    };

    Future<ProfileModel> get_profile_data() async
    {
      final GetStorage session = new GetStorage();
      var userid=  session.read("userid");
      var token = session.read("token");
      print("##############TOKEN & USERID");
      print(userid.toString());
      print(token.toString());
      http.Response response = await http.get(
        Uri.https(BaseAPI.BASE_URL, "api/get_profile/"+userid.toString()+"/"+token.toString()),
      );
      if(response.statusCode==200)
      {
        print("################DATA###############");
        print(response.body.toString());
        ProfileModel profileModel = ProfileModel.fromJson(jsonDecode(response.body.toString()));
        return profileModel;
      }
      return null;
    }
    Future<bool> update_profile_data() async
    {
      final GetStorage session = new GetStorage();
      var userid=  session.read("userid");
      var token = session.read("token");
      print("##############TOKEN & USERID");
      print(userid.toString());
      print(token.toString());
      var data = json.encode({
          "user_id":userid, "token":token, "firstname": profileData.firstname,
          "lastname":profileData.lastname, "phone1":profileData.phone1,
          "address":profileData.address, "city": profileData.city
      });
      http.Response response = await http.post(
        Uri.https(BaseAPI.BASE_URL, "api/update_profile"),
        headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json'
        },
        body: data
      );
      print(response.body.toString());
      if(response.statusCode==201)
      {
        print("################DATA###############");
        print(response.body.toString());
        return true;
      }
      return false;
    }
}

class ProfileData {
    ProfileData({
        this.userId,
        this.username,
        this.firstname,
        this.lastname,
        this.email,
        this.phone1,
        this.address,
        this.city,
        this.picture,
    });

    int userId;
    String username;
    String firstname;
    String lastname;
    String email;
    String phone1;
    String address;
    String city;
    String picture;

    factory ProfileData.fromJson(Map<String, dynamic> json) => ProfileData(
        userId: json["user_id"],
        username: json["username"],
        firstname: json["firstname"],
        lastname: json["lastname"],
        email: json["email"],
        phone1: json["phone1"],
        address: json["address"],
        city: json["city"],
        picture: json["picture"],
    );

    Map<String, dynamic> toJson() => {
        "user_id": userId,
        "username": username,
        "firstname": firstname,
        "lastname": lastname,
        "email": email,
        "phone1": phone1,
        "address": address,
        "city": city,
        "picture": picture,
    };
}
