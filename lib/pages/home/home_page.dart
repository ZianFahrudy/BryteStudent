import 'package:bryte/core/model/student/request/announcement_body.dart';
import 'package:bryte/core/model/student/request/class_summary_student_body.dart';
import 'package:bryte/core/model/student/request/today_classes_body.dart';
import 'package:bryte/core/model/student/request/upcoming_assign_body.dart';
import 'package:bryte/pages/home/widgets/announcement.dart';
import 'package:bryte/pages/home/widgets/header_home.dart';
import 'package:bryte/pages/home/widgets/today_classes.dart';
import 'package:bryte/pages/home/widgets/upcoming_assignments.dart';
import 'package:bryte/theme.dart';
import 'package:bryte/utils/enum.dart';
// import 'package:dio_smart_retry/dio_smart_retry.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/di/injection.dart';
import '../../core/repo/auth/auth_repository.dart';
import '../../core/student/class/class_bloc.dart';
import '../../core/student/student_bloc.dart';
import '../../core/student/summary/summary_bloc.dart';
import '../../core/student/upcoming/upcoming_bloc.dart';
import '../../utils/constant.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool descTextShowFlag = false;

  final studentBloc = getIt<StudentBloc>();
  final summaryBloc = getIt<SummaryBloc>();
  final classBloc = getIt<ClassBloc>();
  final upcomingBloc = getIt<UpcomingBloc>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String? token = box.read(KeyConstant.token) ?? '';
    String? userId = box.read(KeyConstant.userId) ?? '';

    onRefresh() {
      studentBloc.add(GetAnnouncementEvent(AnnouncementBody(token: token)));
      classBloc.add(GetClassesDetStudent(
          body: TodayClassesBody(
        date: '',
        token: token,
        type: CourseType.daily,
        userid: userId,
      )));
      summaryBloc.add(GetClassSummaryStudent(
          ClassSummaryStudentBody(token: token, userid: userId)));
      upcomingBloc.add(GetUpcomingAssignEvent(
          body: UpcomingAssignBody(token: token, userid: userId)));
    }

    PreferredSize appbar() {
      return PreferredSize(
        preferredSize: const Size(double.infinity, 56),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 0),
          color: Colors.white,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width - 40,
                child: Center(
                  child: Image.asset(
                    'assets/logo4.png',
                    width: 59,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              // const Spacer(),
              Stack(
                children: [
                  GestureDetector(
                    onTap: () {},
                    child: Icon(
                      Icons.notifications,
                      color: bryteDarkPurple,
                      size: 24,
                    ),
                  ),
                  const Positioned(
                      top: 1,
                      right: -1,
                      child: CircleAvatar(
                        maxRadius: 7,
                        backgroundColor: Colors.red,
                        child: Text(
                          '2',
                          style: TextStyle(color: Colors.white, fontSize: 10),
                        ),
                      ))
                ],
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      appBar: appbar(),
      body: MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (context) => studentBloc
                ..add(GetAnnouncementEvent(AnnouncementBody(token: token)))),
          BlocProvider(
            create: (context) => summaryBloc
              ..add(GetClassSummaryStudent(
                  ClassSummaryStudentBody(token: token, userid: userId))),
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
              ..add(GetUpcomingAssignEvent(
                  body: UpcomingAssignBody(token: token, userid: userId))),
          ),
        ],
        child: RefreshIndicator(
          onRefresh: () async => onRefresh(),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics()),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 22),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  HeaderHome(),
                  TodayClasses(),
                  UpcomingAssignments(),
                  Announcements(),
                  SizedBox(
                    height: 100,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
    // return SingleChildScrollView(
    //   physics:
    //       const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
    //   child: Container(
    //     padding: const EdgeInsets.symmetric(horizontal: 22),
    //     child: Column(
    //       crossAxisAlignment: CrossAxisAlignment.start,
    //       children: const [
    //         HeaderHome(),
    //         TodayClasses(),
    //         UpcomingAssignments(),
    //         Announcements(),
    //         SizedBox(
    //           height: 100,
    //         )
    //       ],
    //     ),
    //   ),
    // );
  }
}
