import 'package:barcode_scan2/barcode_scan2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:kasir_app/src/config/constans_config.dart';
import 'package:kasir_app/src/config/size_config.dart';
import 'package:kasir_app/src/controller/cart_controller.dart';
import 'package:kasir_app/src/controller/product_controller.dart';
import 'package:kasir_app/src/model/product_model.dart';
import 'package:kasir_app/src/repository/sqlite_cart.dart';
import 'package:kasir_app/src/ui/cart/index.dart';
import 'package:kasir_app/src/ui/components/custom_components.dart';
import 'package:kasir_app/src/ui/components/modal.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ProductUI extends StatefulWidget {
  @override
  State<ProductUI> createState() => _ProductUIState();
}

class _ProductUIState extends State<ProductUI> {
  final conProduct = Get.put(ProductController());
  final conCart = Get.put(CartController());

  ScanResult? scanResult;

  final _refreshController = RefreshController(initialRefresh: false);
  final _formSearch = TextEditingController();
  bool _isSearch = false;
  bool _isQR = false;

  ProductModel? _productFrom;
  final _formName = TextEditingController();
  final _formPrice = TextEditingController();
  final _formQty = TextEditingController();

  static final _possibleFormats = BarcodeFormat.values.toList()
    ..removeWhere((e) => e == BarcodeFormat.unknown);

  List<BarcodeFormat> selectedFormats = [..._possibleFormats];

  void _onRefresh() async {
    await Future.delayed(Duration(milliseconds: 1000));

    conProduct.isLoading.value = true;
    conProduct.getProduct(1);
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    await Future.delayed(Duration(milliseconds: 1000));

    conProduct.getProduct(conProduct.productPage.value + 1);
    if (mounted) setState(() {});

    _refreshController.loadComplete();
  }

  @override
  void initState() {
    conProduct.getProduct(1);
    conCart.getCart();
    super.initState();
  }

