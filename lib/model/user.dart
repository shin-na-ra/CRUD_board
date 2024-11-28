class User {
    String id;
    String name;
    String password;
    int status;

    User({
        required this.id,
        required this.name,
        required this.password,
        required this.status
    });

    User.fromMap(Map<String, dynamic> res) 
        : id = res['id'],
        name = res['name'],
        password = res['password'],
        status = res['status'];
}