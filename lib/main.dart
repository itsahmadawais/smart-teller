import 'package:flutter/material.dart';
import 'package:fyp/view/SplashScreen.dart';
import 'package:get_storage/get_storage.dart';

import 'view/Authentication/Login.dart';

main() async {
  await GetStorage.init();
  runApp(Starter());
}

class Starter extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Smart Teller',
      theme: ThemeData(
       primarySwatch: Colors.teal,
       canvasColor: Colors.transparent,
       accentColor: Colors.cyan[600],
        
      // Define the default font family.
      fontFamily: 'Raleway',
      // Define the default TextTheme. Use this to specify the default
      // text styling for headlines, titles, bodies of text, and more.
      textTheme: TextTheme(
        headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
        headline6: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
        bodyText2: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
      ),
      ),
      home: SplashScreen(),
    );
  }
}

