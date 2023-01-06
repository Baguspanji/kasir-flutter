import 'package:get/get.dart';
import 'package:kasir_app/src/model/widget_model.dart';
import 'package:kasir_app/src/repository/api_transaksi.dart';

class CartController extends GetxController {
  final api = ApiTransaksi();

  final listCart = <CartModel>[].obs;

  void addCart(CartModel cart) {
    var allCart = listCart.value;
    if (allCart.isEmpty) {
      listCart.add(cart);
      return;
    }

    var findCart = allCart.firstWhere((element) => element.id == cart.id,
        orElse: () => CartModel(0, 0, 0, null));

    if (findCart.id == 0) {
      listCart.add(cart);
    } else {
      findCart.qty += cart.qty;
      updateCart(findCart);
    }
  }

  void decrementQty(CartModel cart) {
    var allCart = listCart.value;
    var findCart = allCart.firstWhere((element) => element.id == cart.id,
        orElse: () => CartModel(0, 0, 0, null));

    if (findCart.id != 0) {
      findCart.qty -= 1;
      updateCart(findCart);
    }
  }

  void incrementQty(CartModel cart) {
    var allCart = listCart.value;
    var findCart = allCart.firstWhere((element) => element.id == cart.id,
        orElse: () => CartModel(0, 0, 0, null));

    if (findCart.id != 0) {
      findCart.qty += 1;
      updateCart(findCart);
    }
  }

  void updateCart(CartModel cart) {
    var allCart = listCart.value;

    allCart[allCart.indexWhere((element) => element.id == cart.id)] = cart;
    listCart.value = allCart;
  }

  void removeCart(CartModel cart) {
    var allCart = listCart.value;

    listCart.value = allCart
        .where((element) => element.id != cart.id)
        .toList(growable: false);
  }

  void clearCart() {
    listCart.value = [];
  }

  int get totalCart => listCart.value.length;

  // addTransaction
  Future<void> addTransaction({
    required String name,
    required double amount,
  }) async {
    dynamic data = {
      'name': name,
      'amount_paid': amount,
      'items': [
        ...listCart.value.map((e) => {
              'id': e.id,
              'quantity': e.qty,
              'price': e.price,
            }),
      ],
    };

    var res = await api.createTransaksi(data);

    if (res.statusCode == 201) {
      clearCart();
    }
  }
}
