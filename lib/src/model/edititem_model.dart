class EditItem {
  String? message;
  Data? data;

  EditItem({this.message, this.data});

  EditItem.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? id;
  String? appId;
  String? code1;
  String? code2;
  String? code3;
  String? code4;
  String? code5;
  String? code6;
  String? code7;
  String? code8;
  String? code9;
  String? code10;
  String? name;
  String? description;
  String? unit;
  Null? stock;
  String? takePrice;
  String? price;
  Null? image;
  String? status;
  String? createdAt;
  String? updatedAt;
  Null? deletedAt;

  Data(
      {this.id,
      this.appId,
      this.code1,
      this.code2,
      this.code3,
      this.code4,
      this.code5,
      this.code6,
      this.code7,
      this.code8,
      this.code9,
      this.code10,
      this.name,
      this.description,
      this.unit,
      this.stock,
      this.takePrice,
      this.price,
      this.image,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.deletedAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    appId = json['app_id'];
    code1 = json['code_1'];
    code2 = json['code_2'];
    code3 = json['code_3'];
    code4 = json['code_4'];
    code5 = json['code_5'];
    code6 = json['code_6'];
    code7 = json['code_7'];
    code8 = json['code_8'];
    code9 = json['code_9'];
    code10 = json['code_10'];
    name = json['name'];
    description = json['description'];
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
    data['code_1'] = this.code1;
    data['code_2'] = this.code2;
    data['code_3'] = this.code3;
    data['code_4'] = this.code4;
    data['code_5'] = this.code5;
    data['code_6'] = this.code6;
    data['code_7'] = this.code7;
    data['code_8'] = this.code8;
    data['code_9'] = this.code9;
    data['code_10'] = this.code10;
    data['name'] = this.name;
    data['description'] = this.description;
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
