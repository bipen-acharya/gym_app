class User {
  String? name;
  String? email;
  String? gender;
  String? dob;
  String? userRole;
  String? updatedAt;
  String? createdAt;
  int? id;
  String? token;

  User({
    this.name,
    this.email,
    this.gender,
    this.dob,
    this.userRole,
    this.updatedAt,
    this.createdAt,
    this.id,
    this.token,
  });

  User.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    gender = json['gender'];
    dob = json['dob'];
    userRole = json['user_role'].toString();
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['email'] = email;
    data['gender'] = gender;
    data['dob'] = dob;
    data['user_role'] = userRole;
    data['updated_at'] = updatedAt;
    data['created_at'] = createdAt;
    data['id'] = id;
    data['token'] = token;

    return data;
  }
}
