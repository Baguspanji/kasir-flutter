import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kasir_app/src/config/constans_config.dart';
import 'package:kasir_app/src/config/size_config.dart';
import 'package:kasir_app/src/controller/cart_controller.dart';
import 'package:kasir_app/src/model/cart_db_model.dart';
import 'package:kasir_app/src/repository/cart_db.dart';
import 'package:kasir_app/src/ui/components/custom_components.dart';
import 'package:kasir_app/src/ui/components/modal.dart';
import 'package:kasir_app/src/ui/home/index_product.dart';

class HomeUI extends StatefulWidget {
  @override
  State<HomeUI> createState() => _HomeUIState();
}

class _HomeUIState extends State<HomeUI> {
  final conCart = Get.put(CartController());
  DbHelper dbHelper = DbHelper();
  int count = 0;
  List<CartDBModel> cartList = [];

  final _formName = TextEditingController();

  @override
  void initState() {
    getCart();
    super.initState();
  }

  getCart() async {
    cartList = await dbHelper.getCartList();

    if (cartList.isEmpty) {
      addCart();
    }
    setState(() {
      count = cartList.length;
    });
  }

  addCart() async {
    dbHelper.insertCart(CartDBModel.fromMap({
      'name': '',
      'bill_amount': 0,
    }));
    getCart();
  }

  editCart(CartDBModel cart) async {
    setState(() {
      _formName.text = cart.name!;
    });

    Modals.showModal(
      title: 'Keranjang',
      subTitle: '',
      subTitleWidget: Container(
        width: width(context) * 0.8,
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(height: height(context) * 0.01),
            CustomTextField(
              controller: _formName,
              hintText: "Nama Pemesan",
              prefixIcon: Icon(Icons.person),
            ),
            SizedBox(height: height(context) * 0.02),
            // button ok
            Container(
              width: width(context),
              height: height(context) * 0.04,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                  dbHelper.updateCart(CartDBModel.fromMap({
                    'id': cart.id,
                    'name': _formName.text,
                  }));

                  getCart();

                  setState(() {});
                  Navigator.pop(context);
                },
                child: Text("OK", style: TextStyle(fontSize: 18)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          SizedBox(height: height(context) * 0.01),
          Container(
            width: width(context),
            height: height(context) * 0.04,
            margin: EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Daftar Keranjang',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black87,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Spacer(),
                GestureDetector(
                  onTap: () async {
                    await dbHelper.truncateCart();

                    await addCart();
                    await getCart();
                  },
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(
                      Icons.delete_forever,
                      color: Colors.red,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: height(context) * 0.02),
          Expanded(
            child: Container(
              width: width(context),
              height: height(context),
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: FutureBuilder(
                future: dbHelper.getCartList(),
                builder: (context, AsyncSnapshot<List<CartDBModel>> snapshot) {
                  if (snapshot.data == null) {
                    return Container(
                      height: height(context) * 0.8,
                      child: CustomEmptyData(
                        height: height(context) * 0.9,
                        text: 'Keranjang tidak ditemukan',
                        textRefresh: 'Tambah Keranjang',
                        onPressed: () => addCart(),
                      ),
                    );
                  }

                  cartList = snapshot.data!;
                  count = cartList.length;
                  return ListView(
                    children: [
                      ...cartList.reversed
                          .map((cart) => _cartItem(context, cart))
                          .toList(),
                      GestureDetector(
                        onTap: () => addCart(),
                        child: Container(
                          width: width(context),
                          padding: EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 10,
                          ),
                          margin: EdgeInsets.only(bottom: 10),
                          decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                spreadRadius: 1,
                                blurRadius: 5,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Icon(
                            Icons.add,
                            color: Colors.black87,
                            size: 18,
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _cartItem(BuildContext context, CartDBModel cart) {
    return GestureDetector(
      onTap: () {
        conCart.status.value = "new";
        conCart.idEdit.value = 0;
        conCart.cartDb.value = cart;
        Get.to(() => HomeProductUI(cartDb: cart))!.then((value) => getCart());
      },
      child: Container(
        width: width(context),
        padding: EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 10,
        ),
        margin: EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            Text(cart.name != '' ? cart.name! : 'Keranjang ${cart.id}'),
            Spacer(),
            GestureDetector(
              onTap: () {
                editCart(cart);
              },
              child: Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  Icons.edit,
                  color: Colors.orange,
                  size: 15,
                ),
              ),
            ),
            SizedBox(width: 10),
            GestureDetector(
              onTap: () {
                dbHelper.deleteCart(cart.id!);
                getCart();
              },
              child: Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  Icons.delete,
                  color: Colors.red,
                  size: 15,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
