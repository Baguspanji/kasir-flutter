import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:kasir_app/src/config/constans_config.dart';
import 'package:kasir_app/src/config/size_config.dart';
import 'package:kasir_app/src/controller/cart_controller.dart';
import 'package:kasir_app/src/model/widget_model.dart';
import 'package:kasir_app/src/ui/cart/detail.dart';
import 'package:kasir_app/src/ui/components/custom_components.dart';
import 'package:kasir_app/src/ui/components/modal.dart';

class CartUI extends StatefulWidget {
  @override
  State<CartUI> createState() => _CartUIState();
}

class _CartUIState extends State<CartUI> {
  final conCart = Get.find<CartController>();
  CartModel cartEdit = CartModel(0, 0, 0, null);
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
    return Column(
      children: [
        SizedBox(height: height(context) * 0.01),
        Container(
          width: width(context),
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Keranjang",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black87,
                  fontWeight: FontWeight.w600,
                ),
              ),
              InkWell(
                onTap: () {
                  conCart.clearCart();
                  setState(() {});
                },
                child: Container(
                  padding: EdgeInsets.all(10),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    Icons.delete,
                    size: 20,
                    color: Colors.white,
                  ),
                ),
              )
            ],
          ),
        ),
        SizedBox(height: height(context) * 0.01),
        Expanded(
          child: ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 10),
            itemCount: conCart.listCart.length,
            itemBuilder: (context, index) {
              final item = conCart.listCart.reversed.toList()[index];
              return _itemProductList(context, item);
            },
          ),
        ),
        Container(
          width: width(context),
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
                      final cart = conCart.listCart.value;
                      final total = cart.fold(
                          0,
                          (previousValue, element) =>
                              previousValue + (element.price * element.qty));

                      return _tableField(
                          "Total", toRupiah(double.parse('$total')));
                    }),
                  ],
                ),
              ),
              Container(
                width: width(context),
                height: height(context) * 0.04,
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () => Get.toNamed(CartDetailUI.routeName),
                  child: Text("Proses", style: TextStyle(fontSize: 18)),
                ),
              ),
              SizedBox(height: height(context) * 0.01),
            ],
          ),
        ),
      ],
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
                conCart.removeCart(cart);
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
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.name ?? '-',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black45,
                        fontWeight: FontWeight.w400,
                        height: 1,
                      ),
                    ),
                    SizedBox(height: 4),
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
                            text: item.unit ?? '-',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.black45,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      toRupiah(double.parse(cart.price.toString()) * cart.qty),
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
            ),
            SizedBox(width: 10),
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.black12),
              ),
              child: IconButton(
                padding: EdgeInsets.zero,
                icon: Icon(
                  Icons.edit,
                  size: 24,
                  color: Colors.black45,
                ),
                onPressed: () {
                  setState(() {
                    cartEdit = cart;

                    _formName.text = item.name ?? '';
                    _formPrice.text = cart.price.toString();
                    _formQty.text = cart.qty.toString();
                  });

                  _openModal(context);
                },
              ),
            ),
            SizedBox(width: 10),
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
              hintText: "Nama Barang",
              prefixIcon: Icon(Icons.add_box),
              readOnly: true,
            ),
            SizedBox(height: height(context) * 0.01),
            CustomTextField(
              controller: _formPrice,
              hintText: "Uang Harga",
              prefixIcon: Icon(Icons.money),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: height(context) * 0.01),
            CustomTextField(
              controller: _formQty,
              hintText: "Banyak",
              prefixIcon: Icon(Icons.numbers),
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
                  cartEdit.price = int.parse(_formPrice.text);
                  cartEdit.qty = int.parse(_formQty.text);

                  conCart.updateCart(cartEdit);

                  setState(() {
                    _formName.clear();
                    _formPrice.clear();
                    _formQty.clear();
                  });
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
