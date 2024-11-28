
import 'package:crud_board/view/login/register.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VMgetX extends GetxController {

  AppBar myAppBar(String title) {
    return AppBar(
        title:  Text(title),
        foregroundColor: Colors.white,
        backgroundColor: Colors.black,
      );
  }

  SizedBox myEleBtn(Color bgColor, Color fontColor, String title, int value) {
    return SizedBox(
        width: 200,
        height: 50,
        child: ElevatedButton(
          onPressed: (){
            if (value == 1 ){
              print("로그인 클릭");
            } else {
              print("회원가입 클릭");
              Get.to(const RegisterPage());
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: bgColor
          ),
          child: Text(
            title,
            style: TextStyle(
              color: fontColor,
              fontSize: 18
            ),
          ),
        ),
      );
  }

}