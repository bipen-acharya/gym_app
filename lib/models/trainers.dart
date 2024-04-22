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
  String? createdAt;
  String? updatedAt;
  String? description;
  String? costPerMonth;
  String? experience;
  String? photo;

  Trainers({
    this.id,
    this.name,
    this.email,
    this.emailVerifiedAt,
    this.gender,
    this.dob,
    this.userRole,
    this.createdAt,
    this.updatedAt,
    this.description,
    this.costPerMonth,
    this.experience,
    this.photo,
  });

  Trainers.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    emailVerifiedAt = json['email_verified_at'];
    gender = json['gender'];
    dob = json['dob'];
    userRole = json['user_role'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    description = json['description'];
    costPerMonth = json['cost_per_month'];
    experience = json['experience'];

    photo = json['photo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['email_verified_at'] = emailVerifiedAt;
    data['gender'] = gender;
    data['dob'] = dob;
    data['user_role'] = userRole;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['description'] = description;
    data['cost_per_month'] = costPerMonth;
    data['experience'] = experience;

    data['photo'] = photo;

    return data;
  }
}
