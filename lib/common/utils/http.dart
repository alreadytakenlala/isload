import 'package:dio/dio.dart';
import 'package:island/modules/api_data.dart';

Dio dio = new Dio(new BaseOptions(
    baseUrl: ApiData.baseUrl,
    connectTimeout: 5000,
    receiveTimeout: 3000
));

class Http {
  static Future<T> post<T>({String api, Map<String, dynamic> params}) async {
    Response res = await dio.post(ApiData.baseDirectory+api, data: params);
    return res.data["data"];
  }

  static dynamic get<T>({String api,  Map<String, dynamic> params}) async {
    Response res = await dio.get(ApiData.baseDirectory+api, queryParameters: params);
    return res.data["data"];
  }
}