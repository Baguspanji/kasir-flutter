import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:kasir_app/src/config/constans_config.dart';
import 'package:kasir_app/src/config/size_config.dart';
import 'package:kasir_app/src/controller/cart_controller.dart';
import 'package:kasir_app/src/model/widget_model.dart';
import 'package:kasir_app/src/ui/components/custom_components.dart';
import 'package:kasir_app/src/ui/components/modal.dart';

class CartUI extends StatefulWidget {
  static const String routeName = "/cart";

  @override
  State<CartUI> createState() => _CartUIState();
}

class _CartUIState extends State<CartUI> {
  final cartCon = Get.put(CartController());

  final _formName = TextEditingController();
  final _formAmount = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            SizedBox(height: height(context) * 0.01),
            Container(
              width: width(context),
              height: height(context) * 0.04,
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: Icon(Icons.arrow_back_ios),
                      ),
                      Text(
                        "Keranjang",
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black87,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      _miniButton(
                        icon: Icons.delete,
                        color: Colors.red,
                        onTap: () {
                          cartCon.clearCart();
                          setState(() {});
                        },
                      ),
                      SizedBox(width: 10),
                      _miniButton(
                        icon: Icons.add,
                        color: primaryColor,
                        onTap: () => _openModal(context),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: height(context) * 0.02),
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 10),
                itemCount: cartCon.listCart.length,
                itemBuilder: (context, index) {
                  final item = cartCon.listCart.value[index];
                  return _itemProductList(context, item);
                },
              ),
            ),
            Container(
              width: width(context),
              decoration: BoxDecoration(
                color: Colors.white,
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
                    height: height(context) * 0.12,
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        _tableField(
                          "Pemesan",
                          _formName.text != "" ? _formName.text : "-",
                        ),
                        _tableField(
                            "Uang Dibayar",
                            toRupiah(
                              double.parse(
                                _formAmount.text != "" ? _formAmount.text : "0",
                              ),
                            )),
                        Obx(() {
                          final cart = cartCon.listCart.value;
                          final total = cart.fold(
                              0,
                              (previousValue, element) =>
                                  previousValue +
                                  (element.price * element.qty));

                          return _tableField(
                              "Total", toRupiah(double.parse('$total')));
                        }),
                      ],
                    ),
                  ),
                  Container(
                    width: width(context),
                    height: height(context) * 0.05,
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: cartCon.listCart.length == 0
                          ? () => getToast("Keranjang masih kosong")
                          : () async {
                              await cartCon.addTransaction(
                                name: _formName.text,
                                amount: double.parse(
                                  _formAmount.text != ""
                                      ? _formAmount.text
                                      : "0",
                                ),
                              );
                              getToast("Transaksi berhasil");
                              Navigator.pop(context);
                            },
                      child: Text("Proses", style: TextStyle(fontSize: 18)),
                    ),
                  ),
                  SizedBox(height: height(context) * 0.01),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  _openModal(BuildContext context) {
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
            SizedBox(height: height(context) * 0.01),
            CustomTextField(
              controller: _formAmount,
              hintText: "Uang Dibayar",
              prefixIcon: Icon(Icons.money),
              keyboardType: TextInputType.number,
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

  Widget _miniButton({
    required IconData icon,
    required void Function() onTap,
    required Color color,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 46,
        height: 36,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(
          icon,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _tableField(String title, String value) {
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

  Widget _itemProductList(BuildContext context, CartModel cart) {
    final item = cart.product!;

    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 6, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            offset: Offset(0, 3),
            blurRadius: 6,
          ),
        ],
      ),
      child: Slidable(
        key: ValueKey(0),
        endActionPane: ActionPane(
          motion: ScrollMotion(),
          extentRatio: 0.15,
          children: [
            SlidableAction(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
              onPressed: (contex) {
                cartCon.removeCart(cart);
                setState(() {});
              },
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
              icon: Icons.delete,
            ),
          ],
        ),
        child: Row(
          children: [
            CustomImageNetwork(
              item.image ?? '',
              width: width(context) * 0.2,
              height: width(context) * 0.2,
            ),
            SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.code ?? '-',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.black45,
                      fontWeight: FontWeight.w500,
                      height: 1.2,
                    ),
                  ),
                  Text(
                    item.name ?? '-',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black45,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    item.unit ?? '-',
                    style: TextStyle(
                      fontSize: 10,
                      color: Colors.black45,
                      fontWeight: FontWeight.w400,
                      height: 1.2,
                    ),
                  ),
                  SizedBox(height: 6),
                  Text(
                    toRupiah(double.parse((item.price) ?? "0") * cart.qty),
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.black45,
                      fontWeight: FontWeight.w600,
                      height: 1.2,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 10),
            Container(
              height: 50,
              padding: EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                color: Colors.black12,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  _buttonAction(
                    onTap: () {
                      cartCon.decrementQty(cart);
                      setState(() {});
                    },
                    icon: Icons.remove,
                  ),
                  Container(
                    width: 40,
                    height: 30,
                    child: Center(
                      child: Text(
                        cart.qty.toString(),
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.black45,
                          fontWeight: FontWeight.w600,
                          height: 1.2,
                        ),
                      ),
                    ),
                  ),
                  _buttonAction(
                    onTap: () {
                      cartCon.incrementQty(cart);
                      setState(() {});
                    },
                    icon: Icons.add,
                  ),
                ],
              ),
            ),
            SizedBox(width: 10),
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
