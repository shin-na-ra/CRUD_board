import 'package:crud_board/vm/vm_getx.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ResultPage extends StatelessWidget {

  // final List<dynamic> value = Get.arguments ?? ["제목없음", "값없음", "아이디", "값없음"];
  // print("");
  // var value = Get.arguments ?? ["1", "2" ,"3" ,"4"] as List;

  final String title;
  final String username;
  final String label;
  final String result;

  ResultPage({super.key, required this.title, required this.username, required this.label, required this.result});
  
  @override
  Widget build(BuildContext context) {

    final VMgetX controller = Get.put(VMgetX());
    return Scaffold(
      appBar: controller.myAppBar(title),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('${username}님의 ${label}는 ${result}입니다.')
          ],
        ),
      ),
    );
  }
}