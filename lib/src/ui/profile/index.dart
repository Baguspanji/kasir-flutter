import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kasir_app/src/config/constans_assets.dart';
import 'package:kasir_app/src/config/constans_config.dart';
import 'package:kasir_app/src/config/size_config.dart';
import 'package:kasir_app/src/controller/auth_controller.dart';
import 'package:kasir_app/src/ui/profile/barang.dart';
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
              return ListTile(
                leading: Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: NetworkImage(
                        'https://www.gstatic.com/webp/gallery/1.sm.jpg',
                      ),
                      fit: BoxFit.cover,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 6,
                        offset: Offset(0, 3),
                      )
                    ],
                  ),
                ),
                title: Text('kasir demo'),
                subtitle: Text('kasir demo'),
              );
            } else {
              return ListTile(
                leading: Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: NetworkImage(
                        'https://www.gstatic.com/webp/gallery/1.sm.jpg',
                      ),
                      fit: BoxFit.cover,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 6,
                        offset: Offset(0, 3),
                      )
                    ],
                  ),
                ),
                title: Text(user.name ?? ''),
                subtitle: Text(user.app != null ? user.app!.name! : ''),
              );
            }
          }),
        ),
        Expanded(
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            children: [
              _itemProfile(
                icon: Icons.person,
                title: 'Profil',
                onTap: () {},
              ),
              _itemProfile(
                icon: Icons.lock,
                title: 'Ganti Password',
                onTap: () {},
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
              _itemProfile(
                  icon: Icons.add_business,
                  title: 'Barang',
                  onTap: () => Get.toNamed(ListBarang.routeName))
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
