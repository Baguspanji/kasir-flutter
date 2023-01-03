import 'package:get/route_manager.dart';
import 'package:kasir_app/src/ui/auth/index.dart';
import 'package:kasir_app/src/ui/cart/index.dart';
import 'package:kasir_app/src/ui/nav_ui.dart';
import 'package:kasir_app/src/ui/splash/index.dart';

// We use name route
// All our routes will be available here

final List<GetPage<dynamic>>? routes = [
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
    name: CartUI.routeName,
    page: () => CartUI(),
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
