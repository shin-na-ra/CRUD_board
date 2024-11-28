class Board {
    int? idValue;
    String title;
    String content;
    String date;
    int status;

    Board({
        this.idValue,
        required this.title,
        required this.content,
        required this.date,
        required this.status
    });

    Board.fromMap(Map<String, dynamic> res) 
        : idValue = res['idValue'],
        title = res['title'],
        content = res['content'],
        date = res['date'],
        status = res['status'];
}