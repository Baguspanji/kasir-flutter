import 'package:barcode_scan2/barcode_scan2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:kasir_app/src/config/constans_config.dart';
import 'package:kasir_app/src/config/size_config.dart';
import 'package:kasir_app/src/controller/product_controller.dart';

class TambahBarang extends StatefulWidget {
  static const routeName = '/profile/tambahbarang';
  // const TambahBarang({super.key});

  @override
  State<TambahBarang> createState() => _TambahBarangState();
}

class _TambahBarangState extends State<TambahBarang> {
  ProductController productCon = Get.put(ProductController());

  TextEditingController code1 = TextEditingController();
  TextEditingController code2 = TextEditingController();
  TextEditingController code3 = TextEditingController();
  TextEditingController code4 = TextEditingController();
  TextEditingController code5 = TextEditingController();
  TextEditingController code6 = TextEditingController();
  TextEditingController code7 = TextEditingController();
  TextEditingController code8 = TextEditingController();
  TextEditingController code9 = TextEditingController();
  TextEditingController code10 = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController perUnit = TextEditingController();
  TextEditingController unit = TextEditingController();
  TextEditingController takePrice = TextEditingController();
  TextEditingController price = TextEditingController();

  ScanResult? scanResult;

  static final _possibleFormats = BarcodeFormat.values.toList()
    ..removeWhere((e) => e == BarcodeFormat.unknown);

  List<BarcodeFormat> selectedFormats = [..._possibleFormats];

