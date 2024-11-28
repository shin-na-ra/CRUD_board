import 'package:crud_board/vm/vm_getx.dart';
import 'package:flutter/material.dart';
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
            Padding(
              padding: const EdgeInsets.all(20.0),
                child: TextField(
                  controller: idController,
                  decoration: const InputDecoration(
                    labelText: '아이디를 입력하세요',
                  ),
                  keyboardType: TextInputType.text,
                ),
              // ),
            ),

            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 40),
                child: TextField(
                  controller: pwController,
                  decoration: const InputDecoration(
                    labelText: '비밀번호를 입력하세요',
                  ),
                  keyboardType: TextInputType.text,
                ),
            ),

            // SizedBox(
            //   width: 200,
            //   height: 50,
            //   child: ElevatedButton(
            //     onPressed: () => {},
            //     style: ElevatedButton.styleFrom(
            //       backgroundColor: Theme.of(context).colorScheme.secondary
            //     ),
            //     child: Text(
            //       "로그인",
            //       style: TextStyle(
            //         color: Colors.white,
            //         fontSize: 18
            //       ),
            //     ),
            //   ),
            // ),

            controller.myEleBtn(Theme.of(context).colorScheme.tertiary, Colors.white, "로그인", 1, idController, pwController),
            const SizedBox(height: 20,),
            controller.myEleBtn(Theme.of(context).colorScheme.secondary, Colors.white, "회원가입", 2, null, null),

          ],
        ),
      ),
    );
  }
}
