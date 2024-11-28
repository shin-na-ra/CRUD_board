import 'package:crud_board/vm/vm_getx.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {

    final VMgetX controller = Get.put(VMgetX());

    return Scaffold(
      appBar: controller.myAppBar("게시판"),
      body: const Center(
        child: Column(
          children: [
            
          ],
        ),
      ),
    );
  }
}