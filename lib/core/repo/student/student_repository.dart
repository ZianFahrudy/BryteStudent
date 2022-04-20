import 'package:bryte/core/model/student/request/announcement_body.dart';
import 'package:bryte/core/model/student/request/class_summary_student_body.dart';
import 'package:bryte/core/model/student/request/today_classes_body.dart';
import 'package:bryte/core/model/student/request/upcoming_assign_body.dart';
import 'package:bryte/core/model/student/response/announcement_model.dart';
import 'package:bryte/core/model/student/response/class_summary_student_model.dart';
import 'package:bryte/core/model/student/response/today_classes_model.dart';
import 'package:bryte/core/model/student/response/upcoming_assign_model.dart';
import 'package:bryte/utils/constant.dart';
import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../../interceptor/dio_connectivity_request_retry.dart';
import '../../interceptor/retry_interceptor.dart';

abstract class StudentRepository {
  Future<ClassSummaryStudentModel> getClassSummaryStudent(
      ClassSummaryStudentBody body);
  Future<AnnouncementModel> getAnnouncement(AnnouncementBody body);
  Future<TodayClassesModel> getTodayClasses(TodayClassesBody body);
  Future<UpcomingAssignModel> getUpcomingAssign(UpcomingAssignBody body);
}

@LazySingleton(as: StudentRepository)
class StudentRepositoryImpl extends StudentRepository {
  Dio get dio => _getDio();

  Dio _getDio() {
    final options = BaseOptions(
        receiveDataWhenStatusError: true,
        baseUrl: Url.baseUrl,
        sendTimeout: 60000,
        followRedirects: false,
        headers: {
          "Accept": "application/json",
          // 'Authorization': "Bearer dbc5828b35478576423d83c274e9845b",
        });

    final dio = Dio(options);

    dio.interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
        maxWidth: 300));

    dio.interceptors.add(RetryOnConnectionChangeInterceptor(
        requestRetrier: DioConnectivityRequestRetrier(
            dio: dio, connectivity: Connectivity())));

    return dio;
  }

  // final dio = Dio(
  //   BaseOptions(
  //       receiveDataWhenStatusError: true,
  //       baseUrl: Url.baseUrl,
  //       sendTimeout: 60000,
  //       followRedirects: false,
  //       headers: {
  //         "Accept": "application/json",
  //         // 'Authorization': "Bearer dbc5828b35478576423d83c274e9845b",
  //       }),
  // )..interceptors.add(
  //     PrettyDioLogger(
  //         requestHeader: true,
  //         requestBody: true,
  //         responseBody: true,
  //         responseHeader: false,
  //         error: true,
  //         compact: true,
  //         maxWidth: 300),
  //   );

  @override
  Future<ClassSummaryStudentModel> getClassSummaryStudent(
      ClassSummaryStudentBody body) async {
    try {
      Response response =
          await dio.post(Url.classSummaryStudent, data: body.toJson());
      return ClassSummaryStudentModel.fromJson(response.data);
    } catch (e) {
      if (e is DioError) {
        if (e.type == DioErrorType.response) {
          return ClassSummaryStudentModel.fromJson(e.response?.data);
        } else {
          throw Exception(e.message);
        }
      } else {
        throw Exception("Error");
      }
    }
  }

  @override
  Future<AnnouncementModel> getAnnouncement(AnnouncementBody body) async {
    try {
      Response response = await dio.post(Url.announcement, data: body.toJson());
      return AnnouncementModel.fromJson(response.data);
    } catch (e) {
      if (e is DioError) {
        if (e.type == DioErrorType.response) {
          return AnnouncementModel.fromJson(e.response?.data);
        } else {
          throw Exception(e.message);
        }
      } else {
        throw Exception("Error");
      }
    }
  }

  @override
  Future<TodayClassesModel> getTodayClasses(TodayClassesBody body) async {
    try {
      Response response =
          await dio.post(Url.classesDetStudent, data: body.toJson());
      return TodayClassesModel.fromJson(response.data);
    } catch (e) {
      if (e is DioError) {
        if (e.type == DioErrorType.response) {
          return TodayClassesModel.fromJson(e.response?.data);
        } else {
          throw Exception(e.message);
        }
      } else {
        throw Exception("Error");
      }
    }
  }

  @override
  Future<UpcomingAssignModel> getUpcomingAssign(UpcomingAssignBody body) async {
    try {
      Response response =
          await dio.post(Url.upcomingAssignStudent, data: body.toJson());
      return UpcomingAssignModel.fromJson(response.data);
    } catch (e) {
      if (e is DioError) {
        if (e.type == DioErrorType.response) {
          return UpcomingAssignModel.fromJson(e.response?.data);
        } else {
          throw Exception(e.message);
        }
      } else {
        throw Exception("Error");
      }
    }
  }
}
