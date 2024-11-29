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
import 'package:crud_board/view/login/findid.dart';
import 'package:crud_board/view/login/findpw.dart';
import 'package:crud_board/view/login/register.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../view/board/home.dart';
import '../view/login/result.dart';

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
  SizedBox myEleBtn(Color bgColor, Color fontColor, String title, int value, TextEditingController? cont1, TextEditingController? cont2, TextEditingController? cont3, TextEditingController? cont4) {
    return SizedBox(
        width: 200,
        height: 50,
        child: ElevatedButton(
          onPressed: () async {

            //value == 1 일때, 로그인 버튼 클릭함.
            if (value == 1) {
              await checkFirebaseInLogin(cont1, cont2);

            // value == 2일 때, 회원가입 페이지로 넘어감  
            } else if(value == 2) {
              Get.to(const RegisterPage());

            // value == 3일 때, 아이디 찾기 
            } else if (value == 3) {
              await findUserId(cont1, cont2);

            //value == 4, 뒤로가기  
            } else if (value == 4) {
              Get.back();

            // value == 5일 때, 비밀번호 찾기 
            } else if (value == 5) {
              await findUserPW(cont1, cont2, cont3);

            // value == 6일 때, 회원등록
            } else if (value == 6) {
              await registerUserInfo(cont1, cont2, cont3, cont4);
            
            // value == 7, 글쓰기
            } else if (value == 7) {
              await writeBoard(cont1, cont2);
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

  //TextBtn 함수
  TextButton myTextBtn (int value, String title) {
    return TextButton(
      onPressed: () {
        value == 1 ? Get.to(const FindIdPage()): Get.to(const FindPwPage());
      },
      child: Text(
        title,
        // style: const TextStyle(
        //   decoration: TextDecoration.underline,
        // ),
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

  //이름 정규식 체크
  bool validateName(String name) {
    final nameRegex = RegExp(r'^[가-힣]{2,5}$');
    return nameRegex.hasMatch(name);
  }

  // 휴대폰 번호 정규식 체크
  bool validatePhone(String phone) {
    final phoneRegex = RegExp(r'^010[-]?\d{3,4}[-]?\d{4}$');
    return phoneRegex.hasMatch(phone);
  }

  // 로그인 함수
  checkFirebaseInLogin(TextEditingController? idController, TextEditingController? pwController) async {

    String id = idController!.text.trim();
    String pw = pwController!.text.trim();

    if(id.isEmpty ) {
      buttonSnack("경고", "아이디를 입력하세요 .", 2);
      return;
    } 

    if(pw.isEmpty) {
      buttonSnack("경고", "비밀번호를 입력하세요 .", 2);
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
          .where('status', isEqualTo: 0)
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
      
      // print('read.box : ${box.read('userid')}');
      Get.to(const Home());
      idController.clear();
      pwController.clear();

    } catch(e) {
      buttonSnack("에러", "로그인 중 문제가 발생했습니다: $e", 2);
    }
  }


  // 아이디 찾기 함수
  findUserId(TextEditingController? nameController, TextEditingController? telnoController) async {

    String name = nameController!.text.trim();
    String telno = telnoController!.text.trim();

    if(name.isEmpty) {
      buttonSnack("경고", "이름을 입력하세요 .", 2);
      return;
    } 

    if(telno.isEmpty) {
      buttonSnack("경고", "휴대폰 번호를 입력하세요 .", 2);
      return;
    } 

    if(!validateName(name)) {
      buttonSnack("경고", "한글로 이름을 입력하세요.", 2);
      return;
    }

    if(!validatePhone(telno)) {
      buttonSnack("경고", "010-0000-0000 형식으로 입력해주세요.", 2);
      return;
    }

    try {
      // 사용자 조회
      final userSnapshot = await FirebaseFirestore.instance
          .collection('user')
          .where('name', isEqualTo: name)
          .where('telno', isEqualTo: telno)
          .where('status', isEqualTo: 0)
          .get();


      // 이름과 비번으로 검색된게 없을 때, 
      if (userSnapshot.docs.isEmpty) {
        buttonSnack("경고", "회원정보가 없습니다.", 2);
        return;
      }

      final userid = userSnapshot.docs[0].data()['id'];
      final username = userSnapshot.docs[0].data()['name'];
      
      Get.back();
      Get.to(
        ResultPage(
          title: "아이디 찾기 결과",
          username : username,
          label : "아이디",
          result : userid,
        ),
      );
    } catch(e) {
      buttonSnack("에러", "아이디찾기 중 문제가 발생했습니다: $e", 2);
    }
  }


  // 비번 찾기 함수
  findUserPW(TextEditingController? nameController, TextEditingController? telnoController, TextEditingController? idController) async {

    String name = nameController!.text.trim();
    String telno = telnoController!.text.trim();
    String id = idController!.text.trim();

    if(id.isEmpty) {
      buttonSnack("경고", "아이디를 입력하세요 .", 2);
      return;
    } 

    if(name.isEmpty) {
      buttonSnack("경고", "이름을 입력하세요 .", 2);
      return;
    } 

    if(telno.isEmpty) {
      buttonSnack("경고", "휴대폰 번호를 입력하세요 .", 2);
      return;
    } 

    if(!validateId(id)) {
      buttonSnack("경고", "아이디는 소문자, 숫자 6-8자 이상입니다.", 2);
      return;
    }

    if(!validateName(name)) {
      buttonSnack("경고", "한글로 이름을 입력하세요.", 2);
      return;
    }

    if(!validatePhone(telno)) {
      buttonSnack("경고", "010-0000-0000 형식으로 입력해주세요.", 2);
      return;
    }

    try {
      // 사용자 조회
      final userSnapshot = await FirebaseFirestore.instance
          .collection('user')
          .where('name', isEqualTo: name)
          .where('telno', isEqualTo: telno)
          .where('id', isEqualTo: id)
          .where('status', isEqualTo: 0)
          .get();


      // 이름과 비번으로 검색된게 없을 때, 
      if (userSnapshot.docs.isEmpty) {
        buttonSnack("경고", "회원정보가 없습니다.", 2);
        return;
      }

      if (userSnapshot.docs.isNotEmpty) {
        print("User Data: ${userSnapshot.docs[0].data()}");
        print("User id: ${userSnapshot.docs[0].data()['id']}");
      }

      final username = userSnapshot.docs[0].data()['name'];
      final pw = userSnapshot.docs[0].data()['password'];
      
      Get.back();
      Get.to(
        ResultPage(
          title: "비밀번호 찾기 결과",
          username : username,
          label : "비밀번호",
          result : pw,
        ),
      );
    } catch(e) {
      buttonSnack("에러", "비밀번호 찾기 중 문제가 발생했습니다: $e", 2);
    }
  }


  //회원가입 함수
  registerUserInfo(TextEditingController? idController, TextEditingController? pwController, TextEditingController? nameController, TextEditingController? telnoController) async {
    
    String name = nameController!.text.trim();
    String telno = telnoController!.text.trim();
    String id = idController!.text.trim();
    String pw = pwController!.text.trim();

    if(id.isEmpty) {
      buttonSnack("경고", "아이디를 입력하세요 .", 2);
      return;
    } 

    if(pw.isEmpty) {
      buttonSnack("경고", "비밀번호를 입력하세요 .", 2);
      return;
    } 

    if(!validatePW(pw)) {
      buttonSnack("알림", "비밀번호는 소문자, 숫자, 특수기호 8-12자입니다.", 2);
      return;
    }

    if(name.isEmpty) {
      buttonSnack("경고", "이름을 입력하세요 .", 2);
      return;
    } 

    if(telno.isEmpty) {
      buttonSnack("경고", "휴대폰 번호를 입력하세요 .", 2);
      return;
    } 

    if(!validateId(id)) {
      buttonSnack("경고", "아이디는 소문자, 숫자 6-8자 이상입니다.", 2);
      return;
    }

    if(!validateName(name)) {
      buttonSnack("경고", "한글로 이름을 입력하세요.", 2);
      return;
    }

    if(!validatePhone(telno)) {
      buttonSnack("경고", "010-0000-0000 형식으로 입력해주세요.", 2);
      return;
    }

    FirebaseFirestore.instance.collection('user').add(
      {
        'id' : id,
        'name' : name,
        'password' : pw,
        'status' : 0,
        'telno' : telno
      }
    );
    Get.back();
    buttonSnack("알림", "${name}님 회원가입되었습니다.", 1);

  }


  // 글 등록하기
  writeBoard(TextEditingController? titleController, TextEditingController? contentController) {
    String title = titleController!.text.trim();
    String content = contentController!.text.trim();

    if(title.isEmpty) {
      buttonSnack("경고", "제목을 입력하세요 .", 2);
      return;
    } 

    if(content.isEmpty) {
      buttonSnack("경고", "내용을 입력하세요 .", 2);
      return;
    } 

    final box = GetStorage();
    print("userid. boxread : ${box.read('userid')}");

    FirebaseFirestore.instance.collection('board').add(
      {
        'title' : title,
        'content' : content,
        'status' : 0,
        'date' : DateTime.now(),
        'userid' : box.read('userid')
      }
    );
    Get.back();
    buttonSnack("알림", "등록이 되었습니다.", 1);
  }
}