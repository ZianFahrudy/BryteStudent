import 'package:bryte/core/data/model/auth/auth_model.dart';
import 'package:bryte/core/data/model/auth/request/login_body.dart';
import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../../../components/network/interceptor/dio_connectivity_request_retry.dart';
import '../../../components/network/interceptor/retry_interceptor.dart';
import '../../../components/utils/constant.dart';

abstract class AuthenticationRepository {
  Future<AuthModel> login(LoginBody body);
}

@LazySingleton(as: AuthenticationRepository)
class AuthenticationRepositoryImpl extends AuthenticationRepository {
  Dio get dioMoodle => _getDio();

  Dio _getDio() {
    final options = BaseOptions(
        receiveDataWhenStatusError: true,
        baseUrl: Url.baseUrlProdProd,
        sendTimeout: 60000,
        followRedirects: false,
        headers: {
          "Accept": "application/json",
        });

    final dio = Dio(options);

    dio.interceptors.add(
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
        maxWidth: 300,
      ),
    );

    dio.interceptors.add(RetryOnConnectionChangeInterceptor(
        requestRetrier: DioConnectivityRequestRetrier(
            dio: dio, connectivity: Connectivity())));

    return dio;
  }

  @override
  Future<AuthModel> login(LoginBody body) async {
    try {
      FormData formData = FormData.fromMap({
        'username': body.email,
        'password': body.password,
        'service': 'bryte',
      });
      Response response = await dioMoodle.post(Url.login, data: formData);
      return AuthModel.fromJson(response.data);
    } catch (e) {
      if (e is DioError) {
        if (e.type == DioErrorType.response) {
          return AuthModel.fromJson(e.response?.data);
        } else {
          throw Exception(e.message);
        }
      } else {
        throw Exception("Error");
      }
    }
  }
}
