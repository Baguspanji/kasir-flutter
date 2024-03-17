import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:kasir_app/src/config/constans_config.dart';
import 'package:kasir_app/src/config/size_config.dart';
import 'package:kasir_app/src/controller/deleteitem_controller.dart';
import 'package:kasir_app/src/controller/product_controller.dart';
import 'package:kasir_app/src/model/product_model.dart';
import 'package:kasir_app/src/ui/components/custom_components.dart';
import 'package:kasir_app/src/ui/components/modal.dart';
import 'package:kasir_app/src/ui/profile/barang/edit.dart';
import 'package:kasir_app/src/ui/profile/barang/tambah.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ListBarang extends StatefulWidget {
  static const routeName = '/profile/barang';
  // const ListBarang({super.key});

  @override
  State<ListBarang> createState() => _ListBarangState();
}

class _ListBarangState extends State<ListBarang> {
  bool _isSearch = false;
  final _formSearch = TextEditingController();
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
    conProduct.getProduct(1);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
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
                borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(30)),
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
                        onTap: (() => Get.back()),
                        child: Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Color(0xCEFFFFFF),
                          ),
                          child: Icon(
                            Icons.arrow_back_ios_new,
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
                          Get.toNamed(TambahBarang.routeName);
                        },
                        child: Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Color(0xCEFFFFFF),
                          ),
                          child: Icon(
                            Icons.add,
                            color: secondaryColor,
                            size: 24,
                          ),
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
                            ...products
                                .map((e) => _itemProductList(context, e)),
                          ],
                        ),
                      ),
                    );
                  }),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _itemProductList(BuildContext context, ProductModel item) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Slidable(
        key: ValueKey(0),
        endActionPane: ActionPane(
          motion: ScrollMotion(),
          extentRatio: 0.40,
          children: [
            SlidableAction(
              onPressed: (contex) {
                Get.toNamed(
                  EditBarang.routeName,
                  arguments: [
                    item.id,
                    item.code1,
                    item.code2,
                    item.code3,
                    item.code4,
                    item.code5,
                    item.code6,
                    item.code7,
                    item.code8,
                    item.code9,
                    item.code10,
                    item.name,
                    item.description,
                    item.unit,
                    item.takePrice,
                    item.price,
                  ],
                );
              },
              backgroundColor: Colors.amber,
              foregroundColor: Colors.white,
              icon: Icons.edit,
            ),
            SlidableAction(
              borderRadius: BorderRadius.horizontal(
                right: Radius.circular(10),
              ),
              onPressed: (contex) {
                Modals.showModal(
                  title: 'Peringatan',
                  subTitle: 'Apakah anda yakin ingin menghapus data ini?',
                  confirmText: 'Ya',
                  confirmAction: () {
                    deleteItem.hapusProduk(item.id!);
                    _onRefresh();
                  },
                  cancleText: 'Tidak',
                  cancleAction: () => Get.back(),
                );
              },
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
              icon: Icons.delete,
            ),
          ],
        ),
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.horizontal(
              left: Radius.circular(10),
            ),
            border: Border.all(color: Colors.grey.shade300, width: 2),
          ),
          child: Column(
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
        ),
      ),
    );
  }
}
