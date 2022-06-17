import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Model{
  // Widget getWeatherIcon(int condition){
  //   if(condition<300){
  //     return SvgPicture.asset(
  //       'svg/Cloud-Lightning.svg',
  //       color: Colors.grey[500],
  //     );
  //   }
  //   else if(condition<600){
  //     return SvgPicture.asset(
  //       'svg/Cloud-Snow.svg',
  //       color: Colors.grey[500],
  //     );
  //   }
  //   else if(condition==800){
  //     return SvgPicture.asset(
  //       'svg/Cloud-Sun.svg',
  //       color: Colors.grey[500],
  //     );
  //   }
  //   else {
  //     return SvgPicture.asset(
  //       'svg/Cloud-Rain.svg',
  //       color: Colors.grey[500],
  //     );
  //   }
  // }
  String getWeatherIcon(int condition){
    if(condition<300){
      // return SvgPicture.asset(
      //   'svg/Cloud-Lightning.svg',
      //   color: Colors.grey[500],
      // );
      return '⛈';
    }
    else if(condition<600){
      // return SvgPicture.asset(
      //   'svg/Cloud-Snow.svg',
      //   color: Colors.grey[500],
      // );
      return "🌨";
    }
    else if(condition==800){
      // return SvgPicture.asset(
      //   'svg/Cloud-Sun.svg',
      //   color: Colors.grey[500],
      // );
      return "🌧";
    }
    else {
      // return SvgPicture.asset(
      //   'svg/Cloud-Rain.svg',
      //   color: Colors.grey[500],
      // );
      return '☁️️';
    }
  }
}