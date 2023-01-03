import 'dart:async';
import 'dart:io';

import 'package:get/get.dart';
import 'package:kasir_app/src/config/constans_config.dart';
import 'package:kasir_app/src/repository/s_preference.dart';

class ApiProduct extends GetConnect {
  final String url = '$globalApi/api';

  // ============ Sampah ============

  Future<Response> getProduct({
    int page = 1,
    int limit = 10,
    int status = 1,
  }) async {
    String token = await getToken();

    var res = await get('$url/item?page=$page&limit=$limit', headers: {
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
