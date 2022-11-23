import 'dart:developer';
import 'dart:io';

import 'package:bryte/components/utils/typography.dart';
import 'package:bryte/core/blocs/moodle/moodle_bloc.dart';
import 'package:bryte/core/data/model/moodle/request/assign_save_body.dart';
import 'package:bryte/core/data/model/moodle/request/assign_save_json_body.dart';
import 'package:bryte/core/data/model/moodle/request/assign_submit_file.dart';
import 'package:bryte/core/data/model/moodle/request/upload_file_body.dart';
import 'package:bryte/presentation/course/local_widget/assignment_dialog_success.dart';
import 'package:file_picker/file_picker.dart';
import 'package:fl_downloader/fl_downloader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../../../../components/utils/constant.dart';
import '../../../../components/utils/palette.dart';
import '../../../../core/blocs/assignment/assignment_bloc.dart';
import '../../local_widget/label_assignment.dart';
import '../../local_widget/select_file_type_label.dart';
import '../edit_submission_page.dart';

class DetailAssignmentContent extends StatefulWidget {
  const DetailAssignmentContent({
    Key? key,
    required this.state,
    required this.moodleBloc,
    required this.token,
    required this.userid,
  }) : super(key: key);

  final DetailAssignmentSuccess state;

  final MoodleBloc moodleBloc;
  final String token;
  final String userid;

  @override
  State<DetailAssignmentContent> createState() =>
      _DetailAssignmentContentState();
}

class _DetailAssignmentContentState extends State<DetailAssignmentContent> {
  XFile? _image;
  File? _file;

  String? fileName;

  Future<void> getImage(bool fileType) async {
    final _pickedImage = await ImagePicker().pickImage(
      source: fileType ? ImageSource.camera : ImageSource.gallery,
    );

    if (_pickedImage != null) {
      setState(() {
        _image = _pickedImage;
        fileName = _pickedImage.path.split('/').last;

        if (fileName != null) {
          widget.moodleBloc.add(
            UploadFileEvent(
              body: UploadFileBody(
                token: widget.token,
                filearea: 'draft',
                itemid: 0,
                file: _image!.path,
              ),
            ),
          );
        }

        Get.back<void>();
      });
      log(_image!.path);
    }
  }

  getFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      setState(() {
        _file = File(result.files.single.path!);
        fileName = result.files.single.path!.split('/').last;

        if (fileName != null) {
          widget.moodleBloc.add(
            UploadFileEvent(
              body: UploadFileBody(
                token: widget.token,
                filearea: 'draft',
                itemid: 0,
                file: _file!.path,
              ),
            ),
          );
        }

        log(fileName!);
        Get.back<void>();
      });
    } else {
      // User canceled the picker
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MoodleBloc, MoodleState>(
      listener: (context, state) {
        if (state is UploadFileSuccess) {
          log('upload success');
          widget.moodleBloc.add(
            AssignSaveEvent(
              body: AssignSaveBody(
                wstoken: widget.token,
                wsfunction: 'mod_assign_save_submission',
                moodlewsrestformat: 'json',
                assignmentid: int.parse(
                  widget.state.response.data[0].assignments[0].idAssign,
                ),
                plugindataText: 'jpg',
                plugindataFormat: 1,
                plugindataItemId: state.response.itemid,
                plugindataFilesManager: state.response.itemid,
              ),
              jsonBody: AssignSaveJsonBody(
                token: widget.token,
                userid: widget.userid,
              ),
            ),
          );
        } else if (state is MoodleFailure) {
          log('gagaaaaalllll');
        } else if (state is AssignSaveFileSuccess) {
          log('assign file success');
          widget.moodleBloc.add(
            AssignSubmitEvent(
              body: AssignSubmitFileBody(
                wstoken: widget.token,
                wsfunction: 'mod_assign_submit_for_grading',
                moodlewsrestformat: 'json',
                assignmentid: int.parse(
                  widget.state.response.data[0].assignments[0].idAssign,
                ),
                acceptsubmissionstatement: 1,
              ),
              jsonBody: AssignSaveJsonBody(
                token: widget.token,
                userid: widget.userid,
              ),
            ),
          );
        } else if (state is AssignSaveFailure) {
          log('assign file failure');
          Get.snackbar('Gagal', state.msg,
              backgroundColor: Palette.red, colorText: Colors.white);
          _file = null;
          _image = null;
        } else if (state is AssignSubmitFileSuccess) {
          log('assign submit file success');
          Get.snackbar('Berhasil', 'Submit File Berhasil',
              backgroundColor: Palette.green, colorText: Colors.white);
          Get.dialog<void>(const AsssignmentDialogSuccess());
        } else if (state is AssignSubmitFailure) {
          // _file = null;
          // _image = null;
          Get.snackbar('Gagal', state.msg,
              backgroundColor: Palette.red, colorText: Colors.white);
          log('assign submit file failure');
        }
      },
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Text(
                widget.state.response.data[0].assignments[0].assignName,
                style: BryteTypography.headerExtraBold.copyWith(
                    fontFamily: 'SF Pro Bold',
                    fontWeight: FontWeight.w800,
                    color: const Color(0xff333333),
                    fontSize: 18),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Divider(
                height: 0,
                thickness: 1,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Instructions',
                    style: BryteTypography.titleSemiBold.copyWith(
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                      color: const Color(0xff5F5F5F),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    widget.state.response.data[0].assignments[0].assignDescp,
                    style: BryteTypography.bodyRegular
                        .copyWith(fontWeight: FontWeight.w400, fontSize: 14),
                  ),
                  const SizedBox(height: 10),
                  LabelAssignment(
                    label: 'Due Date',
                    description: DateFormat('dd MMM yyyy, HH:mm').format(
                      DateTime.parse(
                        widget.state.response.data[0].assignments[0]
                            .assignDeadline,
                      ),
                    ),
                  ),
                  LabelAssignment(
                    label: 'Time Remaining',
                    description: widget.state.response.data[0].assignments[0]
                        .assignTimeRemaining,
                  ),
                  LabelAssignment(
                    label: 'Submission Status',
                    description: widget
                        .state.response.data[0].assignments[0].assignStatus,
                  ),
                  LabelAssignment(
                    label: 'Grade',
                    description: widget
                        .state.response.data[0].assignments[0].assignGrade,
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Divider(
                height: 0,
                thickness: 1,
              ),
            ),
            if (_image != null)
              FileCard(
                fileName: fileName ?? '',
                fileSize: _image!.length().toString(),
                date: '1212',
                fileUrl: 'sdsdd',
              ),
            if (_file != null)
              FileCard(
                fileName: fileName ?? '',
                fileSize: _file!.lengthSync().toString(),
                date: '1212',
                fileUrl: 'sdsdd',
              ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Submission',
                        style: BryteTypography.titleSemiBold.copyWith(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xff5F5F5F)),
                      ),
                      InkWell(
                        onTap: () => Get.to(
                          () => EditSubmissionPage(
                            assignId: widget
                                .state.response.data[0].assignments[0].idAssign,
                            userId: widget.userid,
                            token: widget.token,
                            assignDeadline: widget.state.response.data[0]
                                .assignments[0].assignDeadline,
                            assignFile: widget.state.response.data[0]
                                .assignments[0].assignFile,
                            assignMaxSize: widget.state.response.data[0]
                                .assignments[0].assignMaxSize,
                          ),
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.edit,
                              color: Palette.purple,
                              size: 13,
                            ),
                            Text(
                              'Edit',
                              style: BryteTypography.titleSemiBold.copyWith(
                                  color: Palette.purple,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14),
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
                    style: BryteTypography.titleRegular.copyWith(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xff5F5F5F)),
                  ),
                  Text(
                    widget.state.response.data[0].assignments[0].assignMaxSize,
                    style: BryteTypography.titleRegular.copyWith(
                        fontSize: 14,
                        color: Palette.purple,
                        fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Allowed file formats',
                    style: BryteTypography.titleRegular.copyWith(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xff5F5F5F)),
                  ),
                  Text(
                    'All document files',
                    style: BryteTypography.titleRegular.copyWith(
                        fontSize: 14,
                        color: Palette.purple,
                        fontWeight: FontWeight.w600),
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
                                    borderRadius: BorderRadius.circular(10),
                                  ),
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
                                      getFile();
                                    },
                                  ),
                                  SelectFileTypeLabel(
                                    onTap: () => getImage(false),
                                    label: 'Picture/Video',
                                    icon: Icons.photo_library,
                                  ),
                                  SelectFileTypeLabel(
                                    onTap: () => getImage(true),
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
                    children: widget
                        .state.response.data[0].assignments[0].assignFile
                        .map(
                          (data) => InkWell(
                            onTap: () async {
                              await FlDownloader.download(data.fileUrl,
                                  fileName: data.fileName);
                            },
                            child: Column(
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
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              data.fileName,
                                              style:
                                                  BryteTypography.titleMedium,
                                            ),
                                            Text(
                                              DateFormat('dd MMM yyyy, HH:mm')
                                                  .format(
                                                DateTime.parse(
                                                  widget
                                                      .state
                                                      .response
                                                      .data[0]
                                                      .assignments[0]
                                                      .assignDeadline,
                                                ),
                                              ),
                                              style: BryteTypography.bodyMedium
                                                  .copyWith(
                                                color: Palette.grey,
                                              ),
                                            ),
                                          ],
                                        ),
                                        // const Padding(
                                        //   padding: EdgeInsets.symmetric(
                                        //       horizontal: 10),
                                        //   child: SizedBox(
                                        //     height: 50,
                                        //     child: VerticalDivider(
                                        //       width: 0,
                                        //       thickness: 2,
                                        //       color: Colors.white,
                                        //     ),
                                        //   ),
                                        // ),
                                        // InkWell(
                                        //   onTap: () => Get.to(() => PdfViewPage(
                                        //         pdfUrl: data.fileUrl,
                                        //       )),
                                        //   child: Text(
                                        //     'View',
                                        //     style: BryteTypography.bodyExtraBold
                                        //         .copyWith(
                                        //       color: Palette.purple,
                                        //     ),
                                        //   ),
                                        // ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ],
              ),
            )
          ],
        );
      },
    );
  }
}

