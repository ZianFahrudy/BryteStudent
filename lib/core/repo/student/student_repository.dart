import 'package:bryte/components/utils/constant.dart';
import 'package:bryte/core/data/model/calendar/request/event_body.dart';
import 'package:bryte/core/data/model/calendar/response/event_model.dart';
import 'package:bryte/core/data/model/course/request/attendance_body.dart';
import 'package:bryte/core/data/model/course/response/attendance_model.dart';
import 'package:bryte/core/data/model/student/request/announcement_body.dart';
import 'package:bryte/core/data/model/student/request/class_summary_student_body.dart';
import 'package:bryte/core/data/model/student/request/submit_attendance_body.dart';
import 'package:bryte/core/data/model/student/request/today_classes_body.dart';
import 'package:bryte/core/data/model/student/request/upcoming_assign_body.dart';
import 'package:bryte/core/data/model/student/response/announcement_model.dart';
import 'package:bryte/core/data/model/student/response/class_summary_student_model.dart';
import 'package:bryte/core/data/model/student/response/today_classes_model.dart';
import 'package:bryte/core/data/model/student/response/upcoming_assign_model.dart';
import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../../../components/network/interceptor/dio_connectivity_request_retry.dart';
import '../../../components/network/interceptor/retry_interceptor.dart';

abstract class StudentRepository {
  Future<ClassSummaryStudentModel> getClassSummaryStudent(
      ClassSummaryStudentBody body);
  Future<AnnouncementModel> getAnnouncement(AnnouncementBody body);
  Future<TodayClassesModel> getTodayClasses(TodayClassesBody body);
  Future<UpcomingAssignModel> getUpcomingAssign(UpcomingAssignBody body);
  Future<CalendarEventModel> getCalendarEvent(EventBody body);
  Future<String> submitAttendance(SubmitAttendanceBody body);
  Future<AttendanceModel> getAttendance(AttendanceBody body);
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

  @override
  Future<CalendarEventModel> getCalendarEvent(EventBody body) async {
    try {
      Response response =
          await dio.post(Url.calendarEvent, data: body.toJson());
      return CalendarEventModel.fromJson(response.data);
    } catch (e) {
      if (e is DioError) {
        if (e.type == DioErrorType.response) {
          return CalendarEventModel.fromJson(e.response?.data);
        } else {
          throw Exception(e.message);
        }
      } else {
        throw Exception("Error");
      }
    }
  }

  @override
  Future<String> submitAttendance(SubmitAttendanceBody body) async {
    try {
      Response response =
          await dio.post(Url.attendance, queryParameters: body.toJson());

      if (response.data != null) {
        return "Gagal";
      }
      return "Sukses";
    } catch (e) {
      if (e is DioError) {
        if (e.type == DioErrorType.response) {
          return 'Gagal';
        } else {
          throw Exception(e.message);
        }
      } else {
        throw Exception("Error");
      }
    }
  }

  @override
  Future<AttendanceModel> getAttendance(AttendanceBody body) async {
    try {
      Response response = await dio.post(
        Url.attendanceCourse,
        data: body.toJson(),
      );
      return AttendanceModel.fromJson(response.data);
    } catch (e) {
      if (e is DioError) {
        if (e.type == DioErrorType.response) {
          return AttendanceModel.fromJson(e.response?.data);
        } else {
          throw Exception(e.message);
        }
      } else {
        throw Exception("Error");
      }
    }
  }
}
