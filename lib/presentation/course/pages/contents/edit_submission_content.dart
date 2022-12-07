// ignore_for_file: library_prefixes

import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:bryte/components/utils/typography.dart';
import 'package:bryte/core/blocs/edit_submission/edit_submission_bloc.dart'
    as editSubs;
import 'package:bryte/core/blocs/moodle/moodle_bloc.dart';
import 'package:bryte/core/data/model/course/response/detail_assignment_model.dart';
import 'package:file_picker/file_picker.dart';
import 'package:fl_downloader/fl_downloader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../../../../components/utils/constant.dart';
import '../../../../components/utils/palette.dart';
import '../../../../core/data/model/moodle/request/assign_save_json_body.dart';
import '../../../../core/data/model/moodle/request/assign_submit_file.dart';
import '../../../../core/data/model/moodle/request/upload_file_body.dart';
import '../../local_widget/assignment_dialog_success.dart';
import '../../local_widget/select_file_type_label.dart';
import '../pdf_view_page.dart';

class EditSubmissionContent extends StatefulWidget {
  const EditSubmissionContent({
    Key? key,
    required this.assignMaxSize,
    required this.assignFileModel,
    required this.assignDeadline,
    required this.moodleBloc,
    required this.token,
    required this.userId,
    required this.assignId,
    required this.editSubmissionBloc,
    required this.isUploadSuccess,
    required this.itemId,
  }) : super(key: key);

  final String assignMaxSize;
  final String assignDeadline;
  final MoodleBloc moodleBloc;
  final editSubs.EditSubmissionBloc editSubmissionBloc;
  final List<AssignFileModel> assignFileModel;
  final String token;
  final String userId;
  final String assignId;
  final ValueNotifier<bool> isUploadSuccess;
  final ValueNotifier<int> itemId;

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

  File? _file;
  XFile? _image;

  bool isUploadSuccess = false;

  String? fileName;
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

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
        listeners: [
          BlocListener<editSubs.EditSubmissionBloc,
              editSubs.EditSubmissionState>(
            listener: (context, state) {
              if (state is editSubs.EditSubmissionSuccess) {
                log('get edit submission success');
                log(state.response.lastattempt!.canedit.toString());
              } else if (state is editSubs.EditSubmissionFailure) {
                log('get edit submission gagal');
              }
            },
          ),
          BlocListener<MoodleBloc, MoodleState>(
            listener: (context, state) {
              if (state is UploadFileSuccess) {
                Get.snackbar('berhasil', 'upload success');
                widget.isUploadSuccess.value = true;
                widget.itemId.value = state.response.itemid;
                log('upload success');
                log(widget.isUploadSuccess.value.toString());
                log(widget.itemId.value.toString());

                // setState(() {});

                // widget.moodleBloc.add(
                //   AssignSaveEvent(
                //     body: AssignSaveBody(
                //       wstoken: widget.token,
                //       wsfunction: 'mod_assign_save_submission',
                //       moodlewsrestformat: 'json',
                //       assignmentid: int.parse(
                //         widget.assignId,
                //       ),
                //       plugindataText: 'pdf',
                //       plugindataFormat: 1,
                //       plugindataItemId: state.response.itemid,
                //       plugindataFilesManager: state.response.itemid,
                //     ),
                //     jsonBody: AssignSaveJsonBody(
                //       token: widget.token,
                //       userid: widget.userId,
                //     ),
                //   ),
                // );
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
                        widget.assignId,
                      ),
                      acceptsubmissionstatement: 1,
                    ),
                    jsonBody: AssignSaveJsonBody(
                      token: widget.token,
                      userid: widget.userId,
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
          ),
        ],
        child: BlocBuilder<editSubs.EditSubmissionBloc,
            editSubs.EditSubmissionState>(
          builder: (context, state) {
            if (state is editSubs.EditSubmissionSuccess) {
              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Submission',
                      style: BryteTypography.titleSemiBold.copyWith(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Maximum size',
                      style: BryteTypography.titleRegular.copyWith(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Text(
                      widget.assignMaxSize,
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
                      ),
                    ),
                    Text(
                      'All document files',
                      style: BryteTypography.titleRegular.copyWith(
                        fontSize: 14,
                        color: Palette.purple,
                        fontWeight: FontWeight.w600,
                      ),
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
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
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
                                                  .format(DateTime.parse(
                                                      widget.assignDeadline)),
                                              style: BryteTypography.bodyMedium
                                                  .copyWith(
                                                      color: Palette.grey),
                                            ),
                                          ],
                                        ),
                                        const Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 10),
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
                                          onTap: () {
                                            Get.to(
                                              () => PdfViewPage(
                                                pdfUrl:
                                                    '${state.response.lastattempt!.submission.plugins[0].fileareas![0].files[0].fileurl}?token=${widget.token}',
                                              ),
                                            );
                                            log('${state.response.lastattempt!.submission.plugins[0].fileareas![0].files[0].fileurl}?token=${widget.token}');
                                          },
                                          child: Text(
                                            'VIEW',
                                            style: BryteTypography.bodyExtraBold
                                                .copyWith(
                                                    color: Palette.purple,
                                                    fontWeight: FontWeight.w700,
                                                    fontSize: 12),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                PopupMenuButton(
                                  child: const Icon(Icons.more_horiz),
                                  itemBuilder: (context) => [
                                    // PopupMenuItem(
                                    //   child: Row(
                                    //     children: const [
                                    //       Icon(
                                    //         Icons.edit,
                                    //         color: Palette.darkPurple,
                                    //       ),
                                    //       SizedBox(width: 10),
                                    //       Text('Rename'),
                                    //     ],
                                    //   ),
                                    //   value: 1,
                                    // ),
                                    // PopupMenuItem(
                                    //   child: Row(
                                    //     children: const [
                                    //       Icon(
                                    //         Icons.delete,
                                    //         color: Palette.darkPurple,
                                    //       ),
                                    //       SizedBox(width: 10),
                                    //       Text('Delete'),
                                    //     ],
                                    //   ),
                                    //   value: 2,
                                    // ),
                                    PopupMenuItem(
                                      onTap: () async {
                                        //   await FlDownloader.download(
                                        //       widget.assignFileModel[0]
                                        //           .fileUrl,
                                        //       fileName: widget
                                        //           .assignFileModel[0]
                                        //           .fileName);

                                        await FlDownloader.download(
                                            '${state.response.lastattempt!.submission.plugins[0].fileareas![0].files[0].fileurl}?token=${widget.token}}');
                                      },
                                      // },
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
                                  ],
                                )
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
                                    margin: const EdgeInsets.symmetric(
                                        vertical: 10),
                                    height: 5,
                                    width: 50,
                                    decoration: BoxDecoration(
                                        color: Palette.lightGrey,
                                        borderRadius:
                                            BorderRadius.circular(10)),
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
                                      onTap: () {
                                        getFile();
                                      },
                                      label: 'File',
                                      icon: Icons.description,
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
                                  fontWeight: FontWeight.w500),
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
            } else if (state is editSubs.EditSubmissionLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is editSubs.EditSubmissionFailure) {
              return Center(
                child: Text(state.msg),
              );
            } else {
              return const SizedBox();
            }
          },
        ));
  }
}
