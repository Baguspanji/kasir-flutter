import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:kasir_app/src/config/constans_assets.dart';
import 'package:kasir_app/src/config/constans_config.dart';
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

  DateTime currentBackPressTime = DateTime.now();

  Future<bool> onWillPop() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      getToast('Tekan sekali lagi untuk keluar');
      return Future.value(false);
    }
    return Future.value(true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: WillPopScope(
        onWillPop: onWillPop,
        child: Stack(
          children: [
            TabBarView(
              controller: _tabController,
              children: [
                HomeUI(),
                TransaksiUI(),
                IncomeUI(),
                ProfileUI(),
              ],
            ),
            if (indexNav == 0)
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Obx(
                  () => AnimatedContainer(
                    duration: const Duration(seconds: 1),
                    height: conCart.totalCart != 0 ? 400 : 0,
                    width: width(context),
                    curve: Curves.fastOutSlowIn,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 1,
                          blurRadius: 5,
                          offset: Offset(0, 0), // changes position of shadow
                        ),
                      ],
                    ),
                    child: conCart.totalCart != 0 ? CartUI() : null,
                  ),
                ),
              ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          for (var i = 0; i < listNav.length; i++)
            _navItem(
              context,
              listNav[i],
              isActive: indexNav == i,
            ),
        ],
        currentIndex: indexNav,
        selectedItemColor: Colors.grey[800],
        unselectedItemColor: Colors.grey[400],
        showUnselectedLabels: true,
        onTap: (index) {
          setState(() {
            indexNav = index;
            _tabController.animateTo(index);
          });
        },
      ),
      // floatingActionButton: indexNav == 0
      //     ? Obx(() => conCart.totalCart != 0
      //         ? FloatingActionButton(
      //             onPressed: () {
      //               Get.toNamed(CartUI.routeName);
      //             },
      //             backgroundColor: Colors.grey,
      //             child: Stack(
      //               children: [
      //                 Icon(
      //                   Icons.shopping_cart,
      //                   color: Colors.white,
      //                 ),
      //                 if (conCart.totalCart > 0)
      //                   Positioned(
      //                     right: 0,
      //                     child: Container(
      //                       padding: EdgeInsets.all(1),
      //                       decoration: BoxDecoration(
      //                         color: Colors.red,
      //                         borderRadius: BorderRadius.circular(6),
      //                       ),
      //                       constraints: BoxConstraints(
      //                         minWidth: 12,
      //                         minHeight: 12,
      //                       ),
      //                       child: Text(
      //                         '${conCart.totalCart}',
      //                         style: TextStyle(
      //                           color: Colors.white,
      //                           fontSize: 8,
      //                         ),
      //                         textAlign: TextAlign.center,
      //                       ),
      //                     ),
      //                   ),
      //               ],
      //             ),
      //           )
      //         : Container())
      //     : null,
    );
  }

  BottomNavigationBarItem _navItem(BuildContext context, NavModel svg,
      {bool isActive = false}) {
    return BottomNavigationBarItem(
      icon: Container(
        margin: EdgeInsets.only(top: 4),
        child: Visibility(
          visible: isActive,
          replacement: SvgPicture.asset(svg.svgVisible, color: Colors.black45),
          child: SvgPicture.asset(svg.svgInvisible, color: Colors.black87),
        ),
      ),
      label: svg.title,
    );
  }
}
