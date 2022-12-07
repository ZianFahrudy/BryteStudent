// ignore_for_file: library_prefixes

import 'dart:developer';

import 'package:bryte/core/blocs/edit_submission/edit_submission_bloc.dart'
    as editSub;
import 'package:bryte/core/data/model/course/request/edit_submission_body.dart';
import 'package:bryte/core/data/model/course/response/detail_assignment_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../../components/utils/palette.dart';
import '../../../components/utils/typography.dart';
import '../../../core/blocs/moodle/moodle_bloc.dart';
import '../../../core/data/model/moodle/request/assign_save_body.dart';
import '../../../core/data/model/moodle/request/assign_save_json_body.dart';
import '../../../core/di/injection.dart';
import 'contents/edit_submission_content.dart';

class EditSubmissionPage extends StatefulWidget {
  const EditSubmissionPage({
    Key? key,
    required this.assignMaxSize,
    required this.assignFile,
    required this.assignDeadline,
    required this.token,
    required this.userId,
    required this.assignId,
  }) : super(key: key);

  final String assignMaxSize;
  final List<AssignFileModel> assignFile;
  final String assignDeadline;
  final String token;
  final String userId;
  final String assignId;

  @override
  State<EditSubmissionPage> createState() => _EditSubmissionPageState();
}

class _EditSubmissionPageState extends State<EditSubmissionPage> {
  final isUploadSuccess = ValueNotifier<bool>(false);

  final itemId = ValueNotifier<int>(0);

  @override
  Widget build(BuildContext context) {
    final moodleBloc = getIt<MoodleBloc>();
    final editSubmisionBloc = getIt<editSub.EditSubmissionBloc>();

    log(isUploadSuccess.value.toString());

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => moodleBloc,
        ),
        BlocProvider(
          create: (context) => editSubmisionBloc
            ..add(
              editSub.GetEditSubmissionEvent(
                body: EditSubmissionBody(
                  wstoken: widget.token,
                  wsfunction: 'mod_assign_get_submission_status',
                  moodlewsrestformat: 'json',
                  assignid: int.parse(widget.assignId),
                  userid: int.parse(widget.userId),
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
        body: Column(
          children: [
            EditSubmissionContent(
              editSubmissionBloc: editSubmisionBloc,
              assignId: widget.assignId,
              itemId: itemId,
              token: widget.token,
              isUploadSuccess: isUploadSuccess,
              userId: widget.userId,
              moodleBloc: moodleBloc,
              assignDeadline: widget.assignDeadline,
              assignFileModel: widget.assignFile,
              assignMaxSize: widget.assignMaxSize,
            ),
            const Spacer(),
            // if (isUploadSuccess.value)
            ValueListenableBuilder<bool>(
              valueListenable: isUploadSuccess,
              builder: (context, upload, __) => upload
                  ? ValueListenableBuilder<int>(
                      valueListenable: itemId,
                      builder: (context, itemid, _) => Column(
                        children: [
                          const Divider(
                            height: 0,
                            thickness: 1,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 10,
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      minimumSize:
                                          const Size(double.infinity, 43),
                                      backgroundColor: Palette.neutral200,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        isUploadSuccess.value = false;
                                      });
                                    },
                                    child: Text(
                                      'Cancel',
                                      style: BryteTypography.button.copyWith(
                                        color: Palette.neutral400,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Expanded(
                                  flex: 2,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      minimumSize:
                                          const Size(double.infinity, 43),
                                      backgroundColor: Palette.purple,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                    onPressed: () {
                                      moodleBloc.add(
                                        AssignSaveEvent(
                                          body: AssignSaveBody(
                                            wstoken: widget.token,
                                            wsfunction:
                                                'mod_assign_save_submission',
                                            moodlewsrestformat: 'json',
                                            assignmentid: int.parse(
                                              widget.assignId,
                                            ),
                                            plugindataText: 'pdf',
                                            plugindataFormat: 1,
                                            plugindataItemId: itemid,
                                            plugindataFilesManager: itemid,
                                          ),
                                          jsonBody: AssignSaveJsonBody(
                                            token: widget.token,
                                            userid: widget.userId,
                                          ),
                                        ),
                                      );
                                    },
                                    child: Text(
                                      'Submit',
                                      style: BryteTypography.button.copyWith(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    )
                  : const SizedBox(),
            )
          ],
        ),
      ),
    );
  }
}
