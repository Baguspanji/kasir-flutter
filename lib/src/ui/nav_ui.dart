import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:kasir_app/src/config/constans_assets.dart';
import 'package:kasir_app/src/config/size_config.dart';
import 'package:kasir_app/src/controller/auth_controller.dart';
import 'package:kasir_app/src/controller/cart_controller.dart';
import 'package:kasir_app/src/model/widget_model.dart';
import 'package:kasir_app/src/ui/cart/index.dart';
import 'package:kasir_app/src/ui/home/index.dart';
import 'package:kasir_app/src/ui/income/index.dart';
import 'package:kasir_app/src/ui/profile/index.dart';
import 'package:kasir_app/src/ui/transaksi/index.dart';

class NavUI extends StatefulWidget {
  static const String routeName = "/nav";

  @override
  State<NavUI> createState() => _NavUIState();
}

class _NavUIState extends State<NavUI> with SingleTickerProviderStateMixin {
  final conAuth = Get.put(AuthController());
  final conCart = Get.put(CartController());

  int indexNav = 0;
  late TabController _tabController;

  List<NavModel> listNav = [
    NavModel(iconHomeOutline, iconHome, "Produk"),
    NavModel(iconCategory, iconCategory, "Transaksi"),
    NavModel(iconArchive, iconArchive, "Pendapatan"),
    NavModel(iconProfileOutline, iconProfile, "Profile"),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _tabController.addListener(() {
      setState(() {
        indexNav = _tabController.index;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TabBarView(
        controller: _tabController,
        children: [
          HomeUI(),
          TransaksiUI(),
          IncomeUI(),
          ProfileUI(),
        ],
      ),
      bottomNavigationBar: Container(
        height: height(context) * 0.09,
        width: width(context),
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            for (var i = 0; i < listNav.length; i++)
              _navItem(
                context,
                listNav[i],
                isActive: indexNav == i,
              ),
          ],
        ),
      ),
      floatingActionButton: indexNav == 0
          ? FloatingActionButton(
              onPressed: () {
                Get.toNamed(CartUI.routeName);
              },
              backgroundColor: Colors.grey,
              child: Obx(
                () => Stack(
                  children: [
                    Icon(
                      Icons.shopping_cart,
                      color: Colors.white,
                    ),
                    if (conCart.totalCart > 0)
                      Positioned(
                        right: 0,
                        child: Container(
                          padding: EdgeInsets.all(1),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          constraints: BoxConstraints(
                            minWidth: 12,
                            minHeight: 12,
                          ),
                          child: Text(
                            '${conCart.totalCart}',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 8,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            )
          : null,
    );
  }

  Widget _navItem(BuildContext context, NavModel svg, {bool isActive = false}) {
    return GestureDetector(
      onTap: () {
        int index = listNav.indexOf(svg);
        if (index != 0) {
          setState(() {
            indexNav = index;
            _tabController.animateTo(index);
          });
        } else {
          setState(() {
            indexNav = index;
            _tabController.animateTo(index);
          });
        }
      },
      child: Container(
        width: width(context) / 4,
        height: width(context) / 4,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Visibility(
              visible: isActive,
              replacement:
                  SvgPicture.asset(svg.svgVisible, color: Colors.black45),
              child: SvgPicture.asset(svg.svgInvisible, color: Colors.black87),
            ),
            Container(
              margin: EdgeInsets.only(top: 4),
              child: Text(
                svg.title,
                style: TextStyle(
                  fontSize: 10,
                  color: isActive ? Colors.black87 : Colors.black45,
                  fontWeight: isActive ? FontWeight.w500 : FontWeight.w400,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
