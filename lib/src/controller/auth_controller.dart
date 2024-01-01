import 'package:get/get.dart';
import 'package:kasir_app/src/model/user_model.dart';
import 'package:kasir_app/src/repository/api_auth.dart';
import 'package:kasir_app/src/repository/s_preference.dart';
import 'package:kasir_app/src/ui/splash/index.dart';

class AuthController extends GetxController {
  final api = ApiAuth();

  final user = UserModel().obs;

  Future<bool> login(String username, String password) async {
    try {
      final res =
          await api.login(data: {"username": username, "password": password});
      print(res.body);
      if (res.body['access_token'] != null) {
        setToken('Bearer ${res.body['access_token']}');
        setRole(res.body['role']);
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  Future<bool> changePassword(
    String oldPassword,
    String newPassword,
    String newPasswordType,
  ) async {
    try {
      final res = await api.changePassword(
        data: {
          "old_password": oldPassword,
          "new_password": newPassword,
          "confirm_password": newPasswordType,
        },
      );
      if (res.body != null) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  Future<void> logout() async {
    await rmvToken();
    await rmvRole();
    await rmvStyleHome();
    await rmvUser();
    Get.offAndToNamed(SplashUI.routeName);
  }

  Future<void> getUser() async {
    try {
      final res = await api.getUser();
      if (res.statusCode == 200) {
        user.value = UserModel.fromJson(res.body['data']);
        await setUser(res.bodyString!);
      }
    } on Exception catch (e) {
      print(e.toString());
    }
  }
}
