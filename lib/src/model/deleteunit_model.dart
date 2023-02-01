import 'dart:convert';

DeleteUnit deleteunitFromJson(String str) =>
    DeleteUnit.fromJson(json.decode(str));

String deleteunitToJson(DeleteUnit data) => json.encode(data.toJson());

class DeleteUnit {
  String? message;

  DeleteUnit({this.message});

  DeleteUnit.fromJson(Map<String, dynamic> json) {
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    return data;
  }
}
