import 'package:bryte/components/network/interceptor/dio_connectivity_request_retry.dart';
import 'package:bryte/components/network/interceptor/retry_interceptor.dart';
import 'package:bryte/core/data/model/profile/request/attendance_rate_student.dart';
import 'package:bryte/core/data/model/profile/request/gpa_grade_body.dart';
import 'package:bryte/core/data/model/profile/request/list_semester_student_body.dart';
import 'package:bryte/core/data/model/profile/request/period_student_body.dart';
import 'package:bryte/core/data/model/profile/request/profile_body.dart';
import 'package:bryte/core/data/model/profile/response/attendance_rate_persentase_model.dart';
import 'package:bryte/core/data/model/profile/response/attendance_rate_student_model.dart';
import 'package:bryte/core/data/model/profile/response/gpa_grade_model.dart';
import 'package:bryte/core/data/model/profile/response/list_semester_student_model.dart';
import 'package:bryte/core/data/model/profile/response/period_per_student_model.dart';
import 'package:bryte/core/data/model/profile/response/profile_model.dart';
import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../../../components/utils/constant.dart';
import '../../../flavors.dart';

abstract class ProfileRepository {
  Future<ProfileModel> getUserProfile(ProfileBody body);
  Future<PeriodPerStudentModel> getAcademicPeriodStudent(
      PeriodStudentBody body);
  Future<AttendanceRateStudentModel> getAttendanceRatePerStudent(
      AttendanceRateStudentBody body);
  Future<AttendanceRatePersentaseModel> getAttendanceRatePersentase(
      AttendanceRateStudentBody body);
  Future<ListSemesterStudentModel> getListSemesterStudent(
      ListSemesterStudentBody body);
  Future<GpaGradeModel> getGpaGrade(GpaGradeBody body);
}

@LazySingleton(as: ProfileRepository)
class ProfileRepositoryImpl extends ProfileRepository {
  Dio get dio => _getDio();

  Dio _getDio() {
    final options = BaseOptions(
        receiveDataWhenStatusError: true,
        baseUrl: F.apiUrl,
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

  @override
  Future<PeriodPerStudentModel> getAcademicPeriodStudent(
      PeriodStudentBody body) async {
    try {
      Response response = await dio.post(
        Url.academicPeriodStudent,
        data: body.toJson(),
      );
      return PeriodPerStudentModel.fromJson(response.data);
    } catch (e) {
      if (e is DioError) {
        if (e.type == DioErrorType.response) {
          return PeriodPerStudentModel.fromJson(e.response?.data);
        } else {
          throw Exception(e.message);
        }
      } else {
        throw Exception("Error");
      }
    }
  }

  @override
  Future<AttendanceRateStudentModel> getAttendanceRatePerStudent(
      AttendanceRateStudentBody body) async {
    try {
      Response response = await dio.post(
        Url.attendanceRateStudent,
        data: body.toJson(),
      );
      return AttendanceRateStudentModel.fromJson(response.data);
    } catch (e) {
      if (e is DioError) {
        if (e.type == DioErrorType.response) {
          return AttendanceRateStudentModel.fromJson(e.response?.data);
        } else {
          throw Exception(e.message);
        }
      } else {
        throw Exception("Error");
      }
    }
  }

  @override
  Future<ListSemesterStudentModel> getListSemesterStudent(
      ListSemesterStudentBody body) async {
    try {
      Response response = await dio.post(
        Url.listSemesterStudent,
        data: body.toJson(),
      );
      return ListSemesterStudentModel.fromJson(response.data);
    } catch (e) {
      if (e is DioError) {
        if (e.type == DioErrorType.response) {
          return ListSemesterStudentModel.fromJson(e.response?.data);
        } else {
          throw Exception(e.message);
        }
      } else {
        throw Exception("Error");
      }
    }
  }

  @override
  Future<GpaGradeModel> getGpaGrade(GpaGradeBody body) async {
    try {
      Response response = await dio.post(
        Url.finalGpaGrade,
        data: body.toJson(),
      );
      return GpaGradeModel.fromJson(response.data);
    } catch (e) {
      if (e is DioError) {
        if (e.type == DioErrorType.response) {
          return GpaGradeModel.fromJson(e.response?.data);
        } else {
          throw Exception(e.message);
        }
      } else {
        throw Exception("Error");
      }
    }
  }

  @override
  Future<AttendanceRatePersentaseModel> getAttendanceRatePersentase(
      AttendanceRateStudentBody body) async {
    try {
      Response response = await dio.post(
        Url.attendanceRateStudent,
        data: body.toJson(),
      );
      return AttendanceRatePersentaseModel.fromJson(response.data);
    } catch (e) {
      if (e is DioError) {
        if (e.type == DioErrorType.response) {
          return AttendanceRatePersentaseModel.fromJson(e.response?.data);
        } else {
          throw Exception(e.message);
        }
      } else {
        throw Exception("Error");
      }
    }
  }
}
