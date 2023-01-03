class ProductModel {
  int? id;
  String? appId;
  String? code;
  String? name;
  String? unit;
  String? stock;
  String? takePrice;
  String? price;
  String? image;
  String? status;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;

  ProductModel(
      {this.id,
      this.appId,
      this.code,
      this.name,
      this.unit,
      this.stock,
      this.takePrice,
      this.price,
      this.image,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.deletedAt});

  ProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    appId = json['app_id'];
    code = json['code'];
    name = json['name'];
    unit = json['unit'];
    stock = json['stock'];
    takePrice = json['take_price'];
    price = json['price'];
    image = json['image'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['app_id'] = this.appId;
    data['code'] = this.code;
    data['name'] = this.name;
    data['unit'] = this.unit;
    data['stock'] = this.stock;
    data['take_price'] = this.takePrice;
    data['price'] = this.price;
    data['image'] = this.image;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    return data;
  }
}
