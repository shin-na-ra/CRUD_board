class User {
    String id;
    String name;
    String telno;
    String password;
    int status;

    User({
        required this.id,
        required this.name,
        required this.telno,
        required this.password,
        required this.status
    });

    User.fromMap(Map<String, dynamic> res) 
        : id = res['id'],
        name = res['name'],
        telno = res['telno'],
        password = res['password'],
        status = res['status'];
}