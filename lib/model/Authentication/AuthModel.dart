// To parse this JSON data, do
//
//     final authModel = authModelFromJson(jsonString);

import 'dart:convert';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

import '../BaseAPI.dart';


AuthModel authModelFromJson(String str) => AuthModel.fromJson(json.decode(str));

String authModelToJson(AuthModel data) => json.encode(data.toJson());

class AuthModel {
    AuthModel({
        this.authData,
    });

    AuthData authData;

    factory AuthModel.fromJson(Map<String, dynamic> json) => AuthModel(
        authData: AuthData.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "data": authData.toJson(),
    };
    Future<bool> set_login(String username, String password) async {
        if(username!="" && password!="")
        {
            var data = json.encode({
                "email":username,
                "password":password
            });
            http.Response response = await http.post(
                Uri.https(BaseAPI.BASE_URL, "api/login"),
                headers: {
                'Content-type': 'application/json',
                'Accept': 'application/json'
                },
                body: data
            );
            if(response.statusCode==200)
            {
                AuthModel authModel = AuthModel.fromJson(jsonDecode(response.body.toString()));
                print("################## LOGIN SESSION ################");
                print(response.body.toString());
                final auth = GetStorage();
                auth.write('userid',authModel.authData.userId);
                auth.write('token',authModel.authData.token);
                auth.write('loggedIn','true');
                return true;
            }
            return false;
        }
    }
    static Future<bool> update_password(String password) async {
        if(password!="")
        {
          final GetStorage session = new GetStorage();
          var userid=  session.read("userid");
          var token = session.read("token");
            var data = json.encode({
                "user_id": userid,
                "token": token,
                "password":password
            });
            http.Response response = await http.post(
                Uri.https(BaseAPI.BASE_URL, "api/update_password"),
                headers: {
                'Content-type': 'application/json',
                'Accept': 'application/json'
                },
                body: data
            );
            if(response.statusCode==201)
            {
                return true;
            }
            return false;
        }
    }
    static Future<bool> check_token_validity() async
    {
      final GetStorage session = new GetStorage();
      var userid=  session.read("userid");
      var token = session.read("token");
      print("##############TOKEN & USERID");
      print(userid.toString());
      print(token.toString());
      http.Response response = await http.get(
        Uri.https(BaseAPI.BASE_URL, "api/is_valid_token/"+userid.toString()+"/"+token.toString()),
      );
      if(response.statusCode==200)
      {
        return true;
      }
      return false;
    }
    static void session_out()
    {
      final auth = GetStorage();
      auth.remove('userid');
      auth.remove('token');
      auth.remove('loggedIn');
    }

}

class AuthData {
    AuthData({
        this.userId,
        this.token,
    });

    int userId;
    String token;

    factory AuthData.fromJson(Map<String, dynamic> json) => AuthData(
        userId: json["user_id"],
        token: json["token"],
    );

    Map<String, dynamic> toJson() => {
        "user_id": userId,
        "token": token,
    };
}
