class CartDBModel {
  int? id;
  String? name;
  int? billAmoount;

  CartDBModel({this.id, this.name, this.billAmoount});

  CartDBModel.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    name = map['name'];
    billAmoount = map['bill_amount'];
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    // data['id'] = this.id;
    data['name'] = this.name;
    data['bill_amount'] = this.billAmoount;
    return data;
  }
}

class CartDetailDBModel {
  int? id;
  int? cartId;
  int? productId;
  String? productName;
  String? productUnit;
  int? price;
  int? quantity;

  CartDetailDBModel({
    this.id,
    this.cartId,
    this.productId,
    this.productName,
    this.productUnit,
    this.price,
    this.quantity,
  });

  CartDetailDBModel.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    cartId = map['cart_id'];
    productId = map['product_id'];
    productName = map['product_name'];
    productUnit = map['product_unit'];
    price = map['price'];
    quantity = map['quantity'];
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    // data['id'] = this.id;
    data['cart_id'] = this.cartId;
    data['product_id'] = this.productId;
    data['product_name'] = this.productName;
    data['product_unit'] = this.productUnit;
    data['price'] = this.price;
    data['quantity'] = this.quantity;
    return data;
  }
}