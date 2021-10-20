// To parse this JSON data, do
//
//     final screenSettingsModel = screenSettingsModelFromJson(jsonString);

import 'dart:convert';

import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'BaseAPI.dart';


ScreenSettingsModel screenSettingsModelFromJson(String str) => ScreenSettingsModel.fromJson(json.decode(str));

String screenSettingsModelToJson(ScreenSettingsModel data) => json.encode(data.toJson());

class ScreenSettingsModel {
    ScreenSettingsModel({
        this.screenData,
    });

    ScreenData screenData;

    factory ScreenSettingsModel.fromJson(Map<String, dynamic> json) => ScreenSettingsModel(
        screenData: ScreenData.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "data": screenData.toJson(),
    };
    
    Future<ScreenSettingsModel> get_settings() async
    {
      final GetStorage session = new GetStorage();
      var userid=  session.read("userid");
      var token = session.read("token");
      print("##############TOKEN & USERID");
      print(userid.toString());
      print(token.toString());
      http.Response response = await http.get(
        Uri.https(BaseAPI.BASE_URL, "api/settings/"+userid.toString()+"/"+token.toString()),
      );
      if(response.statusCode==200)
      {
        print("##############SCREEN SETTINGS MODEL############");
        ScreenSettingsModel screenSettingsModel = ScreenSettingsModel.fromJson(jsonDecode(response.body.toString()));
        return screenSettingsModel;
      }
      return null;
    }
    Future<bool> update_settings() async{
      final GetStorage session = new GetStorage();
      var userid=  session.read("userid");
      var token = session.read("token");
      print("##############TOKEN & USERID");
      print(userid.toString());
      print(token.toString());
      var data = json.encode({
          "user_id":userid, "token":token, "settings": screenData
      });
      http.Response response = await http.post(
        Uri.https(BaseAPI.BASE_URL, "api/update_settings"),
        headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json'
        },
        body: data
      );
      print("############# RESPONSE########");
      print(response.body.toString());
      if(response.statusCode==200)
        return true;
      else
        return false;
      return false;
    }
}

class ScreenData {
    ScreenData({
        this.screenChoice,
        this.selfieGesture,
        this.logoutGesture,
    });

    List<ScreenChoice> screenChoice;
    int selfieGesture;
    int logoutGesture;

    factory ScreenData.fromJson(Map<String, dynamic> json) => ScreenData(
        screenChoice: List<ScreenChoice>.from(json["screens"].map((x) => ScreenChoice.fromJson(x))),
        selfieGesture: json["selfie_gesture"],
        logoutGesture: json["logout_gesture"],
    );

    Map<String, dynamic> toJson() => {
        "screens": List<dynamic>.from(screenChoice.map((x) => x.toJson())),
        "selfie_gesture": selfieGesture,
        "logout_gesture": logoutGesture,
    };
}

class ScreenChoice {
    ScreenChoice({
        this.screenId,
        this.option,
    });

    int screenId;
    int option;

    factory ScreenChoice.fromJson(Map<String, dynamic> json) => ScreenChoice(
        screenId: json["screen_id"],
        option: json["option"],
    );

    Map<String, dynamic> toJson() => {
        "screen_id": screenId,
        "option": option,
    };
}
