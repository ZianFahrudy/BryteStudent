import 'dart:developer';

import 'package:bryte/components/utils/palette.dart';
import 'package:bryte/components/utils/typography.dart';
import 'package:bryte/core/blocs/course/course_bloc.dart';
import 'package:bryte/presentation/course/pages/detail_assignment_page.dart';

import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/data/model/student/response/course_general_model.dart';
import '../../../../core/di/injection.dart';

class GeneralContent extends StatefulWidget {
  const GeneralContent({
    Key? key,
    required this.idCourse,
    required this.teacherName,
    required this.bgColor,
    required this.courseGeneralData,
    required this.itemPositionsListener,
    required this.itemScrollController,
  }) : super(key: key);

  final String idCourse;
  final String teacherName;
  final String bgColor;
  final List<CourseGeneralModel> courseGeneralData;
  final ItemPositionsListener itemPositionsListener;
  final ItemScrollController itemScrollController;

  @override
  State<GeneralContent> createState() => _GeneralContentState();
}

class _GeneralContentState extends State<GeneralContent> {
  final generalCourseBloc = getIt<CourseBloc>();

  final selectedValue = ValueNotifier<int>(2);

  Future<void> _launchUrl(String url) async {
    if (!await launchUrl(Uri.parse(url))) {
      throw 'Could not launch urlll';
    }
  }

  final selectedDropdownValue = ValueNotifier<String>('0');

  final selectedValueDrop = ValueNotifier<String>('');

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CourseBloc, CourseState>(
      listener: (context, state) {
        if (state is CourseSuccess) {
          widget.courseGeneralData.addAll(state.response);
          setState(() {});
          log(widget.courseGeneralData.length.toString(), name: 'GENERAL');
          log('Get General Course Success');
        } else if (state is CourseFailed) {
          log('Get General Course Failure');
        }
      },
      builder: (context, state) {
        if (state is CourseSuccess) {
          return _buildCourseGeneral(widget.courseGeneralData);
        } else if (state is CourseLoading) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return const Center(child: Text('Something Error'));
        }
      },
    );
  }

  Widget _buildCourseGeneral(List<CourseGeneralModel> response) {
    return Column(
      children: [
        SizedBox(
          height: 700,
          child: ScrollablePositionedList.builder(
            itemPositionsListener: widget.itemPositionsListener,
            itemScrollController: widget.itemScrollController,
            itemCount: response.length,
            itemBuilder: (context, index) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: Text(
                    response[index].name,
                    style: BryteTypography.headerExtraBold
                        .copyWith(fontSize: 18, fontWeight: FontWeight.w800),
                  ),
                ),
                const Divider(
                  height: 0,
                  thickness: 1,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Html(
                    data: response[index].summary,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: List.generate(
                      response[index].modules.length,
                      (i) => InkWell(
                        onTap: () async {
                          if (response[index].modules[i].modname == 'forum') {
                            // Get to Announcement Page Detail
                          } else if (response[index].modules[i].modname ==
                              'assign') {
                            Get.to(
                              () => DetailAssignmentPage(
                                selectedSection: selectedValue,
                                courseAssignName:
                                    response[index].modules[i].name,
                                bgColor: widget.bgColor,
                                teacherName: widget.teacherName,
                                idCourse: widget.idCourse,
                                idAssign: response[index]
                                    .modules[i]
                                    .instance
                                    .toString(),
                              ),
                            );
                          } else {
                            await _launchUrl(
                              response[index].modules[i].url,
                            );
                          }
                        },
                        child: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Palette.lighterGrey,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                if (response[index].modules[i].contents !=
                                        null &&
                                    response[index]
                                        .modules[i]
                                        .contents!
                                        .isNotEmpty &&
                                    response[index]
                                            .modules[i]
                                            .contents![0]
                                            .type ==
                                        'file' &&
                                    response[index]
                                            .modules[i]
                                            .contents![0]
                                            .mimetype !=
                                        null &&
                                    response[index]
                                            .modules[i]
                                            .contents![0]
                                            .mimetype ==
                                        'image/png')
                                  Padding(
                                    padding: const EdgeInsets.only(right: 10),
                                    child: Image.network(
                                        response[index].modules[i].modicon),
                                  )
                                else if (response[index].modules[i].contents !=
                                        null &&
                                    response[index]
                                        .modules[i]
                                        .contents!
                                        .isNotEmpty &&
                                    response[index]
                                            .modules[i]
                                            .contents![0]
                                            .type ==
                                        'file' &&
                                    response[index]
                                            .modules[i]
                                            .contents![0]
                                            .mimetype !=
                                        null &&
                                    response[index]
                                            .modules[i]
                                            .contents![0]
                                            .mimetype ==
                                        'application/pdf')
                                  Container(
                                    margin: const EdgeInsets.only(right: 10),
                                    padding: const EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                        color: Palette.fanta500,
                                        borderRadius: BorderRadius.circular(5)),
                                    child: const Icon(
                                      FluentIcons.document_pdf_20_regular,
                                      color: Colors.white,
                                    ),
                                  )
                                else
                                  Container(
                                    margin: const EdgeInsets.only(right: 10),
                                    padding: const EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                        color: Palette.purple,
                                        borderRadius: BorderRadius.circular(5)),
                                    child: const Icon(
                                      FluentIcons.document_20_filled,
                                      color: Colors.white,
                                    ),
                                  ),
                                Flexible(
                                  child: Text(
                                    response[index].modules[i].name,
                                    style: BryteTypography.titleSemiBold
                                        .copyWith(color: Palette.grey),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            )),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
