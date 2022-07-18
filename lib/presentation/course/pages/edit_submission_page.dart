import 'package:bryte/components/utils/typography.dart';
import 'package:bryte/core/data/model/course/response/detail_assignment_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../components/utils/palette.dart';
import 'contents/edit_submission_content.dart';

class EditSubmissionPage extends StatelessWidget {
  const EditSubmissionPage({
    Key? key,
    required this.assignMaxSize,
    required this.assignFile,
    required this.assignDeadline,
  }) : super(key: key);

  final String assignMaxSize;
  final List<AssignFileModel> assignFile;
  final String assignDeadline;

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
      body: Column(
        children: [
          EditSubmissionContent(
            assignDeadline: assignDeadline,
            assignFileModel: assignFile,
            assignMaxSize: assignMaxSize,
          ),
          const Spacer(),
          Column(
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
                              primary: Palette.neutral200,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            onPressed: () {},
                            child: Text(
                              'Cancel',
                              style: BryteTypography.button
                                  .copyWith(color: Palette.neutral400),
                            ))),
                    const SizedBox(
                      width: 5,
                    ),
                    Expanded(
                      flex: 2,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: Palette.purple,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10))),
                        onPressed: () {},
                        child: const Text('Submit'),
                      ),
                    )
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
