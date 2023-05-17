import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kasir_app/src/config/constans_assets.dart';
import 'package:kasir_app/src/config/constans_config.dart';
import 'package:kasir_app/src/config/size_config.dart';
import 'package:kasir_app/src/controller/auth_controller.dart';
import 'package:kasir_app/src/ui/profile/barang/index.dart';
import 'package:kasir_app/src/ui/profile/change_password.dart';
import 'package:kasir_app/src/ui/profile/print_setting.dart';

class ProfileUI extends StatefulWidget {
  @override
  State<ProfileUI> createState() => _ProfileUIState();
}

class _ProfileUIState extends State<ProfileUI> {
  final conAuth = Get.find<AuthController>();
  bool isLoading = false;

  @override
  void initState() {
    getUser();
    super.initState();
  }

  void getUser() async {
    setState((() => isLoading = true));
    conAuth.getUser();
    setState((() => isLoading = false));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: height(context) * 0.05),
        Container(
          width: width(context),
          height: height(context) * 0.1,
          alignment: Alignment.center,
          child: Obx(() {
            var user = conAuth.user.value;

            if (isLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            if (user.name == null) {
              return Container(
                width: width(context),
                height: height(context) * 0.1,
                margin: EdgeInsets.symmetric(horizontal: 30),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 5,
                      offset: Offset(0, 5),
                    )
                  ],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Nama Pengguna',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      'Toko',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return Container(
                width: width(context),
                height: height(context) * 0.1,
                margin: EdgeInsets.symmetric(horizontal: 30),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 5,
                      offset: Offset(0, 5),
                    )
                  ],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      user.name ?? '',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      user.app != null ? user.app!.name! : '',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              );
            }
          }),
        ),
        Expanded(
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            children: [
              // _itemProfile(
              //   icon: Icons.person,
              //   title: 'Profil',
              //   onTap: () {},
              // ),
              _itemProfile(
                icon: Icons.lock,
                title: 'Ganti Password',
                onTap: () => Get.toNamed(ChangePasswordUI.routeName),
              ),
              _itemProfile(
                icon: Icons.add_business,
                title: 'Produk Toko',
                onTap: () => Get.toNamed(ListBarang.routeName),
              ),
              _itemProfile(
                icon: Icons.settings,
                title: 'Pengaturan Printer',
                onTap: () => Get.toNamed(PrintSettingUI.routeName),
              ),
              _itemProfile(
                icon: Icons.info,
                title: 'Tentang',
                onTap: () {},
              ),
            ],
          ),
        ),
        Column(
          children: [
            Text('version 1.2.0'),
            GestureDetector(
              onTap: () => conAuth.logout(),
              child: Container(
                margin: EdgeInsets.all(20),
                width: width(context),
                height: height(context) * 0.05,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  border: Border.all(color: redColor),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  'Keluar',
                  style: TextStyle(
                    fontSize: 16,
                    color: redColor,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            )
          ],
        )
      ],
    );
  }

  Widget _itemProfile({
    required IconData icon,
    required String title,
    required void Function()? onTap,
  }) {
    return ListTile(
      horizontalTitleGap: 0,
      leading: Icon(
        icon,
        color: Colors.black54,
      ),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 18,
          color: Colors.black54,
          fontWeight: FontWeight.w400,
        ),
      ),
      trailing: Icon(
        Icons.arrow_forward_ios,
        size: 18,
      ),
      onTap: onTap,
    );
  }
}
