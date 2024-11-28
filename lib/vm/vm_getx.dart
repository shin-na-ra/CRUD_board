
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VMgetX extends GetxController {

  AppBar myAppBar(String title) {
    return AppBar(
        title: const Text(
          "게시판",
        ),
        foregroundColor: Colors.white,
        backgroundColor: Colors.black,
      );
  }

}