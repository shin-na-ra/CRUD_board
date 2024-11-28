/* description : 공통함수 생성
 * date : 2024.11.28
 * author : snr
 * update : 
 *  - 2024.11.28 : 공통함수생성
 *                  appbar
 *                  elevatedbutton 
 *                  snackbar
 */

import 'package:crud_board/view/login/register.dart';
import 'package:crud_board/vm/user_handler.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../view/home.dart';

class VMgetX extends GetxController {

  late UserHandler userHandler = UserHandler();

  // Appbar 함수
  AppBar myAppBar(String title) {
    return AppBar(
        title:  Text(title),
        foregroundColor: Colors.white,
        backgroundColor: Colors.black,
      );
  }


  // ElevatedButton 함수
  SizedBox myEleBtn(Color bgColor, Color fontColor, String title, int value, TextEditingController? idController, TextEditingController? pwController) {
    return SizedBox(
        width: 200,
        height: 50,
        child: ElevatedButton(
          onPressed: () async {

              print("value : ${value}!!!!!!");
            
            
            //value == 1 일때, 로그인 버튼 클릭함.
            if (value == 1) {

              String id = idController!.text.trim();
              String pw = pwController!.text.trim();

              if(id.isEmpty || pw.isEmpty) {
                buttonSnack("경고", "아이디와 비밀번호를 입력하세요 .", 2);
                return;
              } 

              if(!validateId(id!)) {
                buttonSnack("알림", "아이디는 소문자, 숫자 6자 이상입니다.", 2);
                return;
              }

              if(!validatePW(pw!)) {
                buttonSnack("알림", "비밀번호는 소문자, 숫자, 특수기호 8-12자입니다.", 2);
                return;
              }

              int result = await userHandler.selectUser(id, pw);
                  
              if (result == 1) {
                buttonSnack("알림", "로그인되었습니다.", 1);
                Get.to(const Home());

              } else if (result == 2) {
                buttonSnack("경고", "회원정보가 없습니다.", 2);
              } else if (result == 3) {
                buttonSnack("경고", "아이디 혹은 비밀번호를 확인해주세요.", 2);
              }

            // value == 2일 때, 회원가입 페이지로 넘어감  
            } else if(value == 2) {
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

  // SnackBar 함수
  buttonSnack(String title, String message, int num) {
    Get.snackbar(
      title, message,
      duration: const Duration(seconds: 2),
      backgroundColor: num == 1 ? Colors.green : Colors.red,
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM
    );
  }

  // id 정규식 체크
  bool validateId(String id) {
    final idRegex = RegExp(r'^[a-z0-9]{6,}$');
    print("id : ${id}");
    print("idRegex.hasMatch(id): ${idRegex.hasMatch(id)}");
    return idRegex.hasMatch(id);
  }

  // pw 정규식 체크
  bool validatePW(String pw) {
    final pwRegex = RegExp(r'^(?=.*[a-z])(?=.*\d)(?=.*[!@#\$&*~]).{8,12}$');
    return pwRegex.hasMatch(pw);
  }
}