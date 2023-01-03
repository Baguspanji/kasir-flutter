import 'package:get/get.dart';
import 'package:kasir_app/src/model/income_model.dart';
import 'package:kasir_app/src/repository/api_income.dart';

class IncomeController extends GetxController {
  final api = ApiIncome();

  final listIncome = <IncomeModel>[].obs;
  RxBool isLoading = true.obs;
  RxInt incomePage = 1.obs;

  Future<void> getTransaksi(int page) async {
    try {
      // isLoading.value = true;
      var res = await api.getIncome(page: page);

      if (page == 1) {
        incomePage.value = 1;
        listIncome.value = res.statusCode == 200
            ? [
                ...(res.body['data']['data'] as List)
                    .map((e) => IncomeModel.fromJson(e))
              ]
            : [];
      } else {
        incomePage.value =
            res.body['data']['pagination']['current_page'] as int;

        listIncome.value = res.statusCode == 200
            ? [
                ...listIncome.value,
                ...(res.body['data']['data'] as List)
                    .map((e) => IncomeModel.fromJson(e))
              ]
            : listIncome.value;
      }
    } finally {
      isLoading.value = false;
    }
  }
}
