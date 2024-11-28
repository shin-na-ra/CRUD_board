class User {
    int? idValue;
    String name;
    String id;
    String password;
    int status;

    User({
        this.idValue,
        required this.name,
        required this.id,
        required this.password,
        required this.status
    });

    User.fromMap(Map<String, dynamic> res) 
        : idValue = res['idValue'],
        name = res['name'],
        id = res['id'],
        password = res['password'],
        status = res['status'];
}