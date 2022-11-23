import 'package:bryte/components/network/interceptor/dio_connectivity_request_retry.dart';
import 'package:bryte/core/data/model/course/request/assignment_per_course_body.dart';
import 'package:bryte/core/data/model/course/request/course_body.dart';
import 'package:bryte/core/data/model/course/request/detail_assignment_body.dart';
import 'package:bryte/core/data/model/course/request/edit_submission_body.dart';
import 'package:bryte/core/data/model/course/request/master_section_body.dart';
import 'package:bryte/core/data/model/course/response/assignment_model.dart';
import 'package:bryte/core/data/model/course/response/assignment_per_course_model.dart';
import 'package:bryte/core/data/model/course/response/course_model.dart';
import 'package:bryte/core/data/model/course/response/detail_assignment_model.dart';
import 'package:bryte/core/data/model/course/response/edit_submission_model.dart';
import 'package:bryte/core/data/model/course/response/master_course_section_model.dart';
import 'package:bryte/core/data/model/student/request/general_course_body.dart';
import 'package:bryte/core/data/model/student/response/course_general_model.dart';
import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../../../components/network/interceptor/retry_interceptor.dart';
import '../../../components/utils/constant.dart';

abstract class CourseRepository {
  Future<List<CourseGeneralModel>> getGeneralCourse(GeneralCourseBody body);
  Future<CourseModel> getCourse(CourseBody body);
  Future<AssignmentModel> getAssignment(CourseBody body);
  Future<DetailAssignmentModel> getDetailAssignment(DetailAssignmentBody body);
  Future<AssignmentPerCourseModel> getAssignmentPerCourse(
      AssignmentPerCourseBody body);
  Future<MasterCourseSectionModel> getMasterCourseSection(
      MasterSectionBody body);
  Future<EditSubmissionModel> getEditSubmission(EditSubmissionBody body);
}

@LazySingleton(as: CourseRepository)
class CourseRepositoryImpl extends CourseRepository {
  Dio get dio => _getDio();

  Dio _getDio() {
    final options = BaseOptions(
        receiveDataWhenStatusError: true,
        baseUrl: Url.baseUrlDev,
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

    dio.interceptors.add(
      RetryOnConnectionChangeInterceptor(
        requestRetrier: DioConnectivityRequestRetrier(
          dio: dio,
          connectivity: Connectivity(),
        ),
      ),
    );

    return dio;
  }

  @override
  Future<List<CourseGeneralModel>> getGeneralCourse(
      GeneralCourseBody body) async {
    try {
      Response response = await dio.post(
        Url.generalCourse,
        queryParameters: body.toJson(),
      );

      List<CourseGeneralModel> courseGeneral = (response.data as List)
          .map((data) => CourseGeneralModel.fromJson(data))
          .toList();

      return courseGeneral;
    } catch (e) {
      throw Exception("Err");
    }
  }

  @override
  Future<CourseModel> getCourse(CourseBody body) async {
    try {
      Response response = await dio.post(Url.course, data: body.toJson());
      return CourseModel.fromJson(response.data);
    } catch (e) {
      if (e is DioError) {
        if (e.type == DioErrorType.response) {
          return CourseModel.fromJson(e.response?.data);
        } else {
          throw Exception(e.message);
        }
      } else {
        throw Exception("Error");
      }
    }
  }

  @override
  Future<AssignmentModel> getAssignment(CourseBody body) async {
    try {
      Response response = await dio.post(
        Url.assignment,
        data: body.toJson(),
      );
      return AssignmentModel.fromJson(response.data);
    } catch (e) {
      if (e is DioError) {
        if (e.type == DioErrorType.response) {
          return AssignmentModel.fromJson(e.response?.data);
        } else {
          throw Exception(e.message);
        }
      } else {
        throw Exception("Error");
      }
    }
  }

  @override
  Future<DetailAssignmentModel> getDetailAssignment(
      DetailAssignmentBody body) async {
    try {
      Response response = await dio.post(
        Url.detailAssignment,
        data: body.toJson(),
      );
      return DetailAssignmentModel.fromJson(response.data);
    } catch (e) {
      if (e is DioError) {
        if (e.type == DioErrorType.response) {
          return DetailAssignmentModel.fromJson(e.response?.data);
        } else {
          throw Exception(e.message);
        }
      } else {
        throw Exception("Error");
      }
    }
  }

  @override
  Future<AssignmentPerCourseModel> getAssignmentPerCourse(
      AssignmentPerCourseBody body) async {
    try {
      Response response = await dio.post(
        Url.assignmentPerCourse,
        data: body.toJson(),
      );
      return AssignmentPerCourseModel.fromJson(response.data);
    } catch (e) {
      if (e is DioError) {
        if (e.type == DioErrorType.response) {
          return AssignmentPerCourseModel.fromJson(e.response?.data);
        } else {
          throw Exception(e.message);
        }
      } else {
        throw Exception("Error");
      }
    }
  }

  @override
  Future<MasterCourseSectionModel> getMasterCourseSection(
      MasterSectionBody body) async {
    try {
      Response response = await dio.post(
        Url.masterCourseSection,
        data: body.toJson(),
      );
      return MasterCourseSectionModel.fromJson(response.data);
    } catch (e) {
      if (e is DioError) {
        if (e.type == DioErrorType.response) {
          return MasterCourseSectionModel.fromJson(e.response?.data);
        } else {
          throw Exception(e.message);
        }
      } else {
        throw Exception("Error");
      }
    }
  }

  @override
  Future<EditSubmissionModel> getEditSubmission(EditSubmissionBody body) async {
    try {
      Response response = await dio.post(
        Url.editSubmission,
        queryParameters: body.toJson(),
      );
      return EditSubmissionModel.fromJson(response.data);
    } catch (e) {
      if (e is DioError) {
        if (e.type == DioErrorType.response) {
          return EditSubmissionModel.fromJson(e.response?.data);
        } else {
          throw Exception(e.message);
        }
      } else {
        throw Exception("Error");
      }
    }
  }
}
