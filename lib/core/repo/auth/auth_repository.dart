import 'package:bryte/core/model/auth/auth_model.dart';
import 'package:bryte/core/model/auth/authorization_model.dart';
import 'package:bryte/core/model/auth/request/authorization_body.dart';
import 'package:bryte/utils/constant.dart';
import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

final box = GetStorage();

class AuthRepository {
  String? token = box.read(KeyConstant.token) ?? '';

  Dio get dio => Dio(
        BaseOptions(
            receiveDataWhenStatusError: true,
            baseUrl: Url.baseUrl,
            sendTimeout: 60000,
            followRedirects: false,
            headers: {
              "Accept": "application/json",
              'Authorization': "Bearer ${token ?? ''}",
            }),
      )..interceptors.add(
          PrettyDioLogger(
              requestHeader: true,
              requestBody: true,
              responseBody: true,
              responseHeader: false,
              error: true,
              compact: true,
              maxWidth: 300),
        );
  // ..interceptors.add(RetryOnConnectionChangeInterceptor(
  //     requestRetrier: DioConnectivityRequestRetrier(
  //         dio: dio, connectivity: Connectivity())));
  // ..interceptors.add(
  //   RetryInterceptor(
  //     dio: dio, logPrint: print, // specify log function
  //     retries: 3, // retry count
  //     retryDelays: const [
  //       Duration(seconds: 1), // wait 1 sec before first retry
  //       Duration(seconds: 2), // wait 2 sec before second retry
  //       Duration(seconds: 3), // wait 3 sec before third retry
  //     ],
  //   ),
  // );

  Future<AuthModel?> login(String? email, String? password) async {
    try {
      FormData formData = FormData.fromMap({
        'username': email,
        'password': password,
        'service': 'bryte',
      });
      Response response = await dio.post(Url.login, data: formData);
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

  Future<ForgotPasswordModel?> forgotPassword(String? email) async {
    try {
      FormData formData = FormData.fromMap({
        'username': email,
        'service': 'bryte',
      });
      Response response = await dio.post(Url.forgotPassword, data: formData);
      return ForgotPasswordModel.fromJson(response.data);
    } catch (e) {
      if (e is DioError) {
        if (e.type == DioErrorType.response) {
          return ForgotPasswordModel.fromJson(e.response?.data);
        } else {
          throw Exception(e.message);
        }
      } else {
        throw Exception("Error");
      }
    }
  }

  Future<OtpdModel> verifyOtp(String? username, String? otp) async {
    try {
      FormData formData = FormData.fromMap({
        'username': username,
        'otp': otp,
        'service': 'bryte',
      });
      Response response = await dio.post(Url.verifyOtp, data: formData);
      return OtpdModel.fromJson(response.data);
    } catch (e) {
      if (e is DioError) {
        if (e.type == DioErrorType.response) {
          return OtpdModel.fromJson(e.response?.data);
        } else {
          throw Exception(e.message);
        }
      } else {
        throw Exception("Error");
      }
    }
  }

  Future<OtpdModel> resetPass(String? username, String? password) async {
    try {
      FormData formData = FormData.fromMap({
        'username': username,
        'password': password,
        'retype_password': password,
        'service': 'bryte',
      });
      Response response = await dio.post(Url.resetPass, data: formData);
      return OtpdModel.fromJson(response.data);
    } catch (e) {
      if (e is DioError) {
        if (e.type == DioErrorType.response) {
          return OtpdModel.fromJson(e.response?.data);
        } else {
          throw Exception(e.message);
        }
      } else {
        throw Exception("Error");
      }
    }
  }

  Future<OtpdModel> resentOTP(String? username) async {
    try {
      FormData formData = FormData.fromMap({
        'username': username,
        'service': 'bryte',
      });
      Response response = await dio.post(Url.resenOTP, data: formData);
      return OtpdModel.fromJson(response.data);
    } catch (e) {
      if (e is DioError) {
        if (e.type == DioErrorType.response) {
          return OtpdModel.fromJson(e.response?.data);
        } else {
          throw Exception(e.message);
        }
      } else {
        throw Exception("Error");
      }
    }
  }

  Future<AuthorizationModel> authorization(AuthorizationBody body) async {
    try {
      Response response =
          await dio.post(Url.authorization, data: body.toJson());
      return AuthorizationModel.fromJson(response.data);
    } catch (e) {
      if (e is DioError) {
        if (e.type == DioErrorType.response) {
          return AuthorizationModel.fromJson(e.response?.data);
        } else {
          throw Exception(e.message);
        }
      } else {
        throw Exception("Error");
      }
    }
  }
}
