import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';


class Indicator {
  static void showLoading() {
    Get.dialog(Center(
      child: CircularProgressIndicator(),
    ));
  }

  static void closeLoading() {
    if (Get.isDialogOpen!) {
      Get.back();
    }
  }
}