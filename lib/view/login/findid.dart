import 'package:crud_board/vm/vm_getx.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FindIdPage extends StatefulWidget {
  const FindIdPage({super.key});

  @override
  State<FindIdPage> createState() => _FindIdPageState();
}

class _FindIdPageState extends State<FindIdPage> {
  
  late TextEditingController nameController;
  late TextEditingController telnoController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    telnoController = TextEditingController();
  }
  
  @override
  void dispose() {
    nameController.dispose();
    telnoController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    final VMgetX controller = Get.put(VMgetX());

    return Scaffold(
      appBar: controller.myAppBar("아이디 찾기"),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            // name TextField
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
                child: TextField(
                  controller: nameController,
                  onChanged: (value) => setState(() {}),
                  decoration: const InputDecoration(
                    labelText: '이름을 입력하세요',
                  ),
                  keyboardType: TextInputType.name,
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

            controller.myEleBtn(Theme.of(context).colorScheme.tertiary, Colors.white, "아이디 찾기", 3, nameController, telnoController, null, null),
            const SizedBox(height: 20,),
            controller.myEleBtn(Theme.of(context).colorScheme.secondary, Colors.white, "로그인하기", 4, null, null, null, null),
          ]
        ),
      ),
    );
  }
}