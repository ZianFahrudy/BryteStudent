import 'dart:developer';

import 'package:bryte/components/utils/constant.dart';
import 'package:bryte/components/utils/palette.dart';
import 'package:bryte/components/utils/typography.dart';
import 'package:bryte/core/blocs/assignment/assignment_bloc.dart';
import 'package:bryte/core/blocs/course/course_bloc.dart';
import 'package:bryte/core/data/model/course/request/detail_assignment_body.dart';
import 'package:bryte/core/data/model/student/request/general_course_body.dart';
import 'package:bryte/core/di/injection.dart';
import 'package:bryte/presentation/course/pages/contents/general_content.dart';
import 'package:bryte/presentation/course/pages/course_section_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import '../../../core/repo/auth/auth_repository.dart';
import 'contents/attendance_content.dart';
import 'contents/detail_assignment_content.dart';

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

  // final selectedSection = ValueNotifier<int>(1);

  final assignmentBloc = getIt<AssignmentBloc>();
  final courseBloc = getIt<CourseBloc>();

  final token = box.read(KeyConstant.token);
  final userId = box.read(KeyConstant.userId);

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
                  // token: 'fb3e9d4a7cb39d59f5bc0e149d5b7082',
                  userid: userId,
                  // userid: '9457',
                  idCourse: widget.idCourse,
                  // idCourse: '8152',
                  idAssign: widget.idAssign,
                  // idAssign: '26526',
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
              return ValueListenableBuilder(
                valueListenable: widget.selectedSection,
                builder: (context, _, __) => SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      HeaderCourseSection(
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
                      ),
                      widget.selectedSection.value == 0
                          ? const GeneralContent()
                          : widget.selectedSection.value == 1
                              ? DetailAssignmentContent(
                                  state: state,
                                )
                              : widget.selectedSection.value == 2
                                  ? const AttendanceContent()
                                  : widget.selectedSection.value == 3
                                      ? const ScoreContent()
                                      : const ParticipantContent()
                    ],
                  ),
                ),
              );
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
}

class SelectFileTypeLabel extends StatelessWidget {
  const SelectFileTypeLabel(
      {Key? key,
      required this.label,
      required this.icon,
      this.divider = true,
      this.onTap})
      : super(key: key);

  final String label;
  final IconData icon;
  final bool? divider;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: InkWell(
            onTap: onTap,
            child: Row(
              children: [
                Icon(
                  icon,
                  color: Palette.darkPurple,
                ),
                const SizedBox(
                  width: 15,
                ),
                Text(label)
              ],
            ),
          ),
        ),
        if (divider!)
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Divider(
              height: 0,
              thickness: 1,
              color: Palette.lightPB,
            ),
          ),
      ],
    );
  }
}

class LabelAssignment extends StatelessWidget {
  const LabelAssignment({
    Key? key,
    required this.label,
    required this.description,
  }) : super(key: key);

  final String label;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      margin: const EdgeInsets.only(bottom: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Palette.lightPurple,
      ),
      child: IntrinsicHeight(
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Text(
                label,
                style: BryteTypography.titleSemiBold
                    .copyWith(color: Palette.purple),
              ),
            ),
            const SizedBox(
              height: 40,
              child: VerticalDivider(
                width: 0,
                thickness: 2,
                color: Colors.white,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              flex: 1,
              child: Text(
                description,
                style: BryteTypography.titleMedium,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
