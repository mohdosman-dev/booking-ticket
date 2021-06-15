import 'dart:convert';
import 'dart:developer';

import 'package:booking_smt_test/utils/constants.dart';
import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';

class ApiProvider {
  static String _baseUrl = kServerBaseUrl;
  final int keepOnCache = 3;
  Dio dio = Dio();
  CancelToken cancelToken = CancelToken();

  static BaseOptions opts = BaseOptions(
    baseUrl: _baseUrl,
    responseType: ResponseType.json,
    connectTimeout: 30000,
    receiveTimeout: 30000,
  );
  ApiProvider() {
    dio.options = opts;
  }

  Future<Map<String, dynamic>> getHTTP(String path,
      {Map<String, dynamic> body}) async {
    try {
      var connectivityResult = await (Connectivity().checkConnectivity());
      if (connectivityResult == ConnectivityResult.none) {
        return {
          "ResponseInfo": {
            "Error": {
              "Message": "No internet connectivity",
            }
          },
        };
      }
      if (body != null) {
        body['partner'] = kUserApi;
        body['v'] = 3;
      } else {
        body = {'partner': kUserApi, 'v': 3};
      }
      Response response = await dio.get(
        path,
        queryParameters: body,
        cancelToken: cancelToken,
        onReceiveProgress: (int receive, int total) {},
      );

      Map<String, dynamic> responseBody = response.data;
      return responseBody;
    } on DioError catch (e) {
      log('Web exception: ${e.response}');
      return {
        "ResponseInfo": {
          "Error": {
            "Message": e.message,
            'Code': e.response.statusCode,
          },
          'data': [],
        },
      };
    }
  }

  Future<Map<String, dynamic>> postHTTP(String path,
      {Map<String, dynamic> body}) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      return {
        "ResponseInfo": {
          "Error": {
            "Message": "No internet connectivity",
          }
        },
      };
    }
    try {
      if (body != null) {
        body['partner'] = kUserApi;
        body['v'] = 3;
      } else {
        body = {'partner': kUserApi, 'v': 3};
      }
      Response response = await dio.post(
        path,
        cancelToken: cancelToken,
        data: FormData.fromMap(body),
        onReceiveProgress: (int receive, int total) {},
      );

      Map responseBody = json.decode(response.data)['data'];
      return responseBody;
    } on DioError catch (e) {
      log('Web exception: ${e.message}');
      return {
        "ResponseInfo": {
          "Error": {
            "Message": "No internet connectivity",
          }
        },
      };
    }
  }
}