class FileCard extends StatelessWidget {
  const FileCard({
    Key? key,
    required this.fileName,
    required this.fileSize,
    required this.fileUrl,
    required this.date,
  }) : super(key: key);

  final String fileName;
  final String fileSize;
  final String fileUrl;
  final String date;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
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
                      SizedBox(
                        // width: fileName.length > 20 ? Get.width - 200 : 0,
                        child: Text(
                          fileName,
                          maxLines: 4,
                          overflow: TextOverflow.ellipsis,
                          style: BryteTypography.titleMedium,
                        ),
                      ),
                      // Text(
                      //   '$fileSize •',
                      //   style: BryteTypography.titleMedium,
                      // ),
                      // Text(
                      //   DateFormat('dd MMM yyyy, HH:mm')
                      //       .format(DateTime.parse(ass)),
                      //   style: BryteTypography.bodyMedium
                      //       .copyWith(color: Palette.grey),
                      // ),
                    ],
                  ),
                  // const Padding(
                  //   padding: EdgeInsets.symmetric(horizontal: 10),
                  //   child: VerticalDivider(
                  //     width: 0,
                  //     thickness: 2,
                  //     color: Colors.white,
                  //   ),
                  // ),
                  // InkWell(
                  //   onTap: () => Get.to(() => PdfViewPage(
                  //         pdfUrl: fileUrl,
                  //       )),
                  //   child: Text(
                  //     'Views',
                  //     style: BryteTypography.bodyExtraBold.copyWith(
                  //       color: Palette.purple,
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
