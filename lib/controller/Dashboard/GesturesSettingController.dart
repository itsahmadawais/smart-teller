import 'package:flutter/material.dart';
import 'package:fyp/model/ScreenSettingsModel.dart';

class Gestures{
  /**
   * @value will binary 0 or 1.
   */
  int gestureID;
  /**
   * Gesture Image1,2
   * 0 for normal
   * 1 for grey
   */
  int img1;
  int img2;
  /**
   * Gesture Setter
   */
  Gestures(this.gestureID);
  void ImageSetter(){
    if(this.gestureID==0)
    {
      this.img1=0;
      this.img2=1;
    }
    else
    {
      this.img1=1;
      this.img2=0;
    }
  }

}
class GesturesSettingController{
  Gestures gestureSelfie;
  Gestures gesturesLogout;
  ScreenSettingsModel screenSettingsModel = new ScreenSettingsModel();
  void GestureSetter(){
    this.gestureSelfie = new Gestures(screenSettingsModel.screenData.selfieGesture);
    this.gestureSelfie.ImageSetter();
    this.gesturesLogout = new Gestures(screenSettingsModel.screenData.logoutGesture);
    this.gesturesLogout.ImageSetter();
  }
  void updateSettings()
  {
    screenSettingsModel.screenData.selfieGesture= this.currentGestureID(0);
    screenSettingsModel.screenData.logoutGesture= this.currentGestureID(1);
  }
  /**
   * @param type [0 for selfie, 1 for logout]
   */
  int currentGestureID(int type)
  {
    if(type==1)
    {
      if(this.gestureSelfie.img1==0)
      {
        return 0;
      }
      else{
        return 1;
      }
    }
    else{
      if(this.gesturesLogout.img1==0)
      {
        return 0;
      }
      else{
        return 1;
      }
    }
  }
}