import 'package:get/get.dart';
import 'package:kasir_app/src/model/product_model.dart';
import 'package:kasir_app/src/repository/api_product.dart';

class ProductController extends GetxController {
  final api = ApiProduct();

  final listProduct = <ProductModel>[].obs;
  RxBool isLoading = false.obs;

  RxInt productPage = 1.obs;

  Future<void> getProduct(int page) async {
    try {
      // isLoading.value = true;
      var res = await api.getProduct(page: page);

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
}
