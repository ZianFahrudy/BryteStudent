import 'dart:developer';

import 'package:bryte/components/utils/constant.dart';
import 'package:bryte/core/blocs/assignment/assignment_bloc.dart';
import 'package:bryte/core/blocs/attend/bloc/attend_list_bloc.dart';
import 'package:bryte/core/blocs/course/course_bloc.dart';
import 'package:bryte/core/blocs/gpa_grade/gpa_grade_bloc.dart';
import 'package:bryte/core/blocs/participant/participant_bloc.dart';
import 'package:bryte/core/data/model/course/request/detail_assignment_body.dart';
import 'package:bryte/core/data/model/student/request/general_course_body.dart';
import 'package:bryte/core/di/injection.dart';
import 'package:bryte/presentation/course/pages/contents/general_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import '../../../core/blocs/attend/attend_bloc.dart';
import '../../../core/blocs/moodle/moodle_bloc.dart';
import '../../../core/blocs/score/score_bloc.dart';
import '../../../core/data/model/course/request/attendance_body.dart';
import '../../../core/data/model/course/request/participant_body.dart';
import '../../../core/data/model/course/request/score_body.dart';
import '../../../core/data/model/student/response/course_general_model.dart';
import '../../../core/repo/auth/auth_repository.dart';
import '../local_widget/header_course_section.dart';
import 'contents/attendance_content.dart';
import 'contents/detail_assignment_content.dart';
import 'contents/participant_content.dart';
import 'contents/score_content.dart';

class DetailAssignmentPage extends StatefulWidget {
  const DetailAssignmentPage({
    Key? key,
    required this.selectedSection,
    required this.courseAssignName,
    required this.bgColor,
    required this.teacherName,
    required this.idCourse,
    required this.idAssign,
  }) : super(key: key);

  final ValueNotifier<int> selectedSection;
  final String courseAssignName;
  final String teacherName;
  final String idCourse;
  final String idAssign;
  final String bgColor;

  @override
  State<DetailAssignmentPage> createState() => _DetailAssignmentPageState();
}

class _DetailAssignmentPageState extends State<DetailAssignmentPage> {
  @override
  void initState() {
    widget.selectedSection.value = 1;
    super.initState();
  }

  final assignmentBloc = getIt<AssignmentBloc>();
  final courseBloc = getIt<CourseBloc>();
  final moodleBloc = getIt<MoodleBloc>();
  final gpaGradeBloc = getIt<GpaGradeBloc>();
  final participantBloc = getIt<ParticipantBloc>();
  final token = box.read(KeyConstant.token);
  final userId = box.read(KeyConstant.userId);
  final attendBloc = getIt<AttendBloc>();
  final scoreBloc = getIt<ScoreBloc>();
  final attendListBloc = getIt<AttendListBloc>();

  List<CourseGeneralModel> courseGeneralData = [];

  final ItemScrollController itemScrollController = ItemScrollController();
  final ItemPositionsListener itemPositionsListener =
      ItemPositionsListener.create();

  final selectedValue = ValueNotifier<String>('');

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => assignmentBloc
            ..add(
              GetDetailAssignmentEvent(
                body: DetailAssignmentBody(
                  token: token,
                  userid: userId,
                  idCourse: widget.idCourse,
                  idAssign: widget.idAssign,
                ),
              ),
            ),
        ),
        BlocProvider(
          create: (context) => courseBloc
            ..add(GetGeneralCourseEvent(
              body: GeneralCourseBody(
                wstoken: token,
                wsfunction: 'core_course_get_contents',
                moodlewsrestformat: 'json',
                courseid: int.parse(widget.idCourse),
              ),
            )),
        ),
        BlocProvider(
          create: (context) => moodleBloc,
        ),
        BlocProvider(
          create: (context) => attendBloc,
        ),
        BlocProvider(
          create: (context) => attendListBloc
            ..add(
              GetAttendListEvent(
                body: AttendanceBody(
                  token: token,
                  userid: userId,
                  idCourse: widget.idCourse,
                ),
              ),
            ),
        ),
        BlocProvider(
          create: (context) => participantBloc
            ..add(
              GetParticipantEvent(
                body: ParticipantBody(
                  token: token,
                  userid: userId,
                  idCourse: widget.idCourse,
                  page: 1,
                ),
              ),
            ),
        ),
        BlocProvider(
          create: (context) => scoreBloc
            ..add(
              GetScoreEvent(
                body: ScoreBody(
                  token: token,
                  userid: userId,
                  idCourse: widget.idCourse,
                ),
              ),
            ),
        ),
      ],
      child: Scaffold(
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
        body: BlocConsumer<AssignmentBloc, AssignmentState>(
          listener: (context, state) {
            if (state is DetailAssignmentSuccess) {
              log('Detail Assignment Success');
            } else if (state is AssignmentFailure) {
              log('Detail Assignment Gagal');
            }
          },
          builder: (context, state) {
            if (state is DetailAssignmentSuccess) {
              return _buildDetailAssignment(state);
            } else if (state is AssignmentLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return const Center(
                child: Text('Something Error'),
              );
            }
          },
        ),
      ),
    );
  }

  ValueListenableBuilder<int> _buildDetailAssignment(
      DetailAssignmentSuccess state) {
    return ValueListenableBuilder(
      valueListenable: widget.selectedSection,
      builder: (context, _, __) => SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HeaderCourseSection(
              selectedValue: selectedValue,
              idCourse: widget.idCourse,
              bgColor: widget.bgColor,
              courseAssignName: widget.courseAssignName,
              teacherName: state.response.data[0].teacherName,
              onTapGeneral: () {
                widget.selectedSection.value = 0;
              },
              onTapParticipant: () {
                widget.selectedSection.value = 4;
              },
              onTapScore: () {
                widget.selectedSection.value = 3;
              },
              onTapAssignment: () {
                widget.selectedSection.value = 1;
              },
              onTapAttendance: () {
                widget.selectedSection.value = 2;
              },
              selectedSection: widget.selectedSection,
              isMain: true,
              onChanged: (v) {
                selectedValue.value = v!;
                for (var i = 0; i < courseGeneralData.length; i++) {
                  if (selectedValue.value ==
                      courseGeneralData[i].id.toString()) {
                    itemScrollController.scrollTo(
                        index: i, duration: const Duration(milliseconds: 250));
                  }
                }
              },
            ),
            widget.selectedSection.value == 0
                ? GeneralContent(
                    itemPositionsListener: itemPositionsListener,
                    itemScrollController: itemScrollController,
                    courseGeneralData: courseGeneralData,
                    idCourse: widget.idCourse,
                    teacherName: widget.teacherName,
                    bgColor: widget.bgColor,
                  )
                : widget.selectedSection.value == 1
                    ? DetailAssignmentContent(
                        token: token,
                        state: state,
                        userid: userId,
                        moodleBloc: moodleBloc,
                      )
                    : widget.selectedSection.value == 2
                        ? AttendanceContent(
                            idCourse: widget.idCourse,
                            token: token,
                            userId: userId,
                            attendListBloc: attendListBloc,
                            attendBloc: attendBloc,
                          )
                        : widget.selectedSection.value == 3
                            ? ScoreContent(
                                idCourse: widget.idCourse,
                                gpaGradeBloc: gpaGradeBloc,
                              )
                            : ParticipantContent(
                                idCourse: widget.idCourse,
                                participantBloc: participantBloc,
                              )
          ],
        ),
      ),
    );
  }
}
