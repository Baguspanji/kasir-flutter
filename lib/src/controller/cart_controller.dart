import 'package:get/get.dart';
import 'package:kasir_app/src/model/cart_db_model.dart';
import 'package:kasir_app/src/model/product_model.dart';
import 'package:kasir_app/src/model/widget_model.dart';
import 'package:kasir_app/src/repository/api_transaksi.dart';
import 'package:kasir_app/src/repository/cart_db.dart';

class CartController extends GetxController {
  final api = ApiTransaksi();

  DbHelper dbHelper = DbHelper();

  RxString status = "new".obs;
  RxInt idEdit = 0.obs;
  final listCart = <CartModel>[].obs;

  final cartDb = CartDBModel().obs;

  Future<void> initCartDb(CartDBModel cart) async {
    cartDb.value = cart;

    if (cart.id == 0) {
      status.value = "edit";
      idEdit.value = 0;
    } else {
      status.value = "new";
      idEdit.value = 0;

      var cardDetailList = await dbHelper.getCartDetailList(cart.id!);

      print(cardDetailList.length);

      listCart.value = cardDetailList
          .map(
            (e) => CartModel(
              e.productId!,
              e.quantity!,
              e.price!,
              ProductModel(
                id: e.productId,
                name: e.productName!,
                unit: e.productUnit!,
              ),
              e.id!,
            ),
          )
          .toList();
    }
  }

  void addCart(CartModel cart) async {
    var allCart = listCart.value;

    var findCart = allCart.firstWhere((element) => element.id == cart.id,
        orElse: () => CartModel(0, 0, 0, null, null));

    if (findCart.id == 0) {
      await dbHelper.insertCartDetail(CartDetailDBModel.fromMap({
        'cart_id': cartDb.value.id,
        'quantity': cart.qty,
        'price': cart.price,
        'product_id': cart.product!.id,
        'product_name': cart.product!.name,
        'product_unit': cart.product!.unit,
      }));
    } else {
      findCart.qty += cart.qty;
      await updateCart(findCart);
    }

    await initCartDb(cartDb.value);
  }

  Future<void> updateCart(CartModel cart) async {
    var allCart = listCart.value;

    allCart[allCart.indexWhere((element) => element.id == cart.id)] = cart;

    dbHelper.updateCartDetail(CartDetailDBModel.fromMap({
      'id': cart.dbId,
      'cart_id': cartDb.value.id,
      'quantity': cart.qty,
      'price': cart.price,
      'product_id': cart.product!.id,
      'product_name': cart.product!.name,
      'product_unit': cart.product!.unit,
    }));
    listCart.value = allCart;
  }

  void removeCart(CartModel cart) {
    var allCart = listCart.value;

    listCart.value = allCart
        .where((element) => element.id != cart.id)
        .toList(growable: false);

    dbHelper.deleteCartDetail(cart.dbId!);

    var newCart = [];

    listCart.forEach((e) {
      if (e.id != 0) {
        newCart.add(e);
      }
    });

    // dbHelper.deleteCartDetail(cart.id!);

    listCart.value = [...newCart];
  }

  void clearCart() {
    listCart.value = [];
    dbHelper.deleteCartDetailByCartId(cartDb.value.id!);
  }

  int get totalCart => listCart.value.length;

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
