import 'package:crud_board/vm/vm_getx.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'boardFormWidget.dart';

class EditPage extends StatelessWidget {

  final String id;
  final String title;
  final String content;
  final String userid;
  final String btnName;

  EditPage({super.key, required this.id, required this.title, required this.content, required this.userid, required this.btnName});


  @override
  Widget build(BuildContext context) {
    final VMgetX controller = Get.put(VMgetX());
    return Scaffold(
      appBar: controller.myAppBar("게시판 수정하기"),
      body: Boardformwidget(
        id : id,
        title : title,
        content : content,
        userid : userid,
        btnName : "수정하기"
      ),
    );
  }
}