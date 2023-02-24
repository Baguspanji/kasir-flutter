import 'package:flutter/material.dart';
import 'package:kasir_app/src/config/constans_config.dart';
import 'package:kasir_app/src/model/transaksi_model.dart';

class ShareStruk {
  static Widget struk(TransaksiModel transaksi) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            Text(
              'Toko Palapa',
              style: TextStyle(
                fontSize: 20,
                color: Colors.black87,
                fontWeight: FontWeight.w400,
              ),
            ),
            Text(
              'Pertokoan Pasar Atas',
              style: TextStyle(
                fontSize: 20,
                color: Colors.black87,
                fontWeight: FontWeight.w400,
                height: 1,
              ),
            ),
            Text(
              '085123123123',
              style: TextStyle(
                fontSize: 18,
                color: Colors.black87,
                fontWeight: FontWeight.w400,
                height: 1,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Tgl Trx: 12-12-2020 12:12:12',
              style: TextStyle(
                fontSize: 18,
                color: Colors.black87,
                fontWeight: FontWeight.w400,
                height: 1.2,
              ),
            ),
            Text(
              'Jml Jns Brg: 12',
              style: TextStyle(
                fontSize: 18,
                color: Colors.black87,
                fontWeight: FontWeight.w400,
                height: 1.2,
              ),
            ),
            Text(
              'Pembeli : Doni',
              style: TextStyle(
                fontSize: 18,
                color: Colors.black87,
                fontWeight: FontWeight.w400,
                height: 1.2,
              ),
            ),
            Text(
              '===========================',
              style: TextStyle(
                fontSize: 18,
                color: Colors.black87,
                fontWeight: FontWeight.w400,
                height: 1.2,
              ),
            ),
            for (int i = 0; i < 4; i++)
              ...transaksi.details!.map((e) {
                String s = e.item!.unit ?? "-";
                final idx = s.split("/");

                int qty = int.parse(idx[0]) * int.parse(e.quantity ?? '0');
                String unit = '$qty ${idx[1]}';

                String desc =
                    "$unit x ${toCurrency(double.parse(e.price ?? '0'))}";
                String price = toCurrency(double.parse(e.price ?? '0') *
                    double.parse(e.quantity ?? '0'));
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      e.item!.name ?? '',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black87,
                        fontWeight: FontWeight.w400,
                        height: 1.2,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          desc,
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.black87,
                            fontWeight: FontWeight.w400,
                            height: 1.2,
                          ),
                        ),
                        Text(
                          price,
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.black87,
                            fontWeight: FontWeight.w400,
                            height: 1.2,
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              }),
            Text(
              '===========================',
              style: TextStyle(
                fontSize: 18,
                color: Colors.black87,
                fontWeight: FontWeight.w400,
                height: 1.2,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black87,
                    fontWeight: FontWeight.w400,
                    height: 1,
                  ),
                ),
                Text(
                  toRupiah(double.parse(transaksi.totalPrice ?? '0')),
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black87,
                    fontWeight: FontWeight.w400,
                    height: 1,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Bayar',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black87,
                    fontWeight: FontWeight.w400,
                    height: 1,
                  ),
                ),
                Text(
                  toRupiah(double.parse(transaksi.amountPaid ?? '0')),
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black87,
                    fontWeight: FontWeight.w400,
                    height: 1,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Kembali',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black87,
                    fontWeight: FontWeight.w400,
                    height: 1,
                  ),
                ),
                Text(
                  toRupiah(double.parse(transaksi.amountPaid ?? '0') -
                      double.parse(transaksi.totalPrice ?? '0')),
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black87,
                    fontWeight: FontWeight.w400,
                    height: 1,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Text(
              'Bukan jam setengah 7 pagi - 7 malam',
              style: TextStyle(
                fontSize: 18,
                color: Colors.black87,
                fontWeight: FontWeight.w400,
                height: 1.2,
              ),
            ),
            Text(
              'Terima Kasih',
              style: TextStyle(
                fontSize: 18,
                color: Colors.black87,
                fontWeight: FontWeight.w400,
                height: 1.2,
              ),
            ),
            Text(
              dateFormatEEEEdMMMMyyyyhhmm(DateTime.now()),
              style: TextStyle(
                fontSize: 18,
                color: Colors.black87,
                fontWeight: FontWeight.w400,
                height: 1.2,
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  // void onPressed(BuildContext context) async {
  //   screenshotController
  //       .capture(delay: Duration(milliseconds: 10))
  //       .then((capturedImage) async {
  //     ShowCapturedWidget(context, capturedImage!);
  //   }).catchError((onError) {
  //     print(onError);
  //   });
  // }

  // Future<dynamic> ShowCapturedWidget(
  //     BuildContext context, Uint8List capturedImage) {
  //   return showDialog(
  //     useSafeArea: false,
  //     context: context,
  //     builder: (context) => Scaffold(
  //       appBar: AppBar(
  //         backgroundColor: primaryColor,
  //         title: Text("Captured widget screenshot"),
  //       ),
  //       body: Center(
  //           child: capturedImage != null
  //               ? Image.memory(capturedImage)
  //               : Container()),
  //     ),
  //   );
  // }
}
