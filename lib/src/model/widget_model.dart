import 'package:kasir_app/src/model/product_model.dart';

class ProfileItemModel {
  final String title;
  final String icon;
  final String? subTitle;

  ProfileItemModel(this.title, this.icon, {this.subTitle});
}

class NavModel {
  final String title;
  final String svgVisible;
  final String svgInvisible;

  NavModel(this.svgVisible, this.svgInvisible, this.title);
}

class CartModel {
  int id;
  int price;
  int qty;
  ProductModel? product;

  CartModel(this.id, this.price, this.qty, this.product);
}
