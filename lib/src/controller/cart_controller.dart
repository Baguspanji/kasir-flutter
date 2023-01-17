import 'dart:convert';

import 'package:get/get.dart';
import 'package:kasir_app/src/model/create_transaksi_model.dart';
import 'package:kasir_app/src/model/transaksi_model.dart';
import 'package:kasir_app/src/model/user_model.dart';
import 'package:kasir_app/src/model/widget_model.dart';
import 'package:kasir_app/src/repository/api_transaksi.dart';
import 'package:kasir_app/src/repository/s_preference.dart';
import 'package:kasir_app/src/ui/transaksi/struk_print.dart';

class CartController extends GetxController {
  final api = ApiTransaksi();

  final listCart = <CartModel>[].obs;
  final printStruk = StrukPrint();

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
    print(res.bodyString);

    // var app = await getUser();

    // var user = AppModel.fromJson(jsonDecode(app)['data']['app']);

    if (res.statusCode == 201) {
      // var createTransaksi = CreateTransaksiModel.fromJson(res.body['data']);

      // var transaksi = TransaksiModel(
      //   name: createTransaksi.name,
      //   amountPaid: createTransaksi.amountPaid.toString(),
      //   totalPrice: createTransaksi.totalPrice.toString(),
      //   totalTakePrice: createTransaksi.totalTakePrice.toString(),
      //   date: createTransaksi.date,
      //   details: createTransaksi.details,
      // );

      // printStruk.sample(
      //   transaksi,
      //   appName: user.name ?? '',
      //   appAddress: user.address ?? '',
      //   appPhone: user.phone ?? '',
      // );
      clearCart();
    }
  }
}
