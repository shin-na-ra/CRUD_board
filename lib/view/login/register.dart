import 'package:crud_board/vm/vm_getx.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    final VMgetX controller = Get.put(VMgetX());
    return Scaffold(
      appBar: controller.myAppBar("회원가입"),
      body: Center(
        
      ),
    );
  }
}