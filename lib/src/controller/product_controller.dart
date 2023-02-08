import 'package:get/get.dart';
import 'package:kasir_app/src/model/product_model.dart';
import 'package:kasir_app/src/repository/api_product.dart';

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

  Future<bool> addItem(
    String code1,
    String code2,
    String code3,
    String code4,
    String code5,
    String code6,
    String code7,
    String code8,
    String code9,
    String code10,
    String name,
    String deskripsi,
    String perUnit,
    String unit,
    String takeprice,
    String price,
  ) async {
    try {
      final res = await api.addItem(
        data: {
          "code_1": code1,
          "code_2": code2,
          "code_3": code3,
          "code_4": code4,
          "code_5": code5,
          "code_6": code6,
          "code_7": code7,
          "code_8": code8,
          "code_9": code9,
          "code_10": code10,
          "name": name,
          "description": deskripsi,
          "unit": unit,
          "per_unit": perUnit,
          "take_price": takeprice,
          "price": price,
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

  Future<bool> editItem(
    int id,
    String code1,
    String code2,
    String code3,
    String code4,
    String code5,
    String code6,
    String code7,
    String code8,
    String code9,
    String code10,
    String name,
    String deskripsi,
    String perUnit,
    String unit,
    String takeprice,
    String price,
  ) async {
    try {
      final res = await api.editItem(
        id,
        data: {
          "code_1": code1,
          "code_2": code2,
          "code_3": code3,
          "code_4": code4,
          "code_5": code5,
          "code_6": code6,
          "code_7": code7,
          "code_8": code8,
          "code_9": code9,
          "code_10": code10,
          "name": name,
          "description": deskripsi,
          "unit": unit,
          "per_unit": perUnit,
          "take_price": takeprice,
          "price": price,
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
}
