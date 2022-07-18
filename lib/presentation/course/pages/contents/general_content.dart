import 'package:bryte/components/utils/palette.dart';
import 'package:bryte/components/utils/typography.dart';
import 'package:bryte/core/blocs/course/course_bloc.dart';
import 'package:bryte/core/data/model/student/response/course_general_model.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';

import '../../../../core/di/injection.dart';

class GeneralContent extends StatefulWidget {
  const GeneralContent({
    Key? key,
  }) : super(key: key);

  @override
  State<GeneralContent> createState() => _GeneralContentState();
}

class _GeneralContentState extends State<GeneralContent> {
  final generalCourseBloc = getIt<CourseBloc>();

  List<CourseGeneralModel> data = [];

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CourseBloc, CourseState>(
      listener: (context, state) {
        if (state is CourseSuccess) {
          // log('Course SUCCESS');
        } else if (state is CourseFailed) {
          // log('Course Gagal');
        }
      },
      builder: (context, state) {
        if (state is CourseSuccess) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: List.generate(
              state.response.length,
              (index) => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 20),
                    child: Text(
                      state.response[index].name,
                      style: BryteTypography.headerExtraBold,
                    ),
                  ),
                  const Divider(
                    height: 0,
                    thickness: 1,
                  ),
                  // Text(state.response[index].summary),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Html(
                      data: state.response[index].summary,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      children: List.generate(
                        state.response[index].modules.length,
                        (i) => Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                color: Palette.lighterGrey,
                                borderRadius: BorderRadius.circular(8)),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                (state.response[index].modules[i].contents !=
                                                null &&
                                            state.response[index].modules[i]
                                                    .contents![0].type ==
                                                'file') &&
                                        (state.response[index].modules[i]
                                                    .contents![0].mimetype !=
                                                null &&
                                            state.response[index].modules[i]
                                                    .contents![0].mimetype ==
                                                'image/png')
                                    ? Padding(
                                        padding:
                                            const EdgeInsets.only(right: 10),
                                        child: Image.network(state
                                            .response[index]
                                            .modules[i]
                                            .modicon),
                                      )
                                    : (state.response[index].modules[i]
                                                        .contents !=
                                                    null &&
                                                state.response[index].modules[i]
                                                        .contents![0].type ==
                                                    'file') &&
                                            (state
                                                        .response[index]
                                                        .modules[i]
                                                        .contents![0]
                                                        .mimetype !=
                                                    null &&
                                                state
                                                        .response[index]
                                                        .modules[i]
                                                        .contents![0]
                                                        .mimetype ==
                                                    'application/pdf')
                                        ? Container(
                                            margin: const EdgeInsets.only(
                                                right: 10),
                                            padding: const EdgeInsets.all(5),
                                            decoration: BoxDecoration(
                                                color: Palette.fanta500,
                                                borderRadius:
                                                    BorderRadius.circular(5)),
                                            child: const Icon(
                                              FluentIcons
                                                  .document_pdf_20_regular,
                                              color: Colors.white,
                                            ),
                                          )
                                        : Container(
                                            margin: const EdgeInsets.only(
                                                right: 10),
                                            padding: const EdgeInsets.all(5),
                                            decoration: BoxDecoration(
                                                color: Palette.purple,
                                                borderRadius:
                                                    BorderRadius.circular(5)),
                                            child: const Icon(
                                              FluentIcons.document_20_filled,
                                              color: Colors.white,
                                            ),
                                          ),
                                Flexible(
                                  child: Text(
                                    state.response[index].modules[i].name,
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
                  )
                ],
              ),
            ),
          );
        } else if (state is CourseLoading) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return const Text('Err');
        }
      },
    );
  }
}
