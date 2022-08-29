import 'package:bryte/components/network/interceptor/dio_connectivity_request_retry.dart';
import 'package:bryte/components/network/interceptor/retry_interceptor.dart';
import 'package:bryte/core/data/model/profile/request/profile_body.dart';
import 'package:bryte/core/data/model/profile/response/profile_model.dart';
import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../../../components/utils/constant.dart';

abstract class ProfileRepository {
  Future<ProfileModel> getUserProfile(ProfileBody body);
}

@LazySingleton(as: ProfileRepository)
class ProfileRepositoryImpl extends ProfileRepository {
  Dio get dio => _getDio();

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
  Future<ProfileModel> getUserProfile(ProfileBody body) async {
    try {
      Response response =
          await dio.post(Url.profile, queryParameters: body.toJson());
      return ProfileModel.fromJson(response.data);
    } catch (e) {
      if (e is DioError) {
        if (e.type == DioErrorType.response) {
          return ProfileModel.fromJson(e.response?.data);
        } else {
          throw Exception(e.message);
        }
      } else {
        throw Exception("Error");
      }
    }
  }
}
