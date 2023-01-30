import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kasir_app/src/config/constans_config.dart';
import 'package:kasir_app/src/config/route_config.dart';
import 'package:kasir_app/src/model/transaksi_model.dart';
import 'package:kasir_app/src/model/user_model.dart';
import 'package:kasir_app/src/model/widget_model.dart';
import 'package:kasir_app/src/repository/s_preference.dart';
import 'package:kasir_app/src/ui/components/struk_print.dart';

import '../../config/size_config.dart';

class TransaksiDetailUI extends StatefulWidget {
  static const routeName = '/transaksi/detail';

  @override
  State<TransaksiDetailUI> createState() => _TransaksiDetailUIState();
}

class _TransaksiDetailUIState extends State<TransaksiDetailUI> {
  final args = Get.arguments as CommonArgument<TransaksiModel>;
  final print = StrukPrintCart();

  @override
  void initState() {
    super.initState();
  }

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
                  IconButton(
                    // onPressed: () => Get.to(ShareStruk(
                    //   transaksi: args.object!,
                    // )),
                    onPressed: () => getToast('Fitur belum tersedia'),
                    icon: Icon(Icons.share),
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
                    'Tanggal',
                    dateFormatddMMMMyyyy(
                        DateTime.parse(args.object!.date ?? '')),
                  ),
                  _itemDetailTransaksi(
                    context,
                    'Nama Pembeli',
                    args.object!.name ?? '-',
                  ),
                  SizedBox(height: height(context) * 0.01),
                  Divider(
                    color: Colors.black26,
                    thickness: 1,
                    indent: 20,
                    endIndent: 20,
                  ),
                  SizedBox(height: height(context) * 0.01),
                  ...args.object!.details!.map(
                    (e) => Column(
                      children: [
                        _itemDetailTransaksi(
                          context,
                          e.item!.name ?? '-',
                          desc: e.item!.unit ?? '-',
                          '',
                        ),
                        _itemDetailTransaksi(
                          context,
                          '${e.quantity ?? '-'} x ${toRupiah(double.parse(e.price ?? "0"))}',
                          toRupiah(
                            double.parse(
                              (int.parse(e.price ?? "0") *
                                      int.parse(e.quantity ?? "0"))
                                  .toString(),
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
                    toRupiah(double.parse(args.object!.totalPrice ?? "0")),
                  ),
                  if (args.object!.amountPaid != '0')
                    _itemDetailTransaksi(
                      context,
                      'Jumlah Bayar',
                      toRupiah(double.parse(args.object!.amountPaid ?? "0")),
                    ),
                  if (args.object!.amountPaid != '0')
                    _itemDetailTransaksi(
                      context,
                      'Kembalian',
                      toRupiah(
                        double.parse(
                          (int.parse(args.object!.amountPaid ?? "0") -
                                  int.parse(args.object!.totalPrice ?? "0"))
                              .toString(),
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

                  var data = AppModel.fromJson(jsonDecode(app)['data']['app']);

                  final List<CartModel> cart = [
                    ...args.object!.details!.map((e) => CartModel(
                          int.parse(e.itemId ?? '0'),
                          int.parse(e.price ?? '0'),
                          int.parse(e.quantity ?? '0'),
                          e.item,
                        ))
                  ];

                  print.sample(
                    cart,
                    appName: data.name ?? '',
                    appAddress: data.address ?? '',
                    appPhone: data.phone ?? '',
                    openTime: data.openTime ?? '',
                    strukMessage: data.strukMessage ?? '',
                    total: int.parse(args.object!.totalPrice ?? '0'),
                    buyerName: args.object!.name ?? '',
                    amountPaid: args.object!.amountPaid ?? '0',
                    dateTransaction: args.object!.createdAt ?? '',
                  );
                },
                child: Text("Cetak", style: TextStyle(fontSize: 18)),
              ),
            ),
            SizedBox(height: height(context) * 0.01),
          ],
        ),
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
}
