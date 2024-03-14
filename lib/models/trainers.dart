List<Trainers> trainerFromJson(List<dynamic> trainersJson) =>
    List<Trainers>.from(
        trainersJson.map((trainerJson) => Trainers.fromJson(trainerJson)));

class Trainers {
  int? id;
  String? name;
  String? email;
  String? emailVerifiedAt;
  String? gender;
  String? dob;
  int? userRole;
  String? image;
  String? createdAt;
  String? updatedAt;

  Trainers({
    this.id,
    this.name,
    this.email,
    this.emailVerifiedAt,
    this.gender,
    this.dob,
    this.image,
    this.userRole,
    this.createdAt,
    this.updatedAt,
  });

  Trainers.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    emailVerifiedAt = json['email_verified_at'];
    image = json['image'];
    gender = json['gender'];
    dob = json['dob'];
    userRole = json['user_role'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['image'] = image;
    data['email_verified_at'] = emailVerifiedAt;
    data['gender'] = gender;
    data['dob'] = dob;
    data['user_role'] = userRole;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;

    return data;
  }
}
