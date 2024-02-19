import 'package:cached_network_image/cached_network_image.dart';
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
    return Stack(
      children: [
        Container(
          width: width(context),
          height: height(context),
          color: Colors.white,
        ),
        Container(
          width: width(context),
          height: height(context) * 0.15,
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
                  Row(
                    children: [
                      Container(
                        width: 30,
                        height: 30,
                        child: Image(
                          image: AssetImage(logo),
                        ),
                      ),
                      SizedBox(width: 10),
                      Container(
                        child: Text(
                          'Kasir JJ',
                          style: TextStyle(
                            fontSize: 28,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      color: Color(0xCEFFFFFF),
                    ),
                    child: Icon(
                      Icons.notifications,
                      color: secondaryColor,
                      size: 24,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Obx(() {
              var user = conAuth.user.value;

              if (isLoading) {
                return Container(
                  width: width(context),
                  height: height(context) * 0.1,
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    color: secondaryColor,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      width: 2,
                      color: Colors.white60,
                    ),
                  ),
                  child: Center(
                    child: CircularProgressIndicator(color: Colors.white),
                  ),
                );
              }

              if (user.name == null) {
                return Container(
                  width: width(context),
                  height: height(context) * 0.1,
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  decoration: BoxDecoration(
                    color: secondaryColor,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      width: 2,
                      color: Colors.white60,
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Kasir JJ',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              height: 1,
                            ),
                          ),
                          SizedBox(height: 6),
                          Text(
                            'Kasir JJ',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.w400,
                              height: 1,
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                );
              }

              return Container(
                width: width(context),
                height: height(context) * 0.1,
                margin: EdgeInsets.symmetric(horizontal: 20),
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                decoration: BoxDecoration(
                  color: secondaryColor,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    width: 2,
                    color: Colors.white60,
                  ),
                ),
                child: Row(
                  children: [
                    CachedNetworkImage(
                      imageUrl: "https://source.unsplash.com/random",
                      imageBuilder: (context, imageProvider) {
                        return Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.cover,
                              colorFilter: ColorFilter.mode(
                                Colors.white,
                                BlendMode.colorBurn,
                              ),
                            ),
                          ),
                        );
                      },
                      placeholder: (context, url) {
                        return Container(
                          width: 60,
                          height: 60,
                          padding: EdgeInsets.all(4),
                          child: CircularProgressIndicator(
                            color: secondaryColor,
                          ),
                        );
                      },
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ),
                    SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          user.name ?? '',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            height: 1,
                          ),
                        ),
                        SizedBox(height: 6),
                        Text(
                          user.app != null ? user.app!.name! : '',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
                            height: 1,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              );
            }),
            SizedBox(height: 20),
            Expanded(
              child: ListView(
                padding: EdgeInsets.symmetric(horizontal: 20),
                children: [
                  _itemProfile(
                    icon: Icons.lock,
                    title: 'Ganti Password',
                    onTap: () => Get.toNamed(ChangePasswordUI.routeName),
                  ),
                  _itemProfile(
                    icon: Icons.add_box,
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
                      border: Border.all(color: secondaryColor),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      'Keluar',
                      style: TextStyle(
                        fontSize: 16,
                        color: secondaryColor,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ],
    );
  }

  Widget _itemProfile({
    required IconData icon,
    required String title,
    required void Function()? onTap,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      padding: EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.shade300, width: 2),
      ),
      child: ListTile(
        horizontalTitleGap: 8,
        leading: Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: Color.fromARGB(155, 245, 207, 150),
          ),
          child: Icon(
            icon,
            color: secondaryColor,
            size: 18,
          ),
        ),
        title: Text(
          title,
          style: TextStyle(
            fontSize: 18,
            color: Color.fromARGB(208, 26, 26, 26),
            fontWeight: FontWeight.w600,
          ),
        ),
        trailing: Icon(
          Icons.arrow_forward_ios,
          size: 18,
        ),
        onTap: onTap,
      ),
    );
  }
}
