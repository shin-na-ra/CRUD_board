import 'package:crud_board/vm/vm_getx.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  late TextEditingController idController;
  late TextEditingController pwController;

  @override
  void initState() {
    super.initState();
    idController = TextEditingController();
    pwController = TextEditingController();
  }
  
  @override
  void dispose() {
    idController.dispose();
    pwController.dispose();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    final VMgetX controller = Get.put(VMgetX());
    return Scaffold(
      appBar: controller.myAppBar("로그인"),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            // id TextField
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
                child: TextField(
                  controller: idController,
                  onChanged: (value) => setState(() {}),
                  decoration: const InputDecoration(
                    labelText: '아이디를 입력하세요 (8자 이하)',
                  ),
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(8),
                  ],
                  keyboardType: TextInputType.text,
                ),
            ),


            // pw 입력 TextField 
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 40),
                child: TextField(
                  obscureText: true,
                  controller: pwController,
                  onChanged: (value) => setState(() {}),
                  decoration: const InputDecoration(
                    labelText: '비밀번호를 입력하세요 (8-12자)',
                  ),
                  keyboardType: TextInputType.text,
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(12),
                  ],
                ),
            ),



            // Elevated 버튼 영역
            controller.myEleBtn(Theme.of(context).colorScheme.tertiary, Colors.white, "로그인", 1, idController, pwController, null, null),
            const SizedBox(height: 20,),
            controller.myEleBtn(Theme.of(context).colorScheme.secondary, Colors.white, "회원가입", 2, null, null, null, null),
            

            // textButton 영역
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  controller.myTextBtn(1, "아이디 찾기"),
                  const Text('|'),
                  controller.myTextBtn(0, "비밀번호 찾기"),
                ],
              ),
            ),
            

          ],
        ),
      ),
    );
  }
}