  Future<void> _scanQr() async {
    try {
      final result = await BarcodeScanner.scan(
        options: ScanOptions(
          strings: {
            'cancel': 'Kembali ',
            'flash_on': '',
            'flash_off': '',
          },
          restrictFormat: selectedFormats,
          useCamera: -1,
          autoEnableFlash: false,
          android: const AndroidOptions(
            aspectTolerance: 0.00,
            useAutoFocus: true,
          ),
        ),
      );
      setState(() {
        scanResult = result;
      });
    } on PlatformException catch (e) {
      setState(() {
        scanResult = ScanResult(
          type: ResultType.Error,
          format: BarcodeFormat.unknown,
          rawContent: e.code == BarcodeScanner.cameraAccessDenied
              ? 'The user did not grant the camera permission!'
              : 'Unknown error: $e',
        );
      });
    }
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
                  InkWell(
                    onTap: () => Navigator.pop(context),
                    child: Icon(
                      Icons.arrow_back_ios,
                      size: 20,
                    ),
                  ),
                  SizedBox(width: width(context) * 0.02),
                  Text(
                    'Tambah Barang',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black87,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Spacer(),
                ],
              ),
            ),
            SizedBox(height: height(context) * 0.02),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.only(left: 20, right: 20),
                children: [
                  const SizedBox(height: 10),
                  _input(
                    context,
                    'Kode 1',
                    code1,
                    suffixIcon: InkWell(
                      onTap: () async {
                        await _scanQr();

                        setState(() {
                          code1.text = scanResult!.rawContent;
                          scanResult = null;
                        });
                      },
                      child: Icon(
                        Icons.qr_code,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  _input(
                    context,
                    'Kode 2',
                    code2,
                    suffixIcon: InkWell(
                      onTap: () async {
                        await _scanQr();

                        setState(() {
                          code2.text = scanResult!.rawContent;
                          scanResult = null;
                        });
                      },
                      child: Icon(
                        Icons.qr_code,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  _input(
                    context,
                    'Kode 3',
                    code3,
                    suffixIcon: InkWell(
                      onTap: () async {
                        await _scanQr();

                        setState(() {
                          code3.text = scanResult!.rawContent;
                          scanResult = null;
                        });
                      },
                      child: Icon(
                        Icons.qr_code,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  _input(
                    context,
                    'Kode 4',
                    code4,
                    suffixIcon: InkWell(
                      onTap: () async {
                        await _scanQr();

                        setState(() {
                          code4.text = scanResult!.rawContent;
                          scanResult = null;
                        });
                      },
                      child: Icon(
                        Icons.qr_code,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  _input(
                    context,
                    'Kode 5',
                    code5,
                    suffixIcon: InkWell(
                      onTap: () async {
                        await _scanQr();

                        setState(() {
                          code5.text = scanResult!.rawContent;
                          scanResult = null;
                        });
                      },
                      child: Icon(
                        Icons.qr_code,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  _input(
                    context,
                    'Kode 6',
                    code6,
                    suffixIcon: InkWell(
                      onTap: () async {
                        await _scanQr();

                        setState(() {
                          code6.text = scanResult!.rawContent;
                          scanResult = null;
                        });
                      },
                      child: Icon(
                        Icons.qr_code,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  _input(
                    context,
                    'Kode 7',
                    code7,
                    suffixIcon: InkWell(
                      onTap: () async {
                        await _scanQr();

                        setState(() {
                          code7.text = scanResult!.rawContent;
                          scanResult = null;
                        });
                      },
                      child: Icon(
                        Icons.qr_code,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  _input(
                    context,
                    'Kode 8',
                    code8,
                    suffixIcon: InkWell(
                      onTap: () async {
                        await _scanQr();

                        setState(() {
                          code8.text = scanResult!.rawContent;
                          scanResult = null;
                        });
                      },
                      child: Icon(
                        Icons.qr_code,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  _input(
                    context,
                    'Kode 9',
                    code9,
                    suffixIcon: InkWell(
                      onTap: () async {
                        await _scanQr();

                        setState(() {
                          code9.text = scanResult!.rawContent;
                          scanResult = null;
                        });
                      },
                      child: Icon(
                        Icons.qr_code,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  _input(
                    context,
                    'Kode 10',
                    code10,
                    suffixIcon: InkWell(
                      onTap: () async {
                        await _scanQr();

                        setState(() {
                          code10.text = scanResult!.rawContent;
                          scanResult = null;
                        });
                      },
                      child: Icon(
                        Icons.qr_code,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  _input(context, 'Nama Barang', name),
                  _input(context, 'Deskripsi', description),
                  Row(
                    children: [
                      Expanded(
                        child: _input(
                          context,
                          'Per Unit',
                          perUnit,
                          type: TextInputType.number,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: _input(context, 'Unit', unit),
                      ),
                    ],
                  ),
                  _input(
                    context,
                    'Harga Beli',
                    takePrice,
                    type: TextInputType.number,
                  ),
                  _input(
                    context,
                    'Harga Jual',
                    price,
                    type: TextInputType.number,
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
                  bool res = await productCon.addItem(
                    code1.text,
                    code2.text,
                    code3.text,
                    code4.text,
                    code5.text,
                    code6.text,
                    code7.text,
                    code8.text,
                    code9.text,
                    code10.text,
                    name.text,
                    description.text,
                    perUnit.text,
                    unit.text,
                    takePrice.text,
                    price.text,
                  );

                  if (res) {
                    getToast('Berhasil menambahkan barang');
                    productCon.getProduct(1);
                    // delay 2 second
                    await Future.delayed(const Duration(seconds: 2));

                    // back to list
                    Get.back();
                  } else {
                    getToast('Gagal menambahkan barang');
                  }
                },
                child: productCon.isLoading.value == true
                    ? const CircularProgressIndicator()
                    : const Text(
                        'Tambah',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          // fontWeight: FontWeight.w600,
                        ),
                      ),
              ),
            ),
            SizedBox(height: height(context) * 0.02),
          ],
        ),
      ),
    );
  }

  Widget _input(
    BuildContext context,
    String hint,
    TextEditingController controller, {
    TextInputType type = TextInputType.text,
    Widget suffixIcon = const SizedBox(),
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 8),
          child: Text(
            hint,
            style: TextStyle(
              fontSize: 16,
              color: Colors.black87,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const SizedBox(height: 10),
        Container(
          width: width(context),
          margin: const EdgeInsets.only(bottom: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            color: Colors.white,
            border: Border.all(
              color: Colors.grey,
              width: 2,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 6,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: TextField(
            controller: controller,
            keyboardType: type,
            decoration: InputDecoration(
              hintText: 'Masukkan $hint',
              suffixIcon: suffixIcon,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
