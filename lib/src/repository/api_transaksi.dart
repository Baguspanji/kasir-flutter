import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:kasir_app/src/config/constans_config.dart';
import 'package:kasir_app/src/repository/s_preference.dart';

class ApiTransaksi extends GetConnect {
  final String url = '$globalApi/api';

  // ============ Transaksi ============

  Future<Response> getTransaksi({
    int page = 1,
    int limit = 10,
  }) async {
    String token = await getToken();

    var res = await get('$url/transaction?page=$page&limit=$limit', headers: {
      'Authorization': token,
      'Accept': 'application/json',
    });

    return getRes(res);
  }

  Future<Response> createTransaksi(dynamic data) async {
    String token = await getToken();

    var res = await post('$url/transaction', jsonEncode(data), headers: {
      'Authorization': token,
      'Accept': 'application/json',
    });

    return getRes(res);
  }
  Future<Response> editTransaksi(dynamic data, int id) async {
    String token = await getToken();

    var res = await put('$url/transaction/$id', jsonEncode(data), headers: {
      'Authorization': token,
      'Accept': 'application/json',
    });

    return getRes(res);
  }

// ==========================================

  Future<Response> getRes(Response res) async {
    try {
      return res;
    } on SocketException catch (e) {
      throw Exception(e.toString());
    } on HttpException {
      {
        throw Exception("tidak menemukan post");
      }
    } on FormatException {
      throw Exception("request salah");
    } on TimeoutException catch (e) {
      throw Exception(e.toString());
    }
  }
}
