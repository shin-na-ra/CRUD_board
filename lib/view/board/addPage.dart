import 'package:crud_board/view/board/boardFormWidget.dart';
import 'package:crud_board/vm/vm_getx.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddPage extends StatefulWidget {
  const AddPage({super.key});

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  @override
  Widget build(BuildContext context) {
    final VMgetX controller = Get.put(VMgetX());
    return Scaffold(
      appBar: controller.myAppBar("게시판 글쓰기"),
      body: Boardformwidget(
        id: "",
        title: "",
        content: "",
        userid: "",
        btnName: "글쓰기",
      ),
    );
  }
}