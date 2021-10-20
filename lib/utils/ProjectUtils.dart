import 'package:flutter/cupertino.dart';

class ProjectUtils{
  var screenHeight;
  var screenWidth;
  void mediaSize(BuildContext context)
  {
    var size =  MediaQuery.of(context).size;
    this.screenHeight = size.height;
    this.screenWidth = size.width;
  }
}
const GRAY_FILTER = [
  0.0, 1.0, 0.0, 0.0, 0.0,
  0.0, 1.0, 0.0, 0.0, 0.0,
  0.0, 1.0, 0.0, 0.0, 0.0,
  0.0, 1.0, 0.0, 0.0, 0.0
];

const NO_FILTER =[
  1.0, 0.0, 0.0, 0.0, 0.0,
  0.0, 1.0, 0.0, 0.0, 0.0,
  0.0, 0.0, 1.0, 0.0, 0.0,
  0.0, 0.0, 0.0, 1.0, 0.0
];