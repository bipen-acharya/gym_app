class SuscriptionDetailUser {
  String? id;
  String? name;
  String? email;
  String? emailVerifiedAt;
  String? gender;
  String? dob;
  String? userRole;
  String? createdAt;
  String? updatedAt;
  SuscriptionDetails? suscriptionDetails;

  SuscriptionDetailUser({
    this.id,
    this.name,
    this.email,
    this.emailVerifiedAt,
    this.gender,
    this.dob,
    this.userRole,
    this.createdAt,
    this.updatedAt,
    this.suscriptionDetails,
  });

  SuscriptionDetailUser.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    name = json['name'];
    email = json['email'];
    emailVerifiedAt = json['email_verified_at'];
    gender = json['gender'];
    dob = json['dob'];
    userRole = json['user_role'].toString();
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    // Check if "suscription_details" is an empty array
    if (json['suscription_details'] is List &&
        json['suscription_details'].isEmpty) {
      suscriptionDetails = null;
    } else {
      suscriptionDetails = json['suscription_details'] != null
          ? SuscriptionDetails.fromJson(json['suscription_details'])
          : null;
    }
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
    if (suscriptionDetails != null) {
      data['suscription_details'] = suscriptionDetails!.toJson();
    }

    return data;
  }
}

class SuscriptionDetails {
  String? totalDays;
  String? totalRemainingDays;
  String? startDate;
  String? endDate;

  SuscriptionDetails(
      {this.totalDays, this.totalRemainingDays, this.startDate, this.endDate});

  SuscriptionDetails.fromJson(Map<String, dynamic> json) {
    totalDays = json['total_days'].toString();
    totalRemainingDays = json['total_remaining_days'].toString();
    startDate = json['start_date'].toString();
    endDate = json['end_date'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['total_days'] = totalDays;
    data['total_remaining_days'] = totalRemainingDays;
    data['start_date'] = startDate;
    data['end_date'] = endDate;
    return data;
  }
}
