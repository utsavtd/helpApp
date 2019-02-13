class User {
  String id;
  String first_name;
  String last_name;
  String email;
  String type;
  String password = '';

  User(this.id, this.first_name, this.last_name, this.email, this.password,
      this.type);

  User.fromJson(Map<String, dynamic> json)
      : id = json['_id'],
        first_name = json['first_name'],
        last_name = json['last_name'],
        email = json['email'],
        password = json['password'],
        type = json['type'];


}
