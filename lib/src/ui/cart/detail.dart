import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kasir_app/src/config/constans_config.dart';
import 'package:kasir_app/src/config/size_config.dart';
import 'package:kasir_app/src/controller/cart_controller.dart';
import 'package:kasir_app/src/model/user_model.dart';
import 'package:kasir_app/src/repository/s_preference.dart';
import 'package:kasir_app/src/ui/components/custom_components.dart';
import 'package:kasir_app/src/ui/components/modal.dart';
import 'package:kasir_app/src/ui/components/struk_print.dart';

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
          final total = conCart.totalAmountCart;

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
                    InkWell(
                      onTap: () => Navigator.pop(context),
                      child: Icon(
                        Icons.arrow_back_ios,
                        size: 20,
                      ),
                    ),
                    SizedBox(width: width(context) * 0.02),
                    Text(
                      'Detail Keranjang',
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
                            e.name ?? '-',
                            '',
                            desc: e.unit ?? '-',
                          ),
                          _itemDetailTransaksi(
                            context,
                            '${e.qty} x ${toRupiah(double.parse(e.price.toString()))}',
                            toRupiah(
                              double.parse(
                                (e.price! * e.qty!).toString(),
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
                height: height(context) * 0.04,
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: conCart.status.value == 'edit'
                        ? Colors.amber
                        : primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () async {
                    var app = await getUser();

                    var data =
                        AppModel.fromJson(jsonDecode(app)['data']['app']);

                    Response<dynamic> res;
                    if (conCart.status.value == 'edit') {
                      res = await conCart.editTransaction(
                        name: _formName.text,
                        amount: _formAmount.text,
                      );
                    } else {
                      res = await conCart.addTransaction(
                        name: _formName.text,
                        amount: _formAmount.text,
                      );
                    }

                    if (res.statusCode == 201) {
                      print.sample(
                        cartData,
                        appName: data.name ?? '',
                        appAddress: data.address ?? '',
                        appPhone: data.phone ?? '',
                        openTime: data.openTime ?? '',
                        strukMessage: data.strukMessage ?? '',
                        total: total,
                        buyerName: _formName.text,
                        amountPaid: _formAmount.text,
                      );

                      conCart.clearCart();
                      if (conCart.status.value == 'edit') {
                        getToast('Berhasil mengubah transaksi');
                        conCart.status.value = 'new';
                        conCart.idEdit.value = 0;
                      } else {
                        getToast('Berhasil menambahkan transaksi');
                      }

                      Future.delayed(Duration(seconds: 2), () {
                        Navigator.pop(context);
                        Navigator.pop(context);
                      });
                    } else {
                      getToast('Gagal menambahkan transaksi');
                    }
                  },
                  child: Text("Proses", style: TextStyle(fontSize: 18)),
                ),
              ),
              SizedBox(height: height(context) * 0.02),
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
    String desc = '',
    bool titleBold = true,
    bool valueBold = false,
  }) {
    return Container(
      width: width(context),
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (!desc.isNotEmpty)
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                color: Colors.black87,
                fontWeight: titleBold ? FontWeight.w600 : FontWeight.w400,
              ),
            ),
          if (desc.isNotEmpty)
            RichText(
              text: TextSpan(children: [
                TextSpan(
                  text: title,
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black87,
                    fontWeight: titleBold ? FontWeight.w600 : FontWeight.w400,
                  ),
                ),
                TextSpan(
                  text: ' - ' + desc,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black87,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ]),
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
