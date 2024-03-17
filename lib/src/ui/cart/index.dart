import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:kasir_app/src/config/constans_config.dart';
import 'package:kasir_app/src/config/size_config.dart';
import 'package:kasir_app/src/controller/cart_controller.dart';
import 'package:kasir_app/src/repository/sqlite_cart.dart';
import 'package:kasir_app/src/ui/cart/detail.dart';
import 'package:kasir_app/src/ui/components/custom_components.dart';
import 'package:kasir_app/src/ui/components/modal.dart';

class CartUI extends StatefulWidget {
  static const String routeName = "/cart";

  @override
  State<CartUI> createState() => _CartUIState();
}

class _CartUIState extends State<CartUI> {
  final conCart = Get.find<CartController>();
  CartDBModel _cartEdit = CartDBModel();

  final _formName = TextEditingController();
  final _formPrice = TextEditingController();
  final _formQty = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(conCart.status.value);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              width: width(context),
              height: height(context),
              color: Colors.white,
            ),
            Container(
              width: width(context),
              height: height(context) * 0.11,
              decoration: BoxDecoration(
                gradient: bgGradient,
                borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(30)),
              ),
            ),
            Column(
              children: [
                SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: (() => Get.back()),
                        child: Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Color(0xCEFFFFFF),
                          ),
                          child: Icon(
                            Icons.arrow_back_ios_new,
                            color: secondaryColor,
                            size: 24,
                          ),
                        ),
                      ),
                      Text(
                        'Keranjang',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      InkWell(
                        onTap: () => conCart.clearCart(),
                        child: Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Color(0xCEFFFFFF),
                          ),
                          child: Icon(
                            Icons.delete,
                            color: secondaryColor,
                            size: 24,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 30),
                Expanded(
                  child: Obx(() {
                    final cartList = conCart.listCart.value;

                    if (cartList.isEmpty) {
                      return Container(
                        height: height(context) * 0.8,
                        child: CustomEmptyData(
                          height: height(context) * 0.9,
                          text: 'Keranjang masih kosong',
                        ),
                      );
                    }

                    return ListView(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      children: [
                        ...cartList.map((e) => _itemProductList(context, e))
                      ],
                    );
                  }),
                ),
                Container(
                  width: width(context),
                  padding: EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 1,
                        blurRadius: 7,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      SizedBox(height: height(context) * 0.01),
                      Container(
                        width: width(context),
                        height: height(context) * 0.04,
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          children: [
                            Obx(() {
                              return _tableFieldTotal(
                                "Total",
                                toRupiah(
                                    double.parse('${conCart.totalAmountCart}')),
                              );
                            }),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 20),
                        width: width(context),
                        child: button(
                          "Proses",
                          onPressed: () => Get.toNamed(CartDetailUI.routeName),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 10,
                          ),
                          colorText: Colors.white,
                          color: conCart.status.value == 'edit'
                              ? Colors.amber
                              : primaryColor,
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: height(context) * 0.01),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _tableFieldTotal(String title, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 18),
        ),
        Text(
          value,
          style: TextStyle(fontSize: 18),
        ),
      ],
    );
  }

  Widget _itemProductList(BuildContext context, CartDBModel cart) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Slidable(
        key: ValueKey(0),
        endActionPane: ActionPane(
          motion: ScrollMotion(),
          extentRatio: 0.35,
          children: [
            SlidableAction(
              onPressed: (contex) {
                setState(() {
                  _cartEdit = cart;

                  _formName.text = cart.name ?? '';
                  _formPrice.text = cart.price.toString();
                  _formQty.text = cart.qty.toString();
                });

                _openModal(context);
              },
              backgroundColor: Colors.amber,
              foregroundColor: Colors.white,
              icon: Icons.edit,
            ),
            SlidableAction(
              borderRadius: BorderRadius.horizontal(
                right: Radius.circular(10),
              ),
              onPressed: (contex) {
                conCart.removeCart(cart.id!);
              },
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
              icon: Icons.delete,
            ),
          ],
        ),
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.horizontal(
              left: Radius.circular(10),
            ),
            border: Border.all(color: Colors.grey.shade300, width: 2),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                cart.name ?? '-',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black45,
                  fontWeight: FontWeight.w400,
                  height: 1,
                ),
              ),
              SizedBox(height: 8),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      toRupiah(double.parse(cart.price.toString()) * cart.qty!),
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        height: 1.2,
                      ),
                    ),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: cart.qty.toString(),
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black45,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          TextSpan(
                            text: ' x ',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black45,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          TextSpan(
                            text: cart.unit ?? '-',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black45,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _openModal(BuildContext context) {
    Modals.showCupertinoModal(
      context: context,
      isDraggable: true,
      builder: Container(
        width: width(context),
        height: height(context) * 0.34,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(30),
          ),
        ),
        child: Column(
          children: [
            SizedBox(height: 10),
            Container(
              height: 4,
              width: 120,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            SizedBox(height: 10),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  SizedBox(height: height(context) * 0.01),
                  CustomTextField(
                    controller: _formName,
                    hintText: "Nama Barang",
                    padding: EdgeInsets.zero,
                    prefixIcon: Icon(
                      Icons.format_list_bulleted,
                      color: Colors.blue,
                      size: 22,
                    ),
                    readOnly: true,
                  ),
                  SizedBox(height: height(context) * 0.01),
                  CustomTextField(
                    controller: _formPrice,
                    hintText: "Uang Harga",
                    padding: EdgeInsets.zero,
                    prefixIcon: Icon(
                      Icons.attach_money_sharp,
                      color: primaryColor,
                      size: 22,
                    ),
                    keyboardType: TextInputType.number,
                  ),
                  SizedBox(height: height(context) * 0.01),
                  CustomTextField(
                    controller: _formQty,
                    hintText: "Banyak",
                    padding: EdgeInsets.zero,
                    prefixIcon: Icon(
                      Icons.shopping_bag,
                      color: secondaryColor,
                      size: 22,
                    ),
                    keyboardType: TextInputType.number,
                  ),
                  SizedBox(height: height(context) * 0.02),
                  // button ok
                  Container(
                    width: width(context),
                    height: height(context) * 0.05,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: secondaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () {
                        _cartEdit.price = int.parse(_formPrice.text);
                        _cartEdit.qty = int.parse(_formQty.text);

                        conCart.updateCart(_cartEdit);

                        setState(() {
                          _formName.clear();
                          _formPrice.clear();
                          _formQty.clear();
                        });
                        Navigator.pop(context);
                      },
                      child: Text(
                        "OK",
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buttonAction({
    required void Function() onTap,
    required IconData icon,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 30,
        height: 30,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.white),
        ),
        child: Icon(
          icon,
          size: 20,
          color: Colors.black45,
        ),
      ),
    );
  }
}
