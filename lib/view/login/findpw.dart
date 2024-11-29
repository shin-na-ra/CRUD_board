import 'package:crud_board/vm/vm_getx.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class FindPwPage extends StatefulWidget {
  const FindPwPage({super.key});

  @override
  State<FindPwPage> createState() => _FindPwPageState();
}

class _FindPwPageState extends State<FindPwPage> {

  late TextEditingController nameController;
  late TextEditingController telnoController;
  late TextEditingController idController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    telnoController = TextEditingController();
    idController = TextEditingController();
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
      appBar: controller.myAppBar("비밀번호 찾기"),
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
                    labelText: '아이디를 입력하세요',
                  ),
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(8),
                  ],
                  keyboardType: TextInputType.text,
                ),
            ),

            // name TextField
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
                child: TextField(
                  controller: nameController,
                  onChanged: (value) => setState(() {}),
                  decoration: const InputDecoration(
                    labelText: '이름을 입력하세요',
                  ),
                  keyboardType: TextInputType.text,
                ),
            ),


            // pw 입력 TextField 
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

            controller.myEleBtn(Theme.of(context).colorScheme.tertiary, Colors.white, "비밀번호 찾기", 5, nameController, telnoController, idController, null),
            const SizedBox(height: 20,),
            controller.myEleBtn(Theme.of(context).colorScheme.secondary, Colors.white, "로그인하기", 4, null, null, null, null),
          ]
        ),
      ),
    );
  }
}