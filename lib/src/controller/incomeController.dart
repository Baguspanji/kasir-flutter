import 'dart:io';

import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kasir_app/src/config/constans_config.dart';
import 'package:kasir_app/src/model/income_model.dart';
import 'package:kasir_app/src/repository/api_income.dart';
import 'package:kasir_app/src/repository/s_preference.dart';

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
  Future<void> exportExcel() async {
    dynamic data = {"date": "2023-02-17", "type": "daily"};

    _permissionReady = await _checkPermission();
    if (_permissionReady) {
      await _prepareSaveDir();
      print("Downloading");

      try {
        await apiExportExcel(data);
      } catch (e) {
        print('e: $e');
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

  // exportExcel
  Future<void> apiExportExcel(dynamic data) async {
    String token = await getToken();

    // download file using http
    var res = await dio.Dio().post(
      '$globalApi/api/transaction-income/export',
      data: {
        "date": "2023-02-17",
        "type": "daily",
      },
      options: dio.Options(
        responseType: dio.ResponseType.bytes,
        headers: {
          'Authorization': token,
          'Accept': 'application/json',
        },
      ),
    );

    // print('res: ${res.data}');
    print('status: ${res.statusCode}');

    // Uint8List
    var bytes = res.data;

    // save file
    var file = File('$_localPath/kasir-laporan.xlsx');
    await file.writeAsBytes(bytes);

    print('file: ${file.path}');
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
      return "/storage";
    } else {
      var directory = await getApplicationDocumentsDirectory();
      return directory.path + Platform.pathSeparator + 'Download';
    }
  }
}
