import 'package:crud_board/vm/vm_getx.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    final VMgetX controller = Get.put(VMgetX());

    return Scaffold(
      appBar: controller.myAppBar("로그인"),
      body: const Center(
        child: Column(
          children: [
            
          ],
        ),
      ),
    );
  }
}
