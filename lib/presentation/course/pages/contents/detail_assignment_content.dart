import 'package:bryte/components/utils/typography.dart';
import 'package:bryte/presentation/course/local_widget/assignment_dialog_success.dart';
import 'package:bryte/presentation/course/pages/detail_assignment_page.dart';
import 'package:bryte/presentation/course/pages/pdf_view_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../components/utils/constant.dart';
import '../../../../components/utils/palette.dart';
import '../../../../core/blocs/assignment/assignment_bloc.dart';
import '../edit_submission_page.dart';

class DetailAssignmentContent extends StatelessWidget {
  const DetailAssignmentContent({
    Key? key,
    required this.state,
  }) : super(key: key);

  final DetailAssignmentSuccess state;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: Text(
            state.response.data[0].assignments[0].assignName,
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
            children: [
              const Text(
                'Instructions',
                style: BryteTypography.titleSemiBold,
              ),
              const SizedBox(height: 10),
              Text(
                state.response.data[0].assignments[0].assignDescp,
              ),
              const SizedBox(height: 10),
              LabelAssignment(
                label: 'Due Date',
                description: DateFormat('dd MMM yyyy, HH:mm').format(
                  DateTime.parse(
                      state.response.data[0].assignments[0].assignDeadline),
                ),
              ),
              LabelAssignment(
                label: 'Time Remaining',
                description:
                    state.response.data[0].assignments[0].assignTimeRemaining,
              ),
              LabelAssignment(
                label: 'Submission Status',
                description: state.response.data[0].assignments[0].assignStatus,
              ),
              LabelAssignment(
                label: 'Grade',
                description: state.response.data[0].assignments[0].assignGrade,
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
                      () => EditSubmissionPage(
                        assignDeadline: state
                            .response.data[0].assignments[0].assignDeadline,
                        assignFile:
                            state.response.data[0].assignments[0].assignFile,
                        assignMaxSize:
                            state.response.data[0].assignments[0].assignMaxSize,
                      ),
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
                state.response.data[0].assignments[0].assignMaxSize,
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
                              margin: const EdgeInsets.symmetric(vertical: 10),
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
                            children: [
                              SelectFileTypeLabel(
                                label: 'File',
                                icon: Icons.description,
                                onTap: () {
                                  Get.dialog<void>(
                                    const AsssignmentDialogSuccess(),
                                  );
                                },
                              ),
                              const SelectFileTypeLabel(
                                label: 'Picture/Video',
                                icon: Icons.photo_library,
                              ),
                              const SelectFileTypeLabel(
                                label: 'Open Camera',
                                icon: Icons.camera_alt,
                                divider: false,
                              ),
                              const SizedBox(height: 10),
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
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: state.response.data[0].assignments[0].assignFile
                    .map(
                      (data) => Column(
                        children: [
                          Container(
                            margin: const EdgeInsets.symmetric(
                              vertical: 10,
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                            ),
                            decoration: BoxDecoration(
                              color: Palette.lighterGrey,
                              borderRadius: BorderRadius.circular(10),
                            ),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        data.fileName,
                                        style: BryteTypography.titleMedium,
                                      ),
                                      Text(
                                        DateFormat('dd MMM yyyy, HH:mm').format(
                                          DateTime.parse(
                                            state.response.data[0]
                                                .assignments[0].assignDeadline,
                                          ),
                                        ),
                                        style:
                                            BryteTypography.bodyMedium.copyWith(
                                          color: Palette.grey,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10),
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
                                    onTap: () => Get.to(() => PdfViewPage(
                                          pdfUrl: data.fileUrl,
                                        )),
                                    child: Text(
                                      'View',
                                      style: BryteTypography.bodyExtraBold
                                          .copyWith(
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
                    .toList(),
              ),
            ],
          ),
        )
      ],
    );
  }
}
