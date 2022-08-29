import 'package:bryte/core/blocs/attend/attend_bloc.dart';
import 'package:bryte/core/blocs/class/class_bloc.dart';
import 'package:bryte/core/blocs/student/student_bloc.dart';
import 'package:bryte/core/blocs/summary/summary_bloc.dart';
import 'package:bryte/core/blocs/upcoming/upcoming_bloc.dart';
import 'package:bryte/components/utils/constant.dart';
import 'package:bryte/core/data/model/student/request/announcement_body.dart';
import 'package:bryte/core/data/model/student/request/class_summary_student_body.dart';
import 'package:bryte/core/data/model/student/request/today_classes_body.dart';
import 'package:bryte/core/data/model/student/request/upcoming_assign_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../components/utils/enum.dart';
import '../../../components/widgets/app_bar.dart';
import '../../../core/di/injection.dart';
import '../../../core/repo/auth/auth_repository.dart';
import '../local_widget/header_home.dart';
import '../local_widget/today_classes.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final studentBloc = getIt<StudentBloc>();
  final summaryBloc = getIt<SummaryBloc>();
  final classBloc = getIt<ClassBloc>();
  final upcomingBloc = getIt<UpcomingBloc>();
  final attendBloc = getIt<AttendBloc>();

  @override
  Widget build(BuildContext context) {
    String? token = box.read(KeyConstant.token) ?? '';
    String? userId = box.read(KeyConstant.userId) ?? '';

    onRefresh() {
      studentBloc.add(
        GetAnnouncementEvent(
          AnnouncementBody(token: token),
        ),
      );
      classBloc.add(
        GetClassesDetStudent(
          body: TodayClassesBody(
            date: '',
            token: token,
            type: CourseType.daily,
            userid: userId,
          ),
        ),
      );
      summaryBloc.add(
        GetClassSummaryStudent(
          ClassSummaryStudentBody(
            token: token,
            userid: userId,
          ),
        ),
      );
      upcomingBloc.add(
        GetUpcomingAssignEvent(
          body: UpcomingAssignBody(
            token: token,
            userid: userId,
          ),
        ),
      );
    }

    return Scaffold(
      appBar: appbar(context),
      body: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => studentBloc
              ..add(
                GetAnnouncementEvent(
                  AnnouncementBody(token: token),
                ),
              ),
          ),
          BlocProvider(
            create: (context) => summaryBloc
              ..add(
                GetClassSummaryStudent(
                  ClassSummaryStudentBody(
                    token: token,
                    userid: userId,
                  ),
                ),
              ),
          ),
          BlocProvider(
            create: (context) => classBloc
              ..add(GetClassesDetStudent(
                  body: TodayClassesBody(
                date: '',
                token: token,
                type: CourseType.daily,
                userid: userId,
              ))),
          ),
          BlocProvider(
            create: (context) => upcomingBloc
              ..add(
                GetUpcomingAssignEvent(
                  body: UpcomingAssignBody(
                    token: token,
                    userid: userId,
                  ),
                ),
              ),
          ),
          BlocProvider(
            create: (context) => attendBloc,
          ),
        ],
        child: RefreshIndicator(
          onRefresh: () async => onRefresh(),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics(),
            ),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 22),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const HeaderHome(),
                  TodayClasses(
                    attendBloc: attendBloc,
                  ),
                  // const UpcomingAssignments(),
                  // const Announcements(),
                  const SizedBox(height: 100)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
