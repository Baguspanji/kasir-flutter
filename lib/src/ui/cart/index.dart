import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:kasir_app/src/config/constans_config.dart';
import 'package:kasir_app/src/config/size_config.dart';
import 'package:kasir_app/src/controller/cart_controller.dart';
import 'package:kasir_app/src/model/widget_model.dart';
import 'package:kasir_app/src/ui/cart/detail.dart';

class CartUI extends StatefulWidget {
  @override
  State<CartUI> createState() => _CartUIState();
}

class _CartUIState extends State<CartUI> {
  final conCart = Get.find<CartController>();

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
              final item = conCart.listCart.value[index];
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
                    primary: primaryColor,
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
            // CustomImageNetwork(
            //   item.image ?? '',
            //   width: width(context) * 0.2,
            //   height: width(context) * 0.2,
            // ),
            // SizedBox(width: 10),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Text(
                    //   item.code ?? '-',
                    //   style: TextStyle(
                    //     fontSize: 12,
                    //     color: Colors.black45,
                    //     fontWeight: FontWeight.w500,
                    //     height: 1.2,
                    //   ),
                    // ),
                    Text(
                      (item.name ?? '-') + ' - ' + (item.unit ?? '-'),
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black45,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(height: 4),
                    // Text(
                    //   item.unit ?? '-',
                    //   style: TextStyle(
                    //     fontSize: 10,
                    //     color: Colors.black45,
                    //     fontWeight: FontWeight.w400,
                    //     height: 1.2,
                    //   ),
                    // ),
                    // SizedBox(height: 6),
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
                      conCart.decrementQty(cart);
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
                      conCart.incrementQty(cart);
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
