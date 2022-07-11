import 'package:bryte/components/utils/constant.dart';
import 'package:bryte/core/blocs/course/course_bloc.dart';
import 'package:bryte/core/data/model/course/response/course_model.dart';
import 'package:bryte/core/di/injection.dart';
import 'package:bryte/presentation/course/pages/all_scores_page.dart';
import 'package:bryte/presentation/course/pages/contents/general_content.dart';
import 'package:bryte/presentation/course/pages/detail_profile_participant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart' as bloc;
import 'package:get/route_manager.dart';

import 'package:bryte/components/utils/palette.dart';
import 'package:bryte/components/utils/typography.dart';
import 'package:get_storage/get_storage.dart';

import '../../../core/data/model/student/request/general_course_body.dart';

class SectionGeneralPage extends StatefulWidget {
  const SectionGeneralPage({
    Key? key,
    // required this.courseId,
    required this.dataCourse,
  }) : super(key: key);
  final DataCourseModel dataCourse;
  // final int courseId;

  @override
  State<SectionGeneralPage> createState() => _SectionGeneralPageState();
}

class _SectionGeneralPageState extends State<SectionGeneralPage> {
  final selectedSection = ValueNotifier<int>(0);

  final selectedAssignment = ValueNotifier<int?>(null);

  final courseBloc = getIt<CourseBloc>();

  final box = GetStorage();

