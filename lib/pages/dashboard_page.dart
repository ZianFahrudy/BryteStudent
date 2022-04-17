import 'package:bryte/core/di/injection.dart';
import 'package:bryte/core/model/student/request/announcement_body.dart';
import 'package:bryte/core/model/student/request/class_summary_student_body.dart';
import 'package:bryte/core/model/student/request/today_classes_body.dart';
import 'package:bryte/core/model/student/request/upcoming_assign_body.dart';
import 'package:bryte/core/student/class/class_bloc.dart';
import 'package:bryte/core/student/student_bloc.dart';
import 'package:bryte/core/student/summary/summary_bloc.dart';
import 'package:bryte/core/student/upcoming/upcoming_bloc.dart';
import 'package:bryte/pages/home/calender_page.dart';
import 'package:bryte/pages/home/course_page.dart';
import 'package:bryte/utils/constant.dart';
import 'package:bryte/utils/enum.dart';
import 'package:flutter/material.dart';
import 'package:bryte/pages/home/home_page.dart';
import 'package:bryte/pages/home/profile_page.dart';
import 'package:bryte/theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  static const route = '/DashbordPage';

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final currentIndex = ValueNotifier<int>(0);
  final studentBloc = getIt<StudentBloc>();
  final summaryBloc = getIt<SummaryBloc>();
  final classBloc = getIt<ClassBloc>();
  final upcomingBloc = getIt<UpcomingBloc>();

  final box = GetStorage();

  @override
  Widget build(BuildContext context) {
    Widget customBottomNav() {
      return ValueListenableBuilder(
        valueListenable: currentIndex,
        builder: (context, _, __) => Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(40)),
            boxShadow: [
              BoxShadow(
                color: Color(0xffDBDBDB),
                spreadRadius: 1,
                blurRadius: 1,
              ),
            ],
          ),
          margin: const EdgeInsets.all(10),
          child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(40)),
            child: BottomAppBar(
              shape: const CircularNotchedRectangle(),
              clipBehavior: Clip.antiAlias,
              child: BottomNavigationBar(
                  onTap: (val) {
                    currentIndex.value = val;
                  },
                  currentIndex: currentIndex.value,
                  type: BottomNavigationBarType.fixed,
                  items: [
                    BottomNavigationBarItem(
                        icon: Column(
                          children: [
                            Container(
                              margin: const EdgeInsets.only(top: 6),
                              child: Icon(Icons.home_outlined,
                                  size: 24,
                                  color: currentIndex.value == 0
                                      ? brytepurple
                                      : bryteGreyLight),
                            ),
                            Text(
                              'Home',
                              style: currentIndex.value == 0
                                  ? brytStylebtnActive
                                  : brytStylebtnNonActive,
                            )
                          ],
                        ),
                        label: ''),
                    BottomNavigationBarItem(
                        icon: Column(
                          children: [
                            Container(
                                margin: const EdgeInsets.only(top: 6),
                                child: Icon(Icons.school,
                                    size: 24,
                                    color: currentIndex.value == 1
                                        ? brytepurple
                                        : bryteGreyLight)),
                            Text(
                              'Courses',
                              style: currentIndex.value == 1
                                  ? brytStylebtnActive
                                  : brytStylebtnNonActive,
                            )
                          ],
                        ),
                        label: ''),
                    BottomNavigationBarItem(
                        icon: Column(
                          children: [
                            Container(
                                margin: const EdgeInsets.only(top: 6),
                                child: Icon(Icons.calendar_today_rounded,
                                    size: 24,
                                    color: currentIndex.value == 2
                                        ? brytepurple
                                        : bryteGreyLight)),
                            Text(
                              'Calendar',
                              style: currentIndex.value == 2
                                  ? brytStylebtnActive
                                  : brytStylebtnNonActive,
                            )
                          ],
                        ),
                        label: ''),
                    BottomNavigationBarItem(
                        icon: Column(
                          children: [
                            Container(
                                margin: const EdgeInsets.only(top: 6),
                                child: const Image(
                                  image: AssetImage('assets/profile_user.png'),
                                  width: 24,
                                  height: 24,
                                )),
                            Text(
                              'Profile',
                              style: currentIndex.value == 3
                                  ? brytStylebtnActive
                                  : brytStylebtnNonActive,
                            )
                          ],
                        ),
                        label: ''),
                  ]),
            ),
          ),
        ),
      );
    }

    Widget body() {
      switch (currentIndex.value) {
        case 0:
          return const HomePage();
        case 1:
          return const CoursePage();
        case 2:
          return const CalenderPage();
        case 3:
          return const ProfilePage();

        default:
          return const HomePage();
      }
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

    PreferredSize appbarPurple() {
      return PreferredSize(
        preferredSize: const Size(double.infinity, 56),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 0),
          color: const Color(0xff58329C).withOpacity(0.8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width - 40,
                child: Center(
                  child: Image.asset(
                    'assets/splash.png',
                    width: 59,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

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

    return MultiBlocProvider(
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
        child: ValueListenableBuilder(
          valueListenable: currentIndex,
          builder: (context, _, __) => SafeArea(
            child: Scaffold(
              extendBody: true,
              backgroundColor: Colors.white,
              appBar: currentIndex.value != 0 ? appbarPurple() : appbar(),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerDocked,
              bottomNavigationBar: customBottomNav(),
              body: body(),
            ),
          ),
        ),
      ),
    );
  }
}
