List<Products> productFromJson(List<dynamic> productJson) =>
    List<Products>.from(
        productJson.map((productsJson) => Products.fromJson(productsJson)));

class Products {
  int? id;
  String? name;
  String? description;
  int? price;
  int? enabled;
  String? createdAt;
  String? updatedAt;
  String? image;

  Products({
    this.id,
    this.name,
    this.description,
    this.price,
    this.enabled,
    this.createdAt,
    this.updatedAt,
    this.image,
  });

  Products.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    price = json['price'];
    enabled = json['enabled'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['description'] = description;
    data['price'] = price;
    data['enabled'] = enabled;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['image'] = image;
    return data;
  }
}
