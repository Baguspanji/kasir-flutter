import 'package:get/get.dart';
import 'package:kasir_app/src/model/product_model.dart';
import 'package:kasir_app/src/repository/api_product.dart';
import 'package:kasir_app/src/ui/profile/barang.dart';

class ProductController extends GetxController {
  final api = ApiProduct();

  final listProduct = <ProductModel>[].obs;
  RxBool isLoading = true.obs;

  RxInt productPage = 1.obs;
  RxString search = ''.obs;

  Future<void> getProduct(int page) async {
    try {
      // isLoading.value = true;
      var res = await api.getProduct(page: page, search: search.value);

      if (page == 1) {
        productPage.value = 1;
        listProduct.value = res.statusCode == 200
            ? [
                ...(res.body['data']['data'] as List)
                    .map((e) => ProductModel.fromJson(e))
              ]
            : [];
      } else {
        productPage.value =
            res.body['data']['pagination']['current_page'] as int;

        listProduct.value = res.statusCode == 200
            ? [
                ...listProduct.value,
                ...(res.body['data']['data'] as List)
                    .map((e) => ProductModel.fromJson(e))
              ]
            : listProduct.value;
      }
    } finally {
      isLoading.value = false;
    }
  }

  Future<bool> addItem(String code, String name, String unit, String takeprice,
      String price) async {
    try {
      final res = await api.addItem(data: {
        "code_1": code,
        "name": name,
        "unit": unit,
        "take_price": takeprice,
        "price": price
      });
      if (res.body != null) {
        Get.toNamed(ListBarang.routeName);
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e.toString());
      return false;
    }
  }
}
