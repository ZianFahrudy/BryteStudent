import 'dart:async';

import 'package:bryte/components/utils/typography.dart';
import 'package:bryte/core/data/model/course/response/detail_assignment_model.dart';
import 'package:bryte/presentation/course/pages/pdf_view_page.dart';
import 'package:fl_downloader/fl_downloader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../components/utils/constant.dart';
import '../../../../components/utils/palette.dart';
import '../../local_widget/select_file_type_label.dart';

class EditSubmissionContent extends StatefulWidget {
  const EditSubmissionContent({
    Key? key,
    required this.assignMaxSize,
    required this.assignFileModel,
    required this.assignDeadline,
  }) : super(key: key);

  final String assignMaxSize;
  final String assignDeadline;

  final List<AssignFileModel> assignFileModel;

  @override
  State<EditSubmissionContent> createState() => _EditSubmissionContentState();
}

class _EditSubmissionContentState extends State<EditSubmissionContent> {
  int progress = 0;
  late StreamSubscription progressStream;

  @override
  void initState() {
    progressStream = FlDownloader.progressStream.listen((event) {
      if (event.status == DownloadStatus.successful) {
        setState(() {
          progress = event.progress;
        });
        FlDownloader.openFile(
          filePath: event.filePath,
        );
      } else if (event.status == DownloadStatus.running) {
        setState(() {
          progress = event.progress;
        });
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    progressStream.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Submission',
            style: BryteTypography.titleSemiBold,
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            'Maximum size',
            style: BryteTypography.titleRegular.copyWith(
              fontSize: 14,
            ),
          ),
          Text(
            widget.assignMaxSize,
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
          Column(
            children: widget.assignFileModel
                .map(
                  (data) => Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
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
                                  Text(
                                    data.fileName,
                                    style: BryteTypography.titleMedium,
                                  ),
                                  Text(
                                    DateFormat('dd MMM yyyy, HH:mm').format(
                                        DateTime.parse(widget.assignDeadline)),
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
                                onTap: () => Get.to(() => PdfViewPage(
                                      pdfUrl: data.fileUrl,
                                    )),
                                child: Text(
                                  'Views',
                                  style: BryteTypography.bodyExtraBold.copyWith(
                                    color: Palette.purple,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      PopupMenuButton(
                          child: const Icon(Icons.more_horiz),
                          itemBuilder: (context) => [
                                PopupMenuItem(
                                  child: Row(
                                    children: const [
                                      Icon(
                                        Icons.edit,
                                        color: Palette.darkPurple,
                                      ),
                                      SizedBox(width: 10),
                                      Text('Rename'),
                                    ],
                                  ),
                                  value: 1,
                                ),
                                PopupMenuItem(
                                  child: Row(
                                    children: const [
                                      Icon(
                                        Icons.delete,
                                        color: Palette.darkPurple,
                                      ),
                                      SizedBox(width: 10),
                                      Text('Delete'),
                                    ],
                                  ),
                                  value: 2,
                                ),
                                PopupMenuItem(
                                  onTap: () async {
                                    await FlDownloader.download(
                                        widget.assignFileModel[0].fileUrl,
                                        fileName:
                                            widget.assignFileModel[0].fileName);
                                  },
                                  child: Row(
                                    children: const [
                                      Icon(
                                        Icons.download,
                                        color: Palette.darkPurple,
                                      ),
                                      SizedBox(width: 10),
                                      Text('Download'),
                                    ],
                                  ),
                                  value: 3,
                                )
                              ])
                    ],
                  ),
                )
                .toList(),
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
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
          Column(
            children: [
              if (progress > 0 && progress < 100)
                LinearProgressIndicator(
                  value: progress / 100,
                  color: Colors.orange,
                ),
            ],
          )
        ],
      ),
    );
  }
}
