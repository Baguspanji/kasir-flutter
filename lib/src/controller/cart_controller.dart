import 'package:get/get.dart';
import 'package:kasir_app/src/repository/api_transaksi.dart';
import 'package:kasir_app/src/repository/sqlite_cart.dart';

class CartController extends GetxController {
  final api = ApiTransaksi();
  final db = CartDB();

  final listCart = <CartDBModel>[].obs;
  RxString status = "new".obs;
  RxInt idEdit = 0.obs;
  RxInt countCart = 0.obs;

  Future<void> getCart() async {
    await db.open();
    final raw = await db.getCartAll();

    listCart.value = raw != [] ? [...raw.map((e) => e)] : [];
    countCart.value = raw.length;
    await db.close();
  }

  Future<void> addCart(CartDBModel cart) async {
    await db.open();
    await db.insert(cart);
    await db.close();
    getCart();
  }

  Future<void> updateCart(CartDBModel cart) async {
    await db.open();
    await db.update(cart);
    await db.close();
    getCart();
  }

  Future<void> removeCart(int id) async {
    await db.open();
    await db.delete(id);
    await db.close();
    getCart();
  }

  Future<void> clearCart() async {
    await db.open();
    await db.deleteAll();
    await db.close();
    getCart();
  }

  int get totalCountCart => countCart.value;
  int get totalAmountCart => listCart.value.fold(
        0,
        (previousValue, element) =>
            previousValue + (element.price! * element.qty!),
      );

  // addTransaction
  Future<Response<dynamic>> addTransaction({
    required String name,
    required String amount,
  }) async {
    dynamic data = {
      if (name != '') 'name': name,
      if (amount != '') 'amount_paid': amount,
      'items': [
        ...listCart.value.map((e) => {
              'id': e.id,
              'quantity': e.qty,
              'price': e.price,
            }),
      ],
    };

    return await api.createTransaksi(data);
  }

  // EditTransaction
  Future<Response<dynamic>> editTransaction(
      {required String name, required String amount}) async {
    dynamic data = {
      if (name != '') 'name': name,
      if (amount != '') 'amount_paid': amount,
      'items': [
        ...listCart.value.map((e) => {
              'id': e.id,
              'quantity': e.qty,
              'price': e.price,
            }),
      ],
    };

    return await api.editTransaksi(data, idEdit.value);
  }
}
