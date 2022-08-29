import 'package:bryte/components/utils/constant.dart';
import 'package:bryte/core/blocs/assignment/assignment_bloc.dart';
import 'package:bryte/core/blocs/attend/attend_bloc.dart';
import 'package:bryte/core/blocs/course/course_bloc.dart';
import 'package:bryte/core/data/model/course/request/assignment_per_course_body.dart';
import 'package:bryte/core/data/model/course/request/attendance_body.dart';
import 'package:bryte/core/data/model/course/response/course_model.dart';
import 'package:bryte/core/di/injection.dart';
import 'package:bryte/presentation/course/pages/contents/general_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart' as bloc;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/route_manager.dart';

import 'package:get_storage/get_storage.dart';

import '../../../core/data/model/student/request/general_course_body.dart';
import '../local_widget/header_course_section.dart';
import 'contents/assignment_content.dart';
import 'contents/attendance_content.dart';
import 'contents/participant_content.dart';
import 'contents/score_content.dart';

class SectionGeneralPage extends StatefulWidget {
  const SectionGeneralPage({
    Key? key,
    required this.dataCourse,
  }) : super(key: key);
  final DataCourseModel dataCourse;

  @override
  State<SectionGeneralPage> createState() => _SectionGeneralPageState();
}

class _SectionGeneralPageState extends State<SectionGeneralPage> {
  final selectedSection = ValueNotifier<int>(0);

  final selectedAssignment = ValueNotifier<int?>(null);

  final courseBloc = getIt<CourseBloc>();
  final assignmentBloc = getIt<AssignmentBloc>();
  final attendBloc = getIt<AttendBloc>();

  final box = GetStorage();

  @override
  Widget build(BuildContext context) {
    final token = box.read(KeyConstant.token);
    final userId = box.read(KeyConstant.userId);

    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Get.back<void>();
          },
          child: Row(
            children: const [
              Icon(
                Icons.chevron_left,
                color: Colors.white,
              ),
              Text('Back')
            ],
          ),
        ),
      ),
      body: bloc.MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => courseBloc
              ..add(GetGeneralCourseEvent(
                body: GeneralCourseBody(
                  wstoken: token,
                  wsfunction: 'core_course_get_contents',
                  moodlewsrestformat: 'json',
                  courseid: int.parse(widget.dataCourse.idCourse),
                ),
              )),
          ),
          BlocProvider(
            create: (context) => assignmentBloc
              ..add(
                GetAssignmentPerCourseEvent(
                  body: AssignmentPerCourseBody(
                    token: token,
                    userid: userId,
                    idcourse: widget.dataCourse.idCourse,
                  ),
                ),
              ),
          ),
          BlocProvider(
            create: (context) => attendBloc
              ..add(
                GetAttendanceEvent(
                  body: AttendanceBody(
                    token: 'fb3e9d4a7cb39d59f5bc0e149d5b7082',
                    userid: '9457',
                    idCourse: '8152',
                  ),
                ),
              ),
          ),
        ],
        child: ValueListenableBuilder(
          valueListenable: selectedSection,
          builder: (context, v, c) => SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                HeaderCourseSection(
                  courseAssignName: widget.dataCourse.course,
                  teacherName: widget.dataCourse.teacherName,
                  bgColor: widget.dataCourse.bgColor_1,
                  selectedSection: selectedSection,
                  isMain: false,
                ),
                (selectedSection.value == 0)
                    ? GeneralContent(
                        idCourse: widget.dataCourse.idCourse,
                        teacherName: widget.dataCourse.teacherName,
                        bgColor: widget.dataCourse.bgColor_1,
                      )
                    : selectedSection.value == 1
                        ? AssignmentContent(
                            selectedSection: selectedSection,
                            dataCourse: widget.dataCourse,
                            bgColor: widget.dataCourse.bgColor_1,
                          )
                        : selectedSection.value == 2
                            ? const AttendanceContent()
                            : selectedSection.value == 3
                                ? const ScoreContent()
                                : const ParticipantContent()
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ParticipantModelDummy {
  final String name;
  final String imageUrl;
  final int level;
  ParticipantModelDummy({
    required this.name,
    required this.imageUrl,
    required this.level,
  });
}

List<ParticipantModelDummy> listParticipants = [
  ParticipantModelDummy(
      name: 'You',
      imageUrl: 'https://randomuser.me/api/portraits/men/43.jpg',
      level: 1),
  ParticipantModelDummy(
      name: 'Alessandro Stefan Yahya',
      imageUrl: 'https://randomuser.me/api/portraits/men/79.jpg',
      level: 1),
  ParticipantModelDummy(
      name: 'Kevin Matthew Kandi',
      imageUrl: 'https://randomuser.me/api/portraits/men/8.jpg',
      level: 3),
  ParticipantModelDummy(
      name: 'Medelyn Angel Hartono',
      imageUrl: 'https://randomuser.me/api/portraits/women/9.jpg',
      level: 3)
];

class ReportModelDummy {
  final String weekNumber;
  final String date;
  final String statusAttend;
  final String time;
  ReportModelDummy({
    required this.weekNumber,
    required this.date,
    required this.time,
    required this.statusAttend,
  });
}

List<ReportModelDummy> reportList = [
  ReportModelDummy(
      weekNumber: 'Week 1',
      date: 'Wed 8 Sep 2021',
      time: ' 8AM-10:30PM',
      statusAttend: 'PRESENT'),
  ReportModelDummy(
      weekNumber: 'Week 2',
      date: 'Wed 15 Sep 2021',
      time: ' 8AM-10:30PM',
      statusAttend: 'WAITING'),
  ReportModelDummy(
      weekNumber: 'Week 1',
      date: 'Wed 20 Sep 2021',
      time: ' 8AM-10:30PM',
      statusAttend: 'NOT DUE'),
];
