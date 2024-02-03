import 'package:esh7enly/core/widgets/bottomnavigationbar.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controlls/Homviewmodel.dart';

// ignore: use_key_in_widget_constructors
class Controllhomeview extends GetWidget<HomeViewModel> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeViewModel>(
        builder: (controller) => Scaffold(
              body: controller.currentscreen,
              bottomNavigationBar: bottomnavigationbar(),
            ));
  }
}
