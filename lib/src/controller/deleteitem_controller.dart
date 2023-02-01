import 'package:get/get.dart';
import 'package:kasir_app/src/repository/api_product.dart';

class DeleteItemController extends GetxController {
  final api = ApiProduct();
  RxBool isLoading = true.obs;
  Future<void> hapusProduk(int id) async {
    isLoading.value = true;
    final response = await api.deleteItem(id: id);
    if (response != null) {
      isLoading.value = false;
    } else {
      isLoading.value = false;
    }
  }
}