  @override
  Widget build(BuildContext context) {
    final token = box.read(KeyConstant.token);

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
      body: bloc.BlocProvider(
        create: (context) => courseBloc
          ..add(GetGeneralCourseEvent(
            body: GeneralCourseBody(
              wstoken: token,
              wsfunction: 'core_course_get_contents',
              moodlewsrestformat: 'json',
              courseid: int.parse(widget.dataCourse.idCourse),
            ),
          )),
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
                    ? const GeneralContent()
                    : selectedSection.value == 1
                        ? const AssignmentContent(
                            // onTap: () => Get.to(
                            //   () => DetailAssignmentPage(
                            //       bgColor: widget.da,
                            //       selectedSection: selectedSection),
                            //   transition: Transition.rightToLeftWithFade,
                            // ),
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

class ParticipantContent extends StatelessWidget {
  const ParticipantContent({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Row(
            children: [
              const Text(
                'Participants',
                style: BryteTypography.headerExtraBold,
              ),
              const SizedBox(width: 5),
              Text(
                '1',
                style: BryteTypography.headerExtraBold.copyWith(
                  fontSize: 16,
                  color: Palette.purple,
                ),
              ),
            ],
          ),
        ),
        const Divider(
          thickness: 1,
          height: 0,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            children: List.generate(
              listParticipants.length,
              (index) => Card(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    bottomLeft: Radius.circular(30),
                    topRight: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                ),
                child: InkWell(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(30),
                    bottomLeft: Radius.circular(30),
                    topRight: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                  onTap: () => Get.to(() => const DetailProfileParticipant()),
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Row(
                      children: [
                        Stack(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(3),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: listParticipants[index].level < 3
                                    ? Palette.grey2
                                    : Palette.orange2,
                              ),
                              child: CircleAvatar(
                                radius: 25,
                                backgroundImage: NetworkImage(
                                  listParticipants[index].imageUrl,
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              left: 0,
                              right: 0,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(
                                    15,
                                  ),
                                ),
                                margin: const EdgeInsets.symmetric(
                                  horizontal: 5,
                                ),
                                padding: const EdgeInsets.all(2),
                                height: 16,
                                child: Container(
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      color: listParticipants[index].level < 3
                                          ? Palette.grey1
                                          : Palette.orange1,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      const Spacer(),
                                      Text(
                                        'LVL',
                                        style: BryteTypography.bodyRegular
                                            .copyWith(
                                                color: Colors.white,
                                                fontSize: 8),
                                      ),
                                      const Spacer(),
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 5),
                                        decoration: BoxDecoration(
                                            color:
                                                listParticipants[index].level <
                                                        3
                                                    ? Palette.grey2
                                                    : Palette.orange2,
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Text(
                                          listParticipants[index]
                                              .level
                                              .toString(),
                                          style: BryteTypography.bodyRegular
                                              .copyWith(color: Colors.white),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          width: 30,
                        ),
                        Text(
                          listParticipants[index].name,
                          style: BryteTypography.titleExtraBold,
                        ),
                        const Spacer(),
                        const Icon(
                          Icons.chevron_right,
                          color: Palette.purple,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}

class HeaderCourseSection extends StatelessWidget {
  const HeaderCourseSection({
    Key? key,
    required this.selectedSection,
    this.isMain = false,
    this.onTapScore,
    this.onTapGeneral,
    this.onTapAssignment,
    this.onTapParticipant,
    this.onTapAttendance,
    required this.courseAssignName,
    required this.teacherName,
    required this.bgColor,
    // required this.dataCourse,
  }) : super(key: key);

  final ValueNotifier<int> selectedSection;
  final bool? isMain;
  final Function()? onTapGeneral;
  final Function()? onTapScore;
  final Function()? onTapAssignment;
  final Function()? onTapParticipant;
  final Function()? onTapAttendance;
  final String courseAssignName;
  final String teacherName;
  final String bgColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 121,
      color: Color(
        int.parse(
          bgColor.replaceAll('#', '0xff'),
        ),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 10,
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.black.withOpacity(.2),
                  ),
                  child: CircleAvatar(
                    radius: 20,
                    backgroundColor:
                        Color(int.parse(bgColor.replaceAll('#', '0xff'))),
                  ),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        courseAssignName,
                        style: BryteTypography.headerExtraBold.copyWith(
                          color: Colors.white,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        teacherName,
                        style: BryteTypography.titleMedium.copyWith(
                          color: Colors.white,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(color: Colors.black.withOpacity(.2)),
              ),
            ),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics(),
              ),
              child: Row(
                children: [
                  const SizedBox(width: 20),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Section',
                        style: BryteTypography.titleMedium
                            .copyWith(color: Colors.white),
                      ),
                      const SizedBox(width: 10),
                      InkWell(
                        onTap: isMain!
                            ? onTapGeneral
                            : () {
                                selectedSection.value = 0;
                              },
                        child: Container(
                          height: 25,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Row(
                            children: [
                              Text(
                                'General',
                                style: BryteTypography.titleSemiBold.copyWith(
                                  color: selectedSection.value == 0
                                      ? Colors.black
                                      : Palette.grey,
                                ),
                              ),
                              Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                height: 25,
                                width: 2,
                                color: Palette.orange,
                              ),
                              const Icon(
                                Icons.keyboard_arrow_down,
                              )
                            ],
                          ),
                        ),
                      ),
                      Container(
                        height: 50,
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        color: Colors.black.withOpacity(.2),
                        width: 2,
                      ),
                      Row(
                        children: [
                          CourseTabButton(
                            label: 'Assignments',
                            color: selectedSection.value == 1
                                ? Colors.black
                                : Palette.grey,
                            onTap: isMain!
                                ? onTapAssignment
                                : () {
                                    selectedSection.value = 1;
                                  },
                          ),
                          CourseTabButton(
                            label: 'Attendances',
                            color: selectedSection.value == 2
                                ? Colors.black
                                : Palette.grey,
                            onTap: isMain!
                                ? onTapAttendance
                                : () {
                                    selectedSection.value = 2;
                                  },
                          ),
                          CourseTabButton(
                            label: 'Scores',
                            color: selectedSection.value == 3
                                ? Colors.black
                                : Palette.grey,
                            onTap: isMain!
                                ? onTapScore
                                : () {
                                    selectedSection.value = 3;
                                  },
                          ),
                          CourseTabButton(
                            label: 'Participants',
                            color: selectedSection.value == 4
                                ? Colors.black
                                : Palette.grey,
                            onTap: isMain!
                                ? onTapParticipant
                                : () {
                                    selectedSection.value = 4;
                                  },
                          ),
                        ],
                      )
                    ],
                  ),
                  const SizedBox(width: 20),
                ],
              ),
            ),
          )
        ],
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

class ScoreContent extends StatelessWidget {
  const ScoreContent({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Scores',
                style: BryteTypography.headerExtraBold,
              ),
              InkWell(
                onTap: () => Get.to(
                  () => const AllScorePage(),
                ),
                child: Row(
                  children: [
                    Text(
                      'All Scores',
                      style: BryteTypography.titleSemiBold.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Palette.purple,
                      ),
                    ),
                    const Icon(
                      Icons.chevron_right,
                      size: 20,
                      color: Palette.purple,
                    )
                  ],
                ),
              )
            ],
          ),
        ),
        const Divider(
          thickness: 1,
          height: 0,
        ),
        Container(
          padding: const EdgeInsets.all(15),
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Palette.lightPurple,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Final Grade',
                    style:
                        BryteTypography.headerSemiBold.copyWith(fontSize: 18),
                  ),
                  const SizedBox(width: 5),
                  const Icon(
                    Icons.info_outline,
                    size: 18,
                    color: Palette.grey,
                  )
                ],
              ),
              Text(
                'A',
                style: BryteTypography.headerExtraBold.copyWith(
                  fontSize: 70,
                  color: Palette.purple,
                ),
              )
            ],
          ),
        ),
        const Divider(
          height: 0,
          thickness: 1,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: IntrinsicHeight(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Text(
                        'Teaching',
                        style: BryteTypography.headerSemiBold
                            .copyWith(fontSize: 18),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(width: 10),
                        Text(
                          'Assessment',
                          style: BryteTypography.headerSemiBold
                              .copyWith(fontSize: 18),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(width: 5),
                        const Icon(
                          Icons.info_outline,
                          size: 18,
                          color: Palette.grey,
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      '88',
                      style: BryteTypography.headerExtraBold.copyWith(
                        fontSize: 70,
                        fontWeight: FontWeight.w500,
                        color: Palette.purple,
                      ),
                    ),
                    Text(
                      'Weight 30%',
                      style: BryteTypography.titleMedium
                          .copyWith(fontStyle: FontStyle.italic),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: VerticalDivider(
                    thickness: 2,
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Text(
                        'Mid-Semester',
                        style: BryteTypography.headerSemiBold
                            .copyWith(fontSize: 18),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(width: 10),
                        Text(
                          'Exam',
                          style: BryteTypography.headerSemiBold
                              .copyWith(fontSize: 18),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(width: 5),
                        const Icon(
                          Icons.info_outline,
                          size: 18,
                          color: Palette.grey,
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      '91',
                      style: BryteTypography.headerExtraBold.copyWith(
                        fontSize: 70,
                        fontWeight: FontWeight.w500,
                        color: Palette.purple,
                      ),
                    ),
                    Text(
                      'Weight 35%',
                      style: BryteTypography.titleMedium
                          .copyWith(fontStyle: FontStyle.italic),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        const Divider(
          height: 0,
          thickness: 1,
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Mid-Semester',
              style: BryteTypography.headerSemiBold.copyWith(fontSize: 18),
              textAlign: TextAlign.center,
            ),
            const SizedBox(width: 5),
            const Icon(
              Icons.info_outline,
              size: 18,
              color: Palette.grey,
            ),
          ],
        ),
        Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '100',
                style: BryteTypography.headerExtraBold.copyWith(
                  fontSize: 70,
                  fontWeight: FontWeight.w500,
                  color: Palette.purple,
                ),
              ),
              Text(
                'Weight 35%',
                style: BryteTypography.titleMedium
                    .copyWith(fontStyle: FontStyle.italic),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class AssignmentContent extends StatelessWidget {
  const AssignmentContent({
    Key? key,
    this.onTap,
  }) : super(key: key);

  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: Text(
            'Assignments',
            style: BryteTypography.headerExtraBold,
          ),
        ),
        const Divider(
          height: 0,
          thickness: 1,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              Row(
                children: [
                  const Text(
                    'Upcoming',
                    style: BryteTypography.titleMedium,
                  ),
                  const SizedBox(width: 5),
                  Text(
                    '1',
                    style: BryteTypography.titleMedium
                        .copyWith(color: Palette.purple),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                child: InkWell(
                  borderRadius: BorderRadius.circular(15),
                  onTap: onTap,
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: IntrinsicHeight(
                      child: Row(
                        children: [
                          Column(
                            children: [
                              Text(
                                '14 Sep',
                                style: BryteTypography.bodyRegular.copyWith(
                                    color: Palette.purple,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                '23:59',
                                style: BryteTypography.titleSemiBold.copyWith(
                                  color: Palette.purple,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          const VerticalDivider(
                            thickness: 2,
                            width: 20,
                            color: Palette.lightPurple,
                          ),
                          const Expanded(
                            child: Text(
                              'Assignment - Week week weekkwe wkkwewk',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 5),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Palette.red.withOpacity(0.05)),
                            child: Text(
                              'NOT ATTEMPTED',
                              style: BryteTypography.bodyMedium
                                  .copyWith(color: Palette.red),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                child: InkWell(
                  borderRadius: BorderRadius.circular(15),
                  onTap: onTap,
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: IntrinsicHeight(
                      child: Row(
                        children: [
                          Column(
                            children: [
                              Text(
                                '14 Sep',
                                style: BryteTypography.bodyRegular.copyWith(
                                    color: Palette.purple,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                '23:59',
                                style: BryteTypography.titleSemiBold.copyWith(
                                  color: Palette.purple,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          const VerticalDivider(
                            thickness: 2,
                            width: 20,
                            color: Palette.lightPurple,
                          ),
                          const Expanded(
                            child: Text(
                              'Introduction to Design wewe kk...',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 5),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Palette.squash500.withOpacity(0.05)),
                            child: Text(
                              'SUBMITTED',
                              style: BryteTypography.bodyMedium
                                  .copyWith(color: Palette.squash500),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}

class AttendanceContent extends StatelessWidget {
  const AttendanceContent({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: Text(
            'Attendances',
            style: BryteTypography.headerExtraBold,
          ),
        ),
        const Divider(
          height: 0,
          thickness: 1,
        ),
        const SizedBox(
          height: 10,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Palette.lightPurple),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    child: Column(
                      children: [
                        const Text(
                          'Absence Left',
                          style: BryteTypography.headerSemiBold,
                        ),
                        Text(
                          '4',
                          style: BryteTypography.headerExtraBold
                              .copyWith(fontSize: 20, color: Palette.purple),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 5),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Palette.lightPurple),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    child: Column(
                      children: [
                        const Text(
                          'Attendance',
                          style: BryteTypography.headerSemiBold,
                        ),
                        Text(
                          '100%',
                          style: BryteTypography.headerExtraBold
                              .copyWith(fontSize: 20, color: Palette.purple),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Text(
            'Full Report',
            style: BryteTypography.headerSemiBold,
          ),
        ),
        Column(
          children: reportList
              .map((e) => Container(
                    padding: const EdgeInsets.all(20),
                    child: Row(
                      children: [
                        Container(
                            margin: const EdgeInsets.only(right: 20),
                            child: Text(e.weekNumber)),
                        Expanded(
                          child: Column(
                            children: [
                              Text(
                                e.date,
                              ),
                              Text(
                                e.time,
                              ),
                            ],
                          ),
                        ),
                        InkWell(
                          borderRadius: BorderRadius.circular(15),
                          onTap: e.statusAttend == 'WAITING' ? () {} : null,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 5),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: e.statusAttend == 'WAITING'
                                    ? Palette.purple
                                    : Palette.lightGrey.withOpacity(0.2)),
                            child: Text(
                              e.statusAttend == 'WAITING'
                                  ? 'ATTEND'
                                  : e.statusAttend,
                              style: BryteTypography.bodyMedium.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: e.statusAttend == 'PRESENT'
                                      ? Palette.green
                                      : e.statusAttend == 'WAITING'
                                          ? Colors.white
                                          : Palette.lightGrey),
                            ),
                          ),
                        )
                      ],
                    ),
                  ))
              .toList(),
        )
      ],
    );
  }
}

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

class CourseTabButton extends StatelessWidget {
  const CourseTabButton({
    Key? key,
    required this.label,
    required this.color,
    this.onTap,
  }) : super(key: key);

  final String label;
  final Color color;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 25,
        margin: const EdgeInsets.only(right: 5),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Text(
          label,
          style: BryteTypography.titleSemiBold.copyWith(
            color: color,
          ),
        ),
      ),
    );
  }
}

List<String> listText = [
  'Explain the importance of Design for Manufacturing and Assembly, distinguish DfM and DfA, and describe their similaritiesApply Design for Assembly principles and describe rationale behind process and material selection',
  'Perform Design for Manufacture steps and analysis for commonly used manufacturing processes',
  'Use CAD and worksheet to generate Bill of Material',
  'Generate documents of product manufacturing instructions and specifications',
  'Estimate manufacturing process cost and time and propose ways of minimizing manufacturing cost and time '
];

List<String> listText2 = [
  'Distinguish between DfM and DfA and explain their similarities',
  'Describe the purpose of DFMA',
  'Explain how DFMA works',
];

class GeneralCourseModel {
  final String title;
  final String content;
  final String topic;

  GeneralCourseModel({
    required this.title,
    required this.content,
    required this.topic,
  });
}

List<GeneralCourseModel> listGeneral = [
  GeneralCourseModel(
    topic: 'Topic: Introduction',
    title: 'Week 1',
    content: '',
  ),
];
