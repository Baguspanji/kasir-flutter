import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kasir_app/src/config/constans_config.dart';
import 'package:kasir_app/src/controller/cart_controller.dart';
import 'package:kasir_app/src/model/user_model.dart';
import 'package:kasir_app/src/repository/s_preference.dart';
import 'package:kasir_app/src/ui/cart/struk_print.dart';
import 'package:kasir_app/src/ui/components/custom_components.dart';
import 'package:kasir_app/src/ui/components/modal.dart';

import '../../config/size_config.dart';

class CartDetailUI extends StatefulWidget {
  static const routeName = '/cart/detail';

  @override
  State<CartDetailUI> createState() => _CartDetailUIState();
}

class _CartDetailUIState extends State<CartDetailUI> {
  final conCart = Get.put(CartController());

  final print = StrukPrintCart();
  final _formName = TextEditingController();
  final _formAmount = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Obx(() {
          final cartData = conCart.listCart.value;

          final cart = conCart.listCart.value;
          final total = cart.fold(
              0,
              (previousValue, element) =>
                  previousValue + (element.price * element.qty));

          return Column(
            children: [
              SizedBox(height: height(context) * 0.01),
              Container(
                width: width(context),
                height: height(context) * 0.04,
                margin: EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: Icon(Icons.arrow_back_ios),
                    ),
                    Text(
                      'Detail Transaksi',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black87,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Spacer(),
                    InkWell(
                      onTap: () => _openModal(context),
                      child: Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Icon(
                          Icons.person,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: height(context) * 0.02),
              Expanded(
                child: ListView(
                  children: [
                    _itemDetailTransaksi(
                      context,
                      'Nama Pembeli',
                      _formName.text != '' ? '-' : _formName.text,
                    ),
                    SizedBox(height: height(context) * 0.01),
                    Divider(
                      color: Colors.black26,
                      thickness: 1,
                      indent: 20,
                      endIndent: 20,
                    ),
                    SizedBox(height: height(context) * 0.01),
                    ...cartData.map(
                      (e) => Column(
                        children: [
                          _itemDetailTransaksi(
                            context,
                            (e.product!.name ?? '-') +
                                ' - ' +
                                (e.product!.unit ?? '-'),
                            '',
                          ),
                          _itemDetailTransaksi(
                            context,
                            '${e.qty} x ${toRupiah(double.parse(e.price.toString()))}',
                            toRupiah(
                              double.parse(
                                (e.price * e.qty).toString(),
                              ),
                            ),
                            titleBold: false,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: height(context) * 0.01),
                    Divider(
                      color: Colors.black26,
                      thickness: 1,
                      indent: 20,
                      endIndent: 20,
                    ),
                    SizedBox(height: height(context) * 0.01),
                    _itemDetailTransaksi(
                      context,
                      'Total Harga',
                      toRupiah(double.parse(total.toString())),
                    ),
                    if (_formAmount.text != '')
                      _itemDetailTransaksi(
                        context,
                        'Jumlah Bayar',
                        toRupiah(double.parse(_formAmount.text)),
                      ),
                    if (_formAmount.text != '')
                      _itemDetailTransaksi(
                        context,
                        'Kembalian',
                        toRupiah(
                          double.parse(
                            (int.parse(_formAmount.text) - total).toString(),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              SizedBox(height: height(context) * 0.02),
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
                  onPressed: () async {
                    var app = await getUser();

                    var data =
                        AppModel.fromJson(jsonDecode(app)['data']['app']);

                    var res = await conCart.addTransaction(
                      name: _formName.text,
                      amount: _formAmount.text,
                    );

                    if (res.statusCode == 201) {
                      print.sample(
                        cartData,
                        appName: data.name ?? '',
                        appAddress: data.address ?? '',
                        appPhone: data.phone ?? '',
                        total: total,
                        buyerName: _formName.text,
                        amountPaid: _formAmount.text,
                      );

                      conCart.clearCart();
                      getToast('Berhasil menambahkan transaksi');
                      Future.delayed(Duration(seconds: 2), () {
                        Navigator.pop(context);
                      });
                    } else {
                      getToast('Gagal menambahkan transaksi');
                    }
                  },
                  child: Text("Proses", style: TextStyle(fontSize: 18)),
                ),
              ),
              SizedBox(height: height(context) * 0.01),
            ],
          );
        }),
      ),
    );
  }

  Widget _itemDetailTransaksi(
    BuildContext context,
    String title,
    String value, {
    bool titleBold = true,
    bool valueBold = false,
  }) {
    return Container(
      width: width(context),
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              color: Colors.black87,
              fontWeight: titleBold ? FontWeight.w600 : FontWeight.w400,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              color: Colors.black87,
              fontWeight: valueBold ? FontWeight.w600 : FontWeight.w400,
            ),
          ),
        ],
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
}
