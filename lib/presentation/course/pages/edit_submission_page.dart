import 'package:bryte/components/utils/constant.dart';
import 'package:bryte/components/utils/typography.dart';
import 'package:bryte/presentation/course/pages/detail_assignment_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../components/utils/palette.dart';

class EditSubmissionPage extends StatelessWidget {
  const EditSubmissionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          const EditSubmissionContent(),
          const Spacer(),
          Column(
            children: [
              const Divider(
                height: 0,
                thickness: 1,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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

class EditSubmissionContent extends StatelessWidget {
  const EditSubmissionContent({
    Key? key,
  }) : super(key: key);

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
          Row(
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
              IconButton(onPressed: () {}, icon: const Icon(Icons.more_horiz))
            ],
          ),
        ],
      ),
    );
  }
}
