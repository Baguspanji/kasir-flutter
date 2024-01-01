import 'dart:io';

import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:kasir_app/src/config/constans_config.dart';
import 'package:kasir_app/src/model/income_model.dart';
import 'package:kasir_app/src/repository/api_income.dart';
import 'package:kasir_app/src/repository/s_preference.dart';
import 'package:open_filex/open_filex.dart';

import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class IncomeController extends GetxController {
  final api = ApiIncome();

  final listIncome = <IncomeModel>[].obs;
  RxBool isLoading = true.obs;
  RxInt incomePage = 1.obs;

  late String _localPath;
  late bool _permissionReady;
  late TargetPlatform? platform;

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

  // export excel
  Future<void> exportExcel(DateTime dateFrom, String selectType) async {
    _permissionReady = await _checkPermission();
    if (_permissionReady) {
      await _prepareSaveDir();
      print("Downloading");

      try {
        await apiExportExcel(
          DateFormat('yyyy-MM-dd').format(dateFrom),
          selectType == 'Harian' ? 'daily' : 'monthly',
        );
      } catch (e) {
        print('e: $e');
        getToast('Gagal mengunduh laporan');
      }
    }
  }

  // init
  init() async {
    if (Platform.isAndroid) {
      platform = TargetPlatform.android;
    } else {
      platform = TargetPlatform.iOS;
    }
  }

  Future<bool> _checkPermission() async {
    if (platform == TargetPlatform.android) {
      final status = await Permission.storage.status;
      if (status != PermissionStatus.granted) {
        final result = await Permission.storage.request();
        if (result == PermissionStatus.granted) {
          return true;
        }
      } else {
        return true;
      }
    } else {
      return true;
    }
    return false;
  }

  Future<void> apiExportExcel(String date, String type) async {
    String token = await getToken();

    var res = await dio.Dio().post(
      '$globalApi/api/transaction-income/export',
      data: {
        'date': date,
        'type': type,
      },
      options: dio.Options(
        responseType: dio.ResponseType.bytes,
        headers: {
          'Authorization': token,
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
      ),
    );

    // print('status: ${res.statusCode}');
    if (type == 'monthly') {
      date = DateFormat('yyyy-MM').format(DateTime.parse(date));
    }

    var bytes = res.data;
    var file = File('$_localPath/kasir-laporan-$date.xlsx');

    if (file.existsSync()) {
      await file.delete();
      print('file deleted');
    }

    await file.writeAsBytes(bytes);

    print('file: ${file.path}');

    Get.showSnackbar(
      GetSnackBar(
        duration: const Duration(seconds: 3),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.black87,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        messageText: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Laporan berhasil diunduh',
              style: TextStyle(
                fontSize: 12,
                color: Colors.white,
                fontWeight: FontWeight.w400,
              ),
            ),
            TextButton(
              onPressed: () async {
                if (file.existsSync()) {
                  OpenFilex.open(file.path);
                } else {
                  getToast('File tidak ditemukan');
                }
              },
              child: Text(
                'Lihat',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.green.shade600,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<String> apiDownloadImage(String url) async {
    _permissionReady = await _checkPermission();
    if (_permissionReady) {
      await _prepareSaveDir();
      print("Downloading");
    } else {
      getToast('Gagal melakukan share');
      return '';
    }

    String token = await getToken();

    var res = await dio.Dio().get(url,
        options: dio.Options(
          responseType: dio.ResponseType.bytes,
          headers: {
            'Authorization': token,
            'Accept': 'application/json',
            'Content-Type': 'application/json',
          },
        ));

    print('status: ${res.statusCode}');

    var bytes = res.data;
    var directory = await getTemporaryDirectory();

    var file = File('${directory.path}/transaksi-struk.jpg');

    if (file.existsSync()) {
      await file.delete();
      print('file deleted');
    }

    await file.writeAsBytes(bytes);

    print('file: ${file.path}');
    return file.path;
  }

  Future<String?> apiGenerateImage(int id) async {
    String token = await getToken();
    print('$globalApi/api/transaction/$id/share');
    var res = await dio.Dio().get('$globalApi/api/transaction/$id/share',
        options: dio.Options(
          headers: {
            'Authorization': token,
            'Accept': 'application/json',
            'Content-Type': 'application/json',
          },
        ));

    print('status: ${res.statusCode}');
    var response = res.data as Map<String, dynamic>;
    print(response['data']);
    return response['data'];
  }

  Future<void> _prepareSaveDir() async {
    _localPath = (await _findLocalPath())!;

    print(_localPath);
    final savedDir = Directory(_localPath);
    bool hasExisted = await savedDir.exists();
    if (!hasExisted) {
      savedDir.create();
    }
  }

  Future<String?> _findLocalPath() async {
    if (platform == TargetPlatform.android) {
      return "/storage/emulated/0/Download";
    } else {
      var directory = await getDownloadsDirectory();
      return directory!.path;
    }
  }
}