  Future<void> _searchQr() async {
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
        _isQR = true;
      });

      conProduct.search.value = result.rawContent;
      conProduct.getProduct(1);
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
    return Stack(
      children: [
        Container(
          width: width(context),
          height: height(context),
          color: Colors.white,
        ),
        Container(
          width: width(context),
          height: height(context) * 0.11,
          decoration: BoxDecoration(
            gradient: bgGradient,
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(30)),
          ),
        ),
        Column(
          children: [
            SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: _searchQr,
                    child: Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Color(0xCEFFFFFF),
                      ),
                      child: Icon(
                        Icons.qr_code,
                        color: secondaryColor,
                        size: 24,
                      ),
                    ),
                  ),
                  Container(
                    width: width(context) * 0.68,
                    height: height(context) * 0.05,
                    child: CustomTextField(
                      padding: EdgeInsets.only(left: 12, right: 6),
                      controller: _formSearch,
                      hintText: "Cari Produk",
                      onChanged: (value) {
                        conProduct.search.value = value;
                        conProduct.getProduct(1);
                      },
                      suffixIcon: InkWell(
                        onTap: () {
                          conProduct.search.value = '';
                          _formSearch.clear();
                          conProduct.getProduct(1);
                        },
                        child: Icon(
                          Icons.close,
                          color: secondaryColor,
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Get.toNamed(CartUI.routeName);
                    },
                    child: Stack(
                      children: [
                        Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Color(0xCEFFFFFF),
                          ),
                          child: Icon(
                            Icons.shopping_cart,
                            color: secondaryColor,
                            size: 24,
                          ),
                        ),
                        if (conCart.totalCountCart > 0)
                          Positioned(
                            right: 0,
                            child: Container(
                              padding: EdgeInsets.all(1),
                              decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              constraints: BoxConstraints(
                                minWidth: 16,
                                minHeight: 16,
                              ),
                              child: Text(
                                '${conCart.totalCountCart}',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 30),
            Expanded(
              child: Obx(() {
                final products = conProduct.listProduct.value;

                if (conProduct.isLoading.value) {
                  return Container(
                    height: height(context) * 0.8,
                    child: ListView(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      children: [
                        for (var i = 0; i < 8; i++)
                          Container(
                            margin: EdgeInsets.only(bottom: 10),
                            child: CustomShimmer(
                              width: width(context),
                              height: width(context) * 0.2,
                              radius: 10,
                            ),
                          )
                      ],
                    ),
                  );
                }

                if (products.isEmpty) {
                  return Container(
                    height: height(context) * 0.8,
                    child: CustomEmptyData(
                      height: height(context) * 0.9,
                      text: 'Data tidak ditemukan',
                      onPressed: () async {
                        conProduct.isLoading.value = true;
                        conProduct.getProduct(1);
                      },
                    ),
                  );
                }

                return Container(
                  height: height(context) * 0.8,
                  child: CustomRefresh(
                    controller: _refreshController,
                    onRefresh: () => _onRefresh(),
                    onLoading: () => _onLoading(),
                    child: ListView(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      children: [
                        ...products.map((e) => _itemProductList(context, e)),
                      ],
                    ),
                  ),
                );
              }),
            ),
          ],
        ),
      ],
    );
  }

  Widget _itemProductList(BuildContext context, ProductModel item) {
    final cart = conCart.listCart.firstWhere(
      (element) => element.id == item.id,
      orElse: () => CartDBModel.fromMap({'_id': 0}),
    );

    return InkWell(
      onTap: cart.id == 0
          ? () {
              setState(() {
                _formName.text = item.name ?? '';
                _formPrice.text = item.price ?? '';
                _formQty.text = 1.toString();

                _productFrom = item;
              });

              _openModal(context);
            }
          : () {},
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.symmetric(horizontal: 6, vertical: 6),
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey.shade300, width: 2),
        ),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.name ?? '-',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black45,
                    fontWeight: FontWeight.w400,
                    height: 1,
                  ),
                ),
                if (item.description != null) SizedBox(height: 4),
                if (item.description != null)
                  Text(
                    item.description ?? '-',
                    overflow: TextOverflow.clip,
                    maxLines: 2,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.black45,
                      fontWeight: FontWeight.w400,
                      height: 1,
                    ),
                  ),
                SizedBox(height: 8),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        toRupiah(double.parse(item.price ?? "0")),
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                          height: 1.2,
                        ),
                      ),
                      Text(
                        item.unit ?? '-',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black45,
                          fontWeight: FontWeight.w400,
                          height: 1.2,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Positioned(
              right: 0,
              child: cart.id == 0
                  ? Container()
                  : Text(
                      'In Cart',
                      style: TextStyle(
                        fontSize: 12,
                        color: primaryColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  _openModal(BuildContext context) {
    Modals.showCupertinoModal(
      context: context,
      isDraggable: true,
      builder: Container(
        width: width(context),
        height: height(context) * 0.34,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(30),
          ),
        ),
        child: Column(
          children: [
            SizedBox(height: 10),
            Container(
              height: 4,
              width: 120,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            SizedBox(height: 10),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  SizedBox(height: height(context) * 0.01),
                  CustomTextField(
                    controller: _formName,
                    hintText: "Nama Barang",
                    padding: EdgeInsets.zero,
                    prefixIcon: Icon(
                      Icons.format_list_bulleted,
                      color: Colors.blue,
                      size: 22,
                    ),
                    readOnly: true,
                  ),
                  SizedBox(height: height(context) * 0.01),
                  CustomTextField(
                    controller: _formPrice,
                    hintText: "Uang Harga",
                    padding: EdgeInsets.zero,
                    prefixIcon: Icon(
                      Icons.attach_money_sharp,
                      color: primaryColor,
                      size: 22,
                    ),
                    keyboardType: TextInputType.number,
                  ),
                  SizedBox(height: height(context) * 0.01),
                  CustomTextField(
                    controller: _formQty,
                    hintText: "Banyak",
                    padding: EdgeInsets.zero,
                    prefixIcon: Icon(
                      Icons.shopping_bag,
                      color: secondaryColor,
                      size: 22,
                    ),
                    keyboardType: TextInputType.number,
                  ),
                  SizedBox(height: height(context) * 0.02),
                  // button ok
                  Container(
                    width: width(context),
                    height: height(context) * 0.05,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: secondaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () {
                        conCart.addCart(
                          CartDBModel.fromMap({
                            '_id': _productFrom!.id,
                            'name': _productFrom!.name,
                            'unit': _productFrom!.unit,
                            'price': int.parse(_formPrice.text),
                            'qty': int.parse(_formQty.text),
                          }),
                        );

                        setState(() {
                          _formName.clear();
                          _formPrice.clear();
                          _formQty.clear();
                        });
                        Navigator.pop(context);
                      },
                      child: Text(
                        "Masukkan Keranjang",
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
