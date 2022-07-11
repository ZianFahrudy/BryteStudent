import 'package:bryte/components/utils/constant.dart';
import 'package:bryte/components/utils/palette.dart';
import 'package:bryte/components/utils/typography.dart';
import 'package:bryte/presentation/course/pages/course_section_page.dart';
import 'package:bryte/presentation/course/pages/edit_submission_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DetailAssignmentPage extends StatefulWidget {
  const DetailAssignmentPage({
    Key? key,
    required this.selectedSection,
    required this.courseAssignName,
    required this.bgColor,
  }) : super(key: key);

  final ValueNotifier<int> selectedSection;
  final String courseAssignName;

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

  @override
  Widget build(BuildContext context) {
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
      body: SingleChildScrollView(
          child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          HeaderCourseSection(
            bgColor: widget.bgColor,
            courseAssignName: widget.courseAssignName,
            teacherName: '',
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
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Text(
              'Assignment - Week 1',
              style: BryteTypography.headerExtraBold,
            ),
          ),
          const Divider(
            height: 0,
            thickness: 1,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Instructions',
                  style: BryteTypography.titleSemiBold,
                ),
                SizedBox(height: 10),
                Text(
                  'Please watch the Lecture Video and write the summary and key points of the lecture on an A4 paper (minimum 1 page).',
                ),
                SizedBox(height: 10),
                LabelAssignment(
                  label: 'Due Date',
                  description: '8 Sep 2021, 23:59',
                ),
                LabelAssignment(
                  label: 'Time Remaining',
                  description: '1 day 22 hours',
                ),
                LabelAssignment(
                  label: 'Submission Status',
                  description: 'Not Attempted',
                ),
                LabelAssignment(
                  label: 'Grade',
                  description: 'Not Graded',
                ),
              ],
            ),
          ),
          const Divider(
            height: 0,
            thickness: 1,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Submission',
                      style: BryteTypography.titleSemiBold,
                    ),
                    InkWell(
                      onTap: () => Get.to(
                        () => const EditSubmissionPage(),
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.edit,
                            color: Palette.purple,
                            size: 15,
                          ),
                          Text(
                            'Edit',
                            style: BryteTypography.titleSemiBold
                                .copyWith(color: Palette.purple),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'Maximum size',
                  style: BryteTypography.titleRegular.copyWith(fontSize: 14),
                ),
                Text(
                  '20 MB',
                  style: BryteTypography.titleRegular.copyWith(
                      fontSize: 14,
                      color: Palette.purple,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  'Allowed file formats',
                  style: BryteTypography.titleRegular.copyWith(fontSize: 14),
                ),
                Text(
                  'All document files',
                  style: BryteTypography.titleRegular.copyWith(
                      fontSize: 14,
                      color: Palette.purple,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  padding: const EdgeInsets.all(20),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Palette.neutral200,
                  ),
                  child: InkWell(
                    onTap: () {
                      Get.bottomSheet(
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Center(
                              child: Container(
                                margin:
                                    const EdgeInsets.symmetric(vertical: 10),
                                height: 5,
                                width: 50,
                                decoration: BoxDecoration(
                                    color: Palette.lightGrey,
                                    borderRadius: BorderRadius.circular(10)),
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              child: Text(
                                'Select File type',
                                style: BryteTypography.titleSemiBold,
                              ),
                            ),
                            const Divider(
                              height: 0,
                              thickness: 3,
                              color: Palette.lightPB,
                            ),
                            Column(
                              children: const [
                                SelectFileTypeLabel(
                                  label: 'File',
                                  icon: Icons.description,
                                ),
                                SelectFileTypeLabel(
                                  label: 'Picture/Video',
                                  icon: Icons.photo_library,
                                ),
                                SelectFileTypeLabel(
                                  label: 'Open Camera',
                                  icon: Icons.camera_alt,
                                  divider: false,
                                ),
                                SizedBox(height: 10),
                              ],
                            )
                          ],
                        ),
                        backgroundColor: Colors.white,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                          ),
                        ),
                      );
                    },
                    child: Column(
                      children: [
                        Image.asset(
                          AssetConstant.iconUpload,
                          width: 50,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Text(
                          'Tap here to upload a file',
                          style: BryteTypography.titleRegular.copyWith(
                              fontSize: 14,
                              color: Palette.neutral300,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                      color: Palette.lighterGrey,
                      borderRadius: BorderRadius.circular(10)),
                  child: IntrinsicHeight(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.picture_as_pdf,
                          color: Palette.darkPurple,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'DfM_Farel J. Suryadi.pdf',
                              style: BryteTypography.titleMedium,
                            ),
                            Text(
                              '1MB • 7 Sep 2021 17:23',
                              style: BryteTypography.bodyMedium
                                  .copyWith(color: Palette.grey),
                            ),
                          ],
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: SizedBox(
                            height: 50,
                            child: VerticalDivider(
                              width: 0,
                              thickness: 2,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {},
                          child: Text(
                            'View',
                            style: BryteTypography.bodyExtraBold.copyWith(
                              color: Palette.purple,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      )),
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
