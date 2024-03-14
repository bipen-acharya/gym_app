List<ProductHistory> productHistoryFromJson(List<dynamic> productHistoryJson) =>
    List<ProductHistory>.from(productHistoryJson.map((productHistoriesJson) =>
        ProductHistory.fromJson(productHistoriesJson)));

class ProductHistory {
  int? id;
  int? userId;
  String? paymentMethod;
  int? total;
  String? date;
  String? createdAt;
  String? updatedAt;

  ProductHistory(
      {this.id,
      this.userId,
      this.paymentMethod,
      this.total,
      this.date,
      this.createdAt,
      this.updatedAt});

  ProductHistory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    paymentMethod = json['payment_method'];
    total = json['total'];
    date = json['date'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['payment_method'] = paymentMethod;
    data['total'] = total;
    data['date'] = date;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
