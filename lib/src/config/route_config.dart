import 'package:get/route_manager.dart';
import 'package:kasir_app/src/model/transaksi_model.dart';
import 'package:kasir_app/src/ui/auth/index.dart';
import 'package:kasir_app/src/ui/cart/detail.dart';
import 'package:kasir_app/src/ui/cart/index.dart';
import 'package:kasir_app/src/ui/nav_ui.dart';
import 'package:kasir_app/src/ui/profile/barang/index.dart';
import 'package:kasir_app/src/ui/profile/barang/edit.dart';
import 'package:kasir_app/src/ui/profile/change_password.dart';
import 'package:kasir_app/src/ui/profile/print_setting.dart';
import 'package:kasir_app/src/ui/profile/barang/tambah.dart';
import 'package:kasir_app/src/ui/splash/index.dart';
import 'package:kasir_app/src/ui/transaksi/detail.dart';

// We use name route
// All our routes will be available here

final List<GetPage<dynamic>> routes = [
  GetPage(
    name: SplashUI.routeName,
    page: () => SplashUI(),
  ),
  GetPage(
    name: NavUI.routeName,
    page: () => NavUI(),
  ),
  GetPage(
    name: AuthUI.routeName,
    page: () => AuthUI(),
  ),
  GetPage(
    name: TransaksiDetailUI.routeName,
    page: () => TransaksiDetailUI(),
    arguments: CommonArgument<TransaksiModel>,
  ),
  GetPage(
    name: PrintSettingUI.routeName,
    page: () => PrintSettingUI(),
  ),
  GetPage(
    name: CartUI.routeName,
    page: () => CartUI(),
  ),
  GetPage(
    name: CartDetailUI.routeName,
    page: () => CartDetailUI(),
  ),
  GetPage(name: ListBarang.routeName, page: () => ListBarang()),
  GetPage(name: TambahBarang.routeName, page: () => TambahBarang()),
  GetPage(name: EditBarang.routeName, page: () => EditBarang()),
  GetPage(
    name: ChangePasswordUI.routeName,
    page: () => ChangePasswordUI(),
  ),
  // GetPage(
  //   name: TentangUI.routeName,
  //   page: () => TentangUI(),
  // ),
];

class CommonArgument<T> {
  final T? object;
  final int? id;

  const CommonArgument({this.object, this.id});
}
