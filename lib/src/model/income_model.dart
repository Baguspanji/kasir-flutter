import 'package:kasir_app/src/model/product_model.dart';

class IncomeModel {
  int? id;
  String? appId;
  String? transactionId;
  String? itemId;
  String? takePrice;
  String? price;
  String? quantity;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  ProductModel? item;
  Transaction? transaction;

  IncomeModel(
      {this.id,
      this.appId,
      this.transactionId,
      this.itemId,
      this.takePrice,
      this.price,
      this.quantity,
      this.createdAt,
      this.updatedAt,
      this.deletedAt,
      this.item,
      this.transaction});

  IncomeModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    appId = json['app_id'];
    transactionId = json['transaction_id'];
    itemId = json['item_id'];
    takePrice = json['take_price'];
    price = json['price'];
    quantity = json['quantity'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    item =
        json['item'] != null ? new ProductModel.fromJson(json['item']) : null;
    transaction = json['transaction'] != null
        ? new Transaction.fromJson(json['transaction'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['app_id'] = this.appId;
    data['transaction_id'] = this.transactionId;
    data['item_id'] = this.itemId;
    data['take_price'] = this.takePrice;
    data['price'] = this.price;
    data['quantity'] = this.quantity;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    if (this.item != null) {
      data['item'] = this.item!.toJson();
    }
    if (this.transaction != null) {
      data['transaction'] = this.transaction!.toJson();
    }
    return data;
  }
}

class Transaction {
  int? id;
  String? appId;
  String? name;
  String? totalTakePrice;
  String? totalPrice;
  String? amountPaid;
  String? date;
  String? createdBy;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;

  Transaction(
      {this.id,
      this.appId,
      this.name,
      this.totalTakePrice,
      this.totalPrice,
      this.amountPaid,
      this.date,
      this.createdBy,
      this.createdAt,
      this.updatedAt,
      this.deletedAt});

  Transaction.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    appId = json['app_id'];
    name = json['name'];
    totalTakePrice = json['total_take_price'];
    totalPrice = json['total_price'];
    amountPaid = json['amount_paid'];
    date = json['date'];
    createdBy = json['created_by'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['app_id'] = this.appId;
    data['name'] = this.name;
    data['total_take_price'] = this.totalTakePrice;
    data['total_price'] = this.totalPrice;
    data['amount_paid'] = this.amountPaid;
    data['date'] = this.date;
    data['created_by'] = this.createdBy;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    return data;
  }
}
