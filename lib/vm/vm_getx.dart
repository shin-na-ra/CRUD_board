/* description : 공통함수 생성
 * date : 2024.11.28
 * author : snr
 * update : 
 *  - 2024.11.28 : 공통함수생성
 *                  appbar
 *                  elevatedbutton 
 *                  snackbar
 */

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crud_board/view/login/register.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../view/home.dart';

class VMgetX extends GetxController {

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

            //value == 1 일때, 로그인 버튼 클릭함.
            if (value == 1) {

              String id = idController!.text.trim();
              String pw = pwController!.text.trim();

              if(id.isEmpty || pw.isEmpty) {
                buttonSnack("경고", "아이디와 비밀번호를 입력하세요 .", 2);
                return;
              } 

              if(!validateId(id)) {
                buttonSnack("알림", "아이디는 소문자, 숫자 6-8자 이상입니다.", 2);
                return;
              }

              if(!validatePW(pw)) {
                buttonSnack("알림", "비밀번호는 소문자, 숫자, 특수기호 8-12자입니다.", 2);
                return;
              }

              try {
                // 사용자 조회
                final userSnapshot = await FirebaseFirestore.instance
                    .collection('user')
                    .where('id', isEqualTo: id)
                    .where('password', isEqualTo: pw)
                    .get();


                // 아이디와 비번으로 검색된게 빈칸일 때, 
                if (userSnapshot.docs.isEmpty) {
                  // ID 존재여부
                  final idCheckSnapshot = await FirebaseFirestore.instance
                    .collection('user')
                    .where("id", isEqualTo: id)
                    .get();

                    if(idCheckSnapshot.docs.isEmpty) {
                      buttonSnack("경고", "회원정보가 없습니다.", 2);
                    } else {
                      buttonSnack("경고", "아이디 혹은 비밀번호를 확인해주세요.", 2);
                    }
                  return;
                }

                // 입력한 id와 pw의 정보가 있을 때, 게시판 페이지로 전환    
                buttonSnack("알림", "로그인되었습니다.", 1);
                Get.to(const Home());

              } catch(e) {
                buttonSnack("에러", "로그인 중 문제가 발생했습니다: $e", 2);
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
    final idRegex = RegExp(r'^[a-z0-9]{6,8}$');
    return idRegex.hasMatch(id);
  }

  // pw 정규식 체크
  bool validatePW(String pw) {
    final pwRegex = RegExp(r'^(?=.*[a-z])(?=.*\d)(?=.*[!@#%^()\$&*~]).{8,12}$');
    return pwRegex.hasMatch(pw);
  }

  firebaseInLogin(String id, String pw) {
    
  }
}