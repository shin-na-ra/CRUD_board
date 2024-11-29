import 'package:cloud_firestore/cloud_firestore.dart';

class Board {
    int? id;
    String title;
    String content;
    Timestamp date;
    int status;

    Board({
        this.id,
        required this.title,
        required this.content,
        required this.date,
        required this.status
    });

}