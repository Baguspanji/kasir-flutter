import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kasir_app/src/config/constans_config.dart';
import 'package:kasir_app/src/config/size_config.dart';
import 'package:kasir_app/src/controller/deleteitem_controller.dart';
import 'package:kasir_app/src/controller/product_controller.dart';
import 'package:kasir_app/src/model/product_model.dart';
import 'package:kasir_app/src/model/widget_model.dart';
import 'package:kasir_app/src/ui/components/custom_components.dart';
import 'package:kasir_app/src/ui/profile/editbarang.dart';
import 'package:kasir_app/src/ui/profile/tambahbarang.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ListBarang extends StatefulWidget {
  static const routeName = '/profile/barang';
  // const ListBarang({super.key});

  @override
  State<ListBarang> createState() => _ListBarangState();
}

class _ListBarangState extends State<ListBarang> {
  final conProduct = Get.put(ProductController());
  DeleteItemController deleteItem = Get.put(DeleteItemController());
  final _refreshController = RefreshController(initialRefresh: false);
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
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      conProduct.getProduct(1);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        centerTitle: true,
        title: Text(
          "List Barang",
          style: TextStyle(
            fontSize: 20,
            color: Colors.black87,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Container(
        child: Column(
          children: [
            SizedBox(height: height(context) * 0.02),
            Column(
              children: [
                Obx(() {
                  final products = conProduct.listProduct.value;

                  if (conProduct.isLoading.value) {
                    return Container(
                      height: height(context) * 0.82,
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
                      height: height(context) * 0.82,
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

                  return AnimatedContainer(
                    height: height(context) * 0.82,
                    duration: const Duration(seconds: 1),
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
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 20,
                right: 20,
              ),
              child: InkWell(
                onTap: () => Get.toNamed(TambahBarang.routeName),
                child: Container(
                    width: width(context),
                    height: height(context) * 0.050,
                    decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(17)),
                    child: const Center(
                        child: Text(
                      'Tambah',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        // fontWeight: FontWeight.w600,
                      ),
                    ))),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _itemProductList(BuildContext context, ProductModel item) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 6, vertical: 6),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
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
      child: Row(
        children: [
          // CustomImageNetwork(
          //   item.image ?? '',
          //   width: width(context) * 0.2,
          //   height: width(context) * 0.2,
          // ),
          // SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.name ?? '-',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black45,
                    fontWeight: FontWeight.w600,
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
                SizedBox(height: 4),
                Text(
                  item.unit ?? '-',
                  style: TextStyle(
                    fontSize: 10,
                    color: Colors.black45,
                    fontWeight: FontWeight.w400,
                    height: 1.2,
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  toRupiah(double.parse(item.price ?? "0")),
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
          SizedBox(width: 10),
          InkWell(
            onTap: () => Get.toNamed(EditBarang.routeName, arguments: [
              item.id,
              item.code1,
              item.code2 ?? "",
              item.code3 ?? "",
              item.code4 ?? "",
              item.code5 ?? "",
              item.code6 ?? "",
              item.code7 ?? "",
              item.code8 ?? "",
              item.code9 ?? "",
              item.code10 ?? "",
              item.name,
              item.unit,
              item.takePrice,
              item.price
            ]),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.amber.shade300),
              child: const Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  Icons.edit,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          InkWell(
            onTap: () {
              setState(() {
                deleteItem.hapusProduk(item.id!);
                _onRefresh();
                print(item.id);
              });
            },
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15), color: Colors.red),
              child: const Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  Icons.delete,
                  color: Colors.white,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
