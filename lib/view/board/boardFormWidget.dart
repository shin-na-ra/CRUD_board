import 'package:crud_board/vm/vm_getx.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';

class Boardformwidget extends StatefulWidget {

  var value = Get.arguments ?? "__";

  Boardformwidget({super.key});

  @override
  State<Boardformwidget> createState() => _BoardformwidgetState();
}

class _BoardformwidgetState extends State<Boardformwidget> {

  late TextEditingController titleController;
  late TextEditingController contentController;

  final box = GetStorage();
  late String userid;

    @override
  void initState() {
    super.initState();
    titleController = TextEditingController();
    contentController = TextEditingController();
    userid = box.read('userid');
    print("userid : ${userid}");
  }
  
  @override
  void dispose() {
    titleController.dispose();
    contentController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {

    final VMgetX controller = Get.put(VMgetX());
    
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('제목 : '),
                SizedBox(
                  width: 300,
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                      child: TextField(
                        controller: titleController,
                        onChanged: (value) => setState(() {}),
                        decoration: const InputDecoration(
                        ),
                        keyboardType: TextInputType.name,
                      ),
                  ),
                ),
              ],
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Padding(
                  padding: EdgeInsets.fromLTRB(15, 20, 8, 8),
                  child: Text('작성자 : '),
                ),
                SizedBox(
                  width: 300,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 20, 8, 8),
                      child: Text(userid),
                  ),
                ),
              ],
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Padding(
                  padding: EdgeInsets.fromLTRB(15, 25, 8, 8),
                  child: Text('작성일 : '),
                ),
                SizedBox(
                  width: 300,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 20, 8, 8),
                      child: Text(DateFormat('yyyy-MM-dd').format(DateTime.now())),
                  ),
                ),
              ],
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('내용 : '),
                SizedBox(
                  width: 300,
                  height: 400,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(8,8,8,40),
                      child: TextField(
                        controller: contentController,
                        onChanged: (value) => setState(() {}),
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black,
                              width: 2
                            )
                          )
                        ),
                        keyboardType: TextInputType.multiline,
                        maxLines: 15,
                      ),
                  ),
                ),
              ],
            ),

            controller.myEleBtn(Theme.of(context).colorScheme.tertiary, Colors.white, "글쓰기", 7, titleController, contentController, null, null),

          ],
        ),
      ),
    );
  }
}