import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crud_board/model/board.dart';
import 'package:crud_board/vm/vm_getx.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'addPage.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {

    final VMgetX controller = Get.put(VMgetX());
    

    return Scaffold(
      appBar: controller.myAppBar("게시판"),
      body: Center(
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
            .collection('board')
            .where('status', isEqualTo: 0)
            // .orderBy('id', descending: false)
            .snapshots(),

          builder: (context, snapshot) {
            if(!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }
            final documents = snapshot.data!.docs;
            
            return Column(
              children: [
                const Padding(
                  padding: EdgeInsets.fromLTRB(20, 8, 25, 8),
                  child: Row(
                    children: [
                      Text('제목'),
                      Spacer(),
                      Text('작성일'),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView(
                    children: documents.map((e) => _buildItemWidget(e)).toList(),
                  ),
                )
              ],
            );
            
          },
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          IconButton(
            onPressed: () => Get.to(const AddPage()),
            style: IconButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.primary,
              foregroundColor: Theme.of(context).colorScheme.onPrimary
            ),
            iconSize: 40,
            icon: const Icon(
              Icons.add,
            ),
          )
        ],
      ),
    );
  }
}

Widget _buildItemWidget(doc) {
  final board = Board(
    title: doc['title'],
    content: doc['content'],
    date: doc['date'],
    status: doc['status'],
    userid: doc['userid']
  );

  return Dismissible(
    direction: DismissDirection.endToStart,
    background: Container(
      color: Colors.red,
      alignment: Alignment.centerRight,
      child: const Icon(Icons.delete_forever),
    ),
    key: ValueKey(doc),
    onDismissed: (direction) {
      FirebaseFirestore.instance
      .collection('board')
      .doc(doc.id)
      .update({'status' : 1});
    },
    
    child: Column(
      children: [
        Card(
          child: ListTile(
            // title: Text("${board.title} \n\n 작성일 : ${board.date}"),
            title: Text(board.title),
            trailing: Text(
              DateFormat('yyyy-MM-dd').format(board.date.toDate())
            ),
          ),
        ),
      ],
    )
  );
}