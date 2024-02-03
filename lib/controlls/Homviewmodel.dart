// ignore_for_file: prefer_const_constructors, file_names

import 'package:esh7enly/views/balance.dart';
import 'package:esh7enly/views/home.dart';
import 'package:esh7enly/views/profile.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import '../views/gits.dart';
import '../views/call.dart';

class HomeViewModel extends GetxController {
  int _navigationvalue = 2;
  Widget _currentscreen = home();

  get navigatovalue => _navigationvalue;
  get currentscreen => _currentscreen;

  void changeselectedvalue(int selectedvalue) {
    _navigationvalue = selectedvalue;
    update();
    switch (selectedvalue) {
      case 0:
        {
          _currentscreen = HomeScreen();
          break;
        }
      case 1:
        {
          _currentscreen = call();
          break;
        }
      case 2:
        {
          //PROFILE
          _currentscreen = home();
          break;
        }
      case 3:
        {
          _currentscreen = balance();
          break;
        }
      case 4:
        {
          _currentscreen = profile();
          break;
        }
    }
  }
}
