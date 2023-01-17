import 'package:kasir_app/src/model/transaksi_model.dart';

class CreateTransaksiModel {
  String? appId;
  String? name;
  int? totalTakePrice;
  int? totalPrice;
  int? amountPaid;
  String? date;
  String? createdBy;
  String? updatedAt;
  String? createdAt;
  int? id;
  List<DetailTransaksiModel>? details;

  CreateTransaksiModel(
      {this.appId,
      this.name,
      this.totalTakePrice,
      this.totalPrice,
      this.amountPaid,
      this.date,
      this.createdBy,
      this.updatedAt,
      this.createdAt,
      this.id,
      this.details});

  CreateTransaksiModel.fromJson(Map<String, dynamic> json) {
    appId = json['app_id'];
    name = json['name'];
    totalTakePrice = json['total_take_price'];
    totalPrice = json['total_price'];
    amountPaid = json['amount_paid'];
    date = json['date'];
    createdBy = json['created_by'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
    if (json['details'] != null) {
      details = <DetailTransaksiModel>[];
      json['details'].forEach((v) {
        details!.add(new DetailTransaksiModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['app_id'] = this.appId;
    data['name'] = this.name;
    data['total_take_price'] = this.totalTakePrice;
    data['total_price'] = this.totalPrice;
    data['amount_paid'] = this.amountPaid;
    data['date'] = this.date;
    data['created_by'] = this.createdBy;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['id'] = this.id;
    if (this.details != null) {
      data['details'] = this.details!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
