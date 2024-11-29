import 'package:crud_board/vm/vm_getx.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/instance_manager.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  late TextEditingController nameController;
  late TextEditingController telnoController;
  late TextEditingController idController;
  late TextEditingController pw1Controller;
  late TextEditingController pw2Controller;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    telnoController = TextEditingController();
    idController = TextEditingController();
    pw1Controller = TextEditingController();
    pw2Controller = TextEditingController();
  }
  
  @override
  void dispose() {
    nameController.dispose();
    telnoController.dispose();
    idController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final VMgetX controller = Get.put(VMgetX());
    
    return Scaffold(
      appBar: controller.myAppBar("회원가입"),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            // id TextField
            Padding(
              padding: const EdgeInsets.all(20),
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
              padding: const EdgeInsets.all(20),
                child: TextField(
                  obscureText: true,
                  controller: pw1Controller,
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


            // pw 입력 TextField 
            Padding(
              padding: const EdgeInsets.all(20),
                child: TextField(
                  obscureText: true,
                  controller: pw2Controller,
                  onChanged: (value) => setState(() {}),
                  decoration: const InputDecoration(
                    labelText: '비밀번호 확인을 입력하세요 (8-12자)',
                  ),
                  keyboardType: TextInputType.text,
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(12),
                  ],
                ),
            ),

            // pw1 == pw2 check 문구
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  pw1Controller.text == pw2Controller.text
                  ? const Text(
                    '비밀번호가 일치합니다.',
                    style: TextStyle(
                      color: Colors.green
                    ),
                  )
                  : const Text(
                    '비밀번호가 일치하지 않습니다.',
                    style: TextStyle(
                      color: Colors.red
                    ),
                  )
                ],
              ),
            ),


            // name TextField
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                child: TextField(
                  controller: nameController,
                  onChanged: (value) => setState(() {}),
                  decoration: const InputDecoration(
                    labelText: '이름을 입력하세요',
                  ),
                  keyboardType: TextInputType.text,
                ),
            ),


            // 휴대폰번호 입력 TextField 
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 40),
                child: TextField(
                  controller: telnoController,
                  onChanged: (value) => setState(() {}),
                  decoration: const InputDecoration(
                    labelText: '휴대폰 번호를 입력하세요(-필수)',
                  ),
                  keyboardType: TextInputType.text,
                ),
            ),

            controller.myEleBtn(Theme.of(context).colorScheme.tertiary, Colors.white, "회원가입", 6, idController, pw1Controller, nameController, telnoController),
          ]
        ),
      ),
    );
  }
}