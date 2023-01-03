import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kasir_app/src/config/constans_config.dart';
import 'package:kasir_app/src/config/size_config.dart';
import 'package:kasir_app/src/controller/cart_controller.dart';
import 'package:kasir_app/src/controller/product_controller.dart';
import 'package:kasir_app/src/model/product_model.dart';
import 'package:kasir_app/src/model/widget_model.dart';
import 'package:kasir_app/src/repository/s_preference.dart';
import 'package:kasir_app/src/ui/components/custom_components.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HomeUI extends StatefulWidget {
  @override
  State<HomeUI> createState() => _HomeUIState();
}

class _HomeUIState extends State<HomeUI> {
  final conProduct = Get.put(ProductController());
  final conCart = Get.find<CartController>();

  bool _isGridView = true;
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
    getStyleHome().then((value) {
      if (value != null) {
        setState(() {
          _isGridView = value;
        });
      }
    });
    conProduct.getProduct(1);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          SizedBox(height: height(context) * 0.01),
          Container(
            width: width(context),
            height: height(context) * 0.04,
            margin: EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Daftar Produk',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black87,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                InkWell(
                  onTap: () async {
                    setState(() {
                      _isGridView = !_isGridView;
                      setStyleHome(_isGridView);
                    });
                  },
                  child: Icon(
                    _isGridView ? Icons.grid_view : Icons.list,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: height(context) * 0.02),
          Container(
            height: height(context) * 0.8,
            child: Obx(() {
              final products = conProduct.listProduct.value;

              if (conProduct.isLoading.value) {
                if (_isGridView) {
                  return GridView(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 5,
                      mainAxisSpacing: 10,
                      childAspectRatio: 0.8,
                    ),
                    children: [
                      for (var i = 0; i < 8; i++)
                        CustomShimmer(
                          width: width(context) * 0.4,
                          height: width(context) * 0.4,
                          radius: 10,
                        )
                    ],
                  );
                } else {
                  return ListView(
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
                  );
                }
              }

              if (products.isEmpty) {
                return CustomEmptyData(
                  height: height(context) * 0.9,
                  text: 'Data tidak ditemukan',
                  onPressed: () async {
                    conProduct.isLoading.value = true;
                    conProduct.getProduct(1);
                  },
                );
              }

              if (_isGridView) {
                return SmartRefresher(
                  controller: _refreshController,
                  enablePullDown: true,
                  enablePullUp: true,
                  onRefresh: () => _onRefresh(),
                  onLoading: () => _onLoading(),
                  child: GridView(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 5,
                      mainAxisSpacing: 10,
                      childAspectRatio: 0.7,
                    ),
                    children: [
                      ...products.map((e) => _itemProductGrid(context, e)),
                    ],
                  ),
                );
              } else {
                return SmartRefresher(
                  controller: _refreshController,
                  enablePullDown: true,
                  enablePullUp: true,
                  onRefresh: () => _onRefresh(),
                  onLoading: () => _onLoading(),
                  child: ListView(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    children: [
                      ...products.map((e) => _itemProductList(context, e)),
                    ],
                  ),
                );
              }
            }),
          ),
        ],
      ),
    );
  }

  Widget _itemProductGrid(BuildContext context, ProductModel item) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 6),
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
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomImageNetwork(
                item.image ?? '',
                width: double.infinity,
                height: width(context) * 0.4,
              ),
              SizedBox(height: 6),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.code ?? '-',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.black45,
                        fontWeight: FontWeight.w500,
                        height: 1.2,
                      ),
                    ),
                    Text(
                      item.name ?? '-',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black45,
                        fontWeight: FontWeight.w600,
                        height: 1.2,
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
            ],
          ),
          Positioned(
            bottom: 10,
            right: 10,
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.black12),
              ),
              child: IconButton(
                padding: EdgeInsets.zero,
                icon: Icon(
                  Icons.add,
                  size: 30,
                  color: Colors.black45,
                ),
                onPressed: () => conCart.addCart(CartModel(
                  item.id!,
                  int.parse(item.price!),
                  1,
                  item,
                )),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _itemProductList(BuildContext context, ProductModel item) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 6, vertical: 6),
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
          CustomImageNetwork(
            item.image ?? '',
            width: width(context) * 0.2,
            height: width(context) * 0.2,
          ),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.code ?? '-',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.black45,
                    fontWeight: FontWeight.w500,
                    height: 1.2,
                  ),
                ),
                Text(
                  item.name ?? '-',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black45,
                    fontWeight: FontWeight.w600,
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
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.black12),
            ),
            child: IconButton(
              padding: EdgeInsets.zero,
              icon: Icon(
                Icons.add,
                size: 30,
                color: Colors.black45,
              ),
              onPressed: () => conCart.addCart(CartModel(
                item.id!,
                int.parse(item.price!),
                1,
                item,
              )),
            ),
          ),
          SizedBox(width: 10),
        ],
      ),
    );
  }
}
