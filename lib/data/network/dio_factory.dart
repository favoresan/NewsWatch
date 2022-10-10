import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../../app/constant.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class DioFactory {
  Future<Dio> getDio() async {
    Dio dio = Dio();

    int _timeout = 60 * 1000;

    dio.options = BaseOptions(
      baseUrl: Constant.baseUrl,
      connectTimeout: _timeout,
      receiveTimeout: _timeout,
    );

    if (kReleaseMode) {
      print('release mode no logs');
    } else {
      dio.interceptors.add(PrettyDioLogger(
        requestBody: true,
        requestHeader: true,
        responseHeader: true,
      ));
    }

    return dio;
  }
}
