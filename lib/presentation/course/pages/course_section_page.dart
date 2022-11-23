import 'package:bryte/components/utils/constant.dart';
import 'package:bryte/components/utils/typography.dart';
import 'package:bryte/core/blocs/assignment/assignment_bloc.dart';
import 'package:bryte/core/blocs/attend/attend_bloc.dart';
import 'package:bryte/core/blocs/attend/bloc/attend_list_bloc.dart';
import 'package:bryte/core/blocs/course/course_bloc.dart';
import 'package:bryte/core/blocs/participant/participant_bloc.dart';
import 'package:bryte/core/blocs/score/score_bloc.dart';
import 'package:bryte/core/data/model/course/request/assignment_per_course_body.dart';
import 'package:bryte/core/data/model/course/request/attendance_body.dart';
import 'package:bryte/core/data/model/course/request/participant_body.dart';
import 'package:bryte/core/data/model/course/request/score_body.dart';
import 'package:bryte/core/data/model/course/response/course_model.dart';
import 'package:bryte/core/di/injection.dart';
import 'package:bryte/presentation/course/pages/contents/general_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart' as bloc;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/route_manager.dart';

import 'package:get_storage/get_storage.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../../../core/blocs/gpa_grade/gpa_grade_bloc.dart';
import '../../../core/data/model/student/request/general_course_body.dart';
import '../../../core/data/model/student/response/course_general_model.dart';
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
  final gpaGradeBloc = getIt<GpaGradeBloc>();
  final participantBloc = getIt<ParticipantBloc>();
  final scoreBloc = getIt<ScoreBloc>();
  final attendListBloc = getIt<AttendListBloc>();

  final box = GetStorage();

  List<CourseGeneralModel> courseGeneralData = [];

  final ItemScrollController itemScrollController = ItemScrollController();
  final ItemPositionsListener itemPositionsListener =
      ItemPositionsListener.create();

  final selectedValue = ValueNotifier<String>('');

  @override
  Widget build(BuildContext context) {
    final token = box.read(KeyConstant.token);
    final userId = box.read(KeyConstant.userId);

    return Scaffold(
      appBar: AppBar(
        leadingWidth: 100,
        centerTitle: true,
        title: Image.asset(
          AssetConstant.bryteLogoWhite,
          width: 59,
        ),
        leading: GestureDetector(
          onTap: () {
            Get.back<void>();
          },
          child: Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Row(
              children: [
                const Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white,
                  size: 16,
                ),
                Text(
                  'Back',
                  style: BryteTypography.bodyExtraBold.copyWith(
                    fontWeight: FontWeight.w700,
                    fontSize: 15,
                  ),
                )
              ],
            ),
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
            create: (context) => attendListBloc
              ..add(
                GetAttendListEvent(
                  body: AttendanceBody(
                    token: token,
                    userid: userId,
                    idCourse: widget.dataCourse.idCourse,
                  ),
                ),
              ),
          ),
          BlocProvider(create: (context) => attendBloc),
          BlocProvider(
            create: (context) => participantBloc
              ..add(
                GetParticipantEvent(
                  body: ParticipantBody(
                    token: token,
                    userid: userId,
                    idCourse: widget.dataCourse.idCourse,
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
                        idCourse: widget.dataCourse.idCourse)),
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
                  selectedValue: selectedValue,
                  idCourse: widget.dataCourse.idCourse,
                  courseAssignName: widget.dataCourse.course,
                  teacherName: widget.dataCourse.teacherName,
                  bgColor: widget.dataCourse.bgColor_1,
                  selectedSection: selectedSection,
                  isMain: false,
                  onChanged: (v) {
                    selectedValue.value = v!;

                    for (var i = 0; i < courseGeneralData.length; i++) {
                      if (selectedValue.value ==
                          courseGeneralData[i].id.toString()) {
                        itemScrollController.scrollTo(
                            index: i,
                            duration: const Duration(milliseconds: 250));
                      }
                    }
                  },
                ),
                (selectedSection.value == 0)
                    ? GeneralContent(
                        itemPositionsListener: itemPositionsListener,
                        itemScrollController: itemScrollController,
                        courseGeneralData: courseGeneralData,
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
                            ? AttendanceContent(
                                idCourse: widget.dataCourse.idCourse,
                                token: token,
                                userId: userId,
                                attendListBloc: attendListBloc,
                                attendBloc: attendBloc,
                              )
                            : selectedSection.value == 3
                                ? ScoreContent(
                                    idCourse: widget.dataCourse.idCourse,
                                    gpaGradeBloc: gpaGradeBloc,
                                  )
                                : ParticipantContent(
                                    idCourse: widget.dataCourse.idCourse,
                                    participantBloc: participantBloc,
                                  )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
