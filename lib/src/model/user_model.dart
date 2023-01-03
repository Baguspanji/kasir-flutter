class UserModel {
  int? id;
  String? appId;
  String? username;
  String? name;
  String? email;
  String? emailVerifiedAt;
  String? role;
  String? status;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  App? app;

  UserModel(
      {this.id,
      this.appId,
      this.username,
      this.name,
      this.email,
      this.emailVerifiedAt,
      this.role,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.deletedAt,
      this.app});

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    appId = json['app_id'];
    username = json['username'];
    name = json['name'];
    email = json['email'];
    emailVerifiedAt = json['email_verified_at'];
    role = json['role'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    app = json['app'] != null ? new App.fromJson(json['app']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['app_id'] = this.appId;
    data['username'] = this.username;
    data['name'] = this.name;
    data['email'] = this.email;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['role'] = this.role;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    if (this.app != null) {
      data['app'] = this.app!.toJson();
    }
    return data;
  }
}

class App {
  int? id;
  String? name;
  String? address;
  String? phone;
  String? prName;
  String? status;
  List<String>? messages;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;

  App(
      {this.id,
      this.name,
      this.address,
      this.phone,
      this.prName,
      this.status,
      this.messages,
      this.createdAt,
      this.updatedAt,
      this.deletedAt});

  App.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    address = json['address'];
    phone = json['phone'];
    prName = json['pr_name'];
    status = json['status'];
    messages = json['messages'].cast<String>();
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['address'] = this.address;
    data['phone'] = this.phone;
    data['pr_name'] = this.prName;
    data['status'] = this.status;
    data['messages'] = this.messages;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    return data;
  }
}
