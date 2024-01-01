import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:image_downloader/image_downloader.dart';
import 'package:kasir_app/src/config/constans_config.dart';
import 'package:kasir_app/src/config/route_config.dart';
import 'package:kasir_app/src/controller/cart_controller.dart';
import 'package:kasir_app/src/controller/incomeController.dart';
import 'package:kasir_app/src/model/transaksi_model.dart';
import 'package:kasir_app/src/model/user_model.dart';
import 'package:kasir_app/src/repository/s_preference.dart';
import 'package:kasir_app/src/repository/sqlite_cart.dart';
import 'package:kasir_app/src/ui/components/modal.dart';
import 'package:kasir_app/src/ui/components/struk_print.dart';
import 'package:kasir_app/src/ui/nav_ui.dart';
import 'package:share_plus/share_plus.dart';

import '../../config/size_config.dart';

class TransaksiDetailUI extends StatefulWidget {
  static const routeName = '/transaksi/detail';

  @override
  State<TransaksiDetailUI> createState() => _TransaksiDetailUIState();
}

class _TransaksiDetailUIState extends State<TransaksiDetailUI> {
  final args = Get.arguments as CommonArgument<TransaksiModel>;

  final conCart = Get.put(CartController());
  final conIncome = Get.put(IncomeController());
  final print1 = StrukPrintCart();

  int _counter = 0;
  Uint8List? _imageFile;

  //Create an instance of ScreenshotController

  @override
  void initState() {
    conIncome.init();

    super.initState();
  }

  void scren(TransaksiModel transaksi) async {
    // var container = ShareStruk.struk(transaksi);
    final urlImage = await conIncome.apiGenerateImage(transaksi.id!);
    Modals.showModal(
      title: 'Share Struk Transaksi',
      subTitle: '',
      subTitleWidget: Container(
        width: width(context) * 0.8,
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(height: height(context) * 0.01),
            Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                image: DecorationImage(image: NetworkImage(urlImage!)),
              ),
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
                onPressed: () async {
                  String path = await conIncome.apiDownloadImage(urlImage!);
                  Share.shareXFiles([XFile(path)]);
                  Navigator.pop(context);
                },
                child: Text("Share", style: TextStyle(fontSize: 18)),
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
                    onPressed: () => scren(args.object!),
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

                  final List<CartDBModel> cart = [
                    ...args.object!.details!.map((e) => CartDBModel.fromMap({
                          '_id': int.parse(e.itemId!),
                          'name': e.item!.name,
                          'unit': e.item!.unit,
                          'price': int.parse(e.price!),
                          'qty': int.parse(e.quantity!),
                        }))
                  ];

                  print1.sample(
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
            const SizedBox(height: 10),
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
                  conCart.status.value = "edit";
                  conCart.idEdit.value = args.id!;

                  conCart.listCart.clear();
                  await conCart.clearCart();
                  // print(conCart.status.value);
                  for (var i = 0; i < args.object!.details!.length; i++) {
                    final e = args.object!.details![i];
                    await conCart.addCart(CartDBModel.fromMap({
                      '_id': int.parse(e.itemId!),
                      'name': e.item!.name,
                      'unit': e.item!.unit,
                      'price': int.parse(e.price!),
                      'qty': int.parse(e.quantity!),
                    }));
                  }

                  Get.offAndToNamed(NavUI.routeName);
                  // print(item);
                },
                child: Text("Edit", style: TextStyle(fontSize: 18)),
              ),
            ),
            SizedBox(height: height(context) * 0.02),
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
