import 'dart:convert';
import 'dart:developer';

import 'package:bryte/core/data/model/moodle/request/assign_save_body.dart';
import 'package:bryte/core/data/model/moodle/request/assign_save_json_body.dart';
import 'package:bryte/core/data/model/moodle/request/assign_submit_file.dart';
import 'package:bryte/core/data/model/moodle/request/upload_file_body.dart';
import 'package:bryte/core/data/model/moodle/response/assign_save_model.dart';
import 'package:bryte/core/data/model/moodle/response/upload_file_model.dart';
import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../../../components/network/interceptor/dio_connectivity_request_retry.dart';
import '../../../components/network/interceptor/retry_interceptor.dart';
import '../../../components/utils/constant.dart';

abstract class MoodleRepository {
  Future<UploadFileModel> uploadFile(UploadFileBody body);
  Future<List<AssignSaveModel>> assignSaveFile(
    AssignSaveBody body,
    AssignSaveJsonBody jsonBody,
  );
  Future<List<AssignSaveModel>> assignSubmitFile(
    AssignSubmitFileBody body,
    AssignSaveJsonBody jsonBody,
  );
}

@LazySingleton(as: MoodleRepository)
class MoodleRepositoryImpl extends MoodleRepository {
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
  Future<UploadFileModel> uploadFile(UploadFileBody body) async {
    try {
      final data = FormData.fromMap(
        <String, dynamic>{
          'token': body.token,
          'filearea': body.filearea,
          'itemid': body.itemid,
          'file': await MultipartFile.fromFile(
            body.file,
            filename: 'file',
          ),
        },
      );
      Response response = await dio.post(
        Url.uploadFile,
        data: data,
      );

      String stringResp = response.data;

      var responseObject = jsonDecode(stringResp);

      var objectResp = responseObject[0];

      log('JSON2: $objectResp}');

      return UploadFileModel.fromJson(objectResp);
    } catch (e) {
      if (e is DioError) {
        if (e.type == DioErrorType.response) {
          return UploadFileModel.fromJson(e.response?.data);
        } else {
          throw Exception(e.message);
        }
      } else {
        throw Exception("Error");
      }
    }
  }

  @override
  Future<List<AssignSaveModel>> assignSaveFile(
      AssignSaveBody body, AssignSaveJsonBody jsonBody) async {
    try {
      Response response = await dio.post(
        Url.assignSaveFile,
        queryParameters: body.toJson(),
        data: jsonBody.toJson(),
      );
      var resp = (response.data as List)
          .map((e) => AssignSaveModel.fromJson(e))
          .toList();

      return resp;
    } catch (e) {
      if (e is DioError) {
        if (e.type == DioErrorType.response) {
          var resp = (e.response?.data as List)
              .map((e) => AssignSaveModel.fromJson(e))
              .toList();

          return resp;
        } else {
          throw Exception(e.message);
        }
      } else {
        throw Exception("Error");
      }
    }
  }

  @override
  Future<List<AssignSaveModel>> assignSubmitFile(
    AssignSubmitFileBody body,
    AssignSaveJsonBody jsonBody,
  ) async {
    try {
      Response response = await dio.post(
        Url.assignSaveFile,
        queryParameters: body.toJson(),
        data: jsonBody.toJson(),
      );
      var resp = (response.data as List)
          .map((e) => AssignSaveModel.fromJson(e))
          .toList();

      return resp;
    } catch (e) {
      if (e is DioError) {
        if (e.type == DioErrorType.response) {
          var resp = (e.response?.data as List)
              .map((e) => AssignSaveModel.fromJson(e))
              .toList();

          return resp;
        } else {
          throw Exception(e.message);
        }
      } else {
        throw Exception("Error");
      }
    }
  }
}
