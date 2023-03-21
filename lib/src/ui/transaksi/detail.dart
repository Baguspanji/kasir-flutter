import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kasir_app/src/config/constans_config.dart';
import 'package:kasir_app/src/config/route_config.dart';
import 'package:kasir_app/src/controller/cart_controller.dart';
import 'package:kasir_app/src/controller/transaksi_controller.dart';
import 'package:kasir_app/src/model/cart_db_model.dart';
import 'package:kasir_app/src/model/transaksi_model.dart';
import 'package:kasir_app/src/model/user_model.dart';
import 'package:kasir_app/src/model/widget_model.dart';
import 'package:kasir_app/src/repository/cart_db.dart';
import 'package:kasir_app/src/repository/s_preference.dart';
import 'package:kasir_app/src/ui/components/struk_print.dart';
import 'package:kasir_app/src/ui/home/index_product.dart';
import 'package:kasir_app/src/ui/transaksi/share_struk.dart';
import 'package:screenshot/screenshot.dart';

import '../../config/size_config.dart';

class TransaksiDetailUI extends StatefulWidget {
  static const routeName = '/transaksi/detail';

  @override
  State<TransaksiDetailUI> createState() => _TransaksiDetailUIState();
}

class _TransaksiDetailUIState extends State<TransaksiDetailUI> {
  DbHelper dbHelper = DbHelper();
  final args = Get.arguments as CommonArgument<TransaksiModel>;

  final CartController conCart = Get.put(CartController());
  final conTransaksi = Get.find<TransaksiController>();
  final print1 = StrukPrintCart();

  int _counter = 0;
  Uint8List? _imageFile;

  //Create an instance of ScreenshotController
  ScreenshotController screenshotController = ScreenshotController();

  @override
  void initState() {
    conTransaksi.detailTransaksi.value = args.object!;

    conTransaksi.getDetailTransaksi(args.id!);
    super.initState();
  }

  void scren(TransaksiModel transaksi) async {
    var container = ShareStruk.struk(transaksi);

    screenshotController
        .captureFromWidget(
      InheritedTheme.captureAll(context, Material(child: container)),
      delay: Duration(seconds: 1),
      pixelRatio: 1,
    )
        .then((capturedImage) {
      ShowCapturedWidget(
        context,
        capturedImage,
      );
    });
  }

  Future<dynamic> ShowCapturedWidget(
      BuildContext context, Uint8List capturedImage) {
    return showDialog(
      useSafeArea: false,
      context: context,
      builder: (context) => Scaffold(
        appBar: AppBar(
          title: Text("Captured widget screenshot"),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Center(
                child: capturedImage != null
                    ? Image.memory(capturedImage)
                    : Container(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Obx(
        () => Column(
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
                    // onPressed: () => scren(conTransaksi.detailTransaksi.value),
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
                    dateFormatddMMMMyyyy(DateTime.parse(
                        conTransaksi.detailTransaksi.value.date ?? '')),
                  ),
                  _itemDetailTransaksi(
                    context,
                    'Nama Pembeli',
                    conTransaksi.detailTransaksi.value.name ?? '-',
                  ),
                  SizedBox(height: height(context) * 0.01),
                  Divider(
                    color: Colors.black26,
                    thickness: 1,
                    indent: 20,
                    endIndent: 20,
                  ),
                  SizedBox(height: height(context) * 0.01),
                  ...conTransaksi.detailTransaksi.value.details!.map(
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
                    toRupiah(double.parse(
                        conTransaksi.detailTransaksi.value.totalPrice ?? "0")),
                  ),
                  if (conTransaksi.detailTransaksi.value.amountPaid != '0')
                    _itemDetailTransaksi(
                      context,
                      'Jumlah Bayar',
                      toRupiah(double.parse(
                          conTransaksi.detailTransaksi.value.amountPaid ??
                              "0")),
                    ),
                  if (conTransaksi.detailTransaksi.value.amountPaid != '0')
                    _itemDetailTransaksi(
                      context,
                      'Kembalian',
                      toRupiah(
                        double.parse(
                          (int.parse(conTransaksi
                                          .detailTransaksi.value.amountPaid ??
                                      "0") -
                                  int.parse(conTransaksi
                                          .detailTransaksi.value.totalPrice ??
                                      "0"))
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
              height: height(context) * 0.04,
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.amber,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () async {
                  int cartId = await dbHelper.insertCart(CartDBModel.fromMap({
                    'name': conTransaksi.detailTransaksi.value.name!,
                    'bill_amount': int.parse(
                      conTransaksi.detailTransaksi.value.amountPaid!,
                    ),
                  }));

                  conCart.cartDb.value = CartDBModel.fromMap({
                    'id': cartId,
                    'name': conTransaksi.detailTransaksi.value.name!,
                    'bill_amount': int.parse(
                      conTransaksi.detailTransaksi.value.amountPaid!,
                    ),
                  });

                  conCart.status.value = "edit";
                  conCart.idEdit.value = args.id!;

                  conTransaksi.detailTransaksi.value.details!
                      .forEach((e) async {
                    conCart.addCart(CartModel(
                      int.parse(e.itemId!),
                      int.parse(e.price!),
                      int.parse(e.quantity!),
                      e.item,
                      cartId,
                    ));
                  });

                  Get.to(() => HomeProductUI(
                            cartDb: CartDBModel(
                              id: cartId,
                              name: conTransaksi.detailTransaksi.value.name!,
                              billAmoount: int.parse(
                                conTransaksi.detailTransaksi.value.amountPaid!,
                              ),
                            ),
                          ))!
                      .then((value) async {
                    await conTransaksi.getDetailTransaksi(args.id!);
                    setState(() {});

                    await dbHelper.deleteCart(cartId);
                  });
                },
                child: Text("Edit", style: TextStyle(fontSize: 18)),
              ),
            ),
            const SizedBox(height: 10),
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
                onPressed: () async {
                  var app = await getUser();

                  var data = AppModel.fromJson(jsonDecode(app)['data']['app']);

                  final List<CartModel> cart = [
                    ...conTransaksi.detailTransaksi.value.details!
                        .map((e) => CartModel(
                              int.parse(e.itemId ?? '0'),
                              int.parse(e.price ?? '0'),
                              int.parse(e.quantity ?? '0'),
                              e.item,
                              null,
                            ))
                  ];

                  print1.sample(
                    cart,
                    appName: data.name ?? '',
                    appAddress: data.address ?? '',
                    appPhone: data.phone ?? '',
                    openTime: data.openTime ?? '',
                    strukMessage: data.strukMessage ?? '',
                    total: int.parse(
                        conTransaksi.detailTransaksi.value.totalPrice ?? '0'),
                    buyerName: conTransaksi.detailTransaksi.value.name ?? '',
                    amountPaid:
                        conTransaksi.detailTransaksi.value.amountPaid ?? '0',
                    dateTransaction:
                        conTransaksi.detailTransaksi.value.createdAt ?? '',
                  );
                },
                child: Text("Cetak", style: TextStyle(fontSize: 18)),
              ),
            ),
            SizedBox(height: height(context) * 0.01),
          ],
        ),
      )),
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
