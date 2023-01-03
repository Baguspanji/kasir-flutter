import 'package:get/get.dart';
import 'package:kasir_app/src/model/transaksi_model.dart';
import 'package:kasir_app/src/repository/api_transaksi.dart';

class TransaksiController extends GetxController {
  final api = ApiTransaksi();

  final listTransaksi = <TransaksiModel>[].obs;
  RxBool isLoading = true.obs;
  RxInt transaksiPage = 1.obs;

  Future<void> getTransaksi(int page) async {
    try {
      // isLoading.value = true;
      var res = await api.getTransaksi(page: page);

      if (page == 1) {
        transaksiPage.value = 1;
        listTransaksi.value = res.statusCode == 200
            ? [
                ...(res.body['data']['data'] as List)
                    .map((e) => TransaksiModel.fromJson(e))
              ]
            : [];
      } else {
        transaksiPage.value =
            res.body['data']['pagination']['current_page'] as int;

        listTransaksi.value = res.statusCode == 200
            ? [
                ...listTransaksi.value,
                ...(res.body['data']['data'] as List)
                    .map((e) => TransaksiModel.fromJson(e))
              ]
            : listTransaksi.value;
      }
    } finally {
      isLoading.value = false;
    }
  }
}
