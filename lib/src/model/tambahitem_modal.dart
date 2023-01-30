class TambahItem {
  String? message;
  ResTambah? data;

  TambahItem({this.message, this.data});

  TambahItem.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = json['data'] != null ? new ResTambah.fromJson(json['data']) : null;
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

class ResTambah {
  String? code1;
  String? name;
  String? unit;
  String? takePrice;
  String? price;
  String? appId;
  String? updatedAt;
  String? createdAt;
  int? id;

  ResTambah(
      {this.code1,
      this.name,
      this.unit,
      this.takePrice,
      this.price,
      this.appId,
      this.updatedAt,
      this.createdAt,
      this.id});

  ResTambah.fromJson(Map<String, dynamic> json) {
    code1 = json['code_1'];
    name = json['name'];
    unit = json['unit'];
    takePrice = json['take_price'];
    price = json['price'];
    appId = json['app_id'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code_1'] = this.code1;
    data['name'] = this.name;
    data['unit'] = this.unit;
    data['take_price'] = this.takePrice;
    data['price'] = this.price;
    data['app_id'] = this.appId;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['id'] = this.id;
    return data;
  }
}
