import 'dart:developer';

import 'package:bryte/core/blocs/gpa_grade/gpa_grade_bloc.dart';
import 'package:bryte/core/blocs/list_semester_student/list_semester_student_bloc.dart';
import 'package:bryte/core/data/model/profile/request/gpa_grade_body.dart';
import 'package:bryte/core/data/model/profile/request/list_semester_student_body.dart';
import 'package:bryte/core/data/model/profile/response/list_semester_student_model.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';

import '../../../components/utils/constant.dart';
import '../../../components/utils/palette.dart';
import '../../../core/di/injection.dart';

class DropdownScoreSemester extends StatefulWidget {
  const DropdownScoreSemester({
    Key? key,
    required this.selectedValue,
    required this.gradeBloc,
  }) : super(key: key);

  final ValueNotifier<String> selectedValue;
  final GpaGradeBloc gradeBloc;

  @override
  State<DropdownScoreSemester> createState() => _DropdownScoreSemesterState();
}

class _DropdownScoreSemesterState extends State<DropdownScoreSemester> {
  final listSemesterStudentBloc = getIt<ListSemesterStudentBloc>();

  List<SemesterListModel> listSemesterStudents = [];

  @override
  Widget build(BuildContext context) {
    final box = GetStorage();

    final token = box.read(KeyConstant.token);
    final userId = box.read(KeyConstant.userId);
    return BlocProvider(
      create: (context) => listSemesterStudentBloc
        ..add(GetListSemesterStudentEvent(
            body: ListSemesterStudentBody(token: token, userid: userId))),
      child: BlocListener<ListSemesterStudentBloc, ListSemesterStudentState>(
        listener: (context, state) {
          if (state is ListSemesterStudentSuccess) {
            log('get list semester student success');
            listSemesterStudents = state.response.data[0].listSemester;

            setState(() {});
          } else if (state is ListSemesterStudentFailure) {
            log('get listsemester student gagal');
          }
        },
        child: Padding(
          padding: const EdgeInsets.only(
            left: 20,
            bottom: 20,
          ),
          child: DropdownButtonHideUnderline(
            child: ValueListenableBuilder<String>(
              valueListenable: widget.selectedValue,
              builder: (context, _, __) => DropdownButton2(
                isExpanded: true,
                items: listSemesterStudents
                    .map((item) => DropdownMenuItem<String>(
                          value: item.semester,
                          child: Text(
                            item.semesterDescp,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Palette.darkPurple,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ))
                    .toList(),
                value: widget.selectedValue.value == ''
                    ? null
                    : widget.selectedValue.value,
                onChanged: (value) {
                  widget.selectedValue.value = value as String;
                  widget.gradeBloc.add(
                    GetGpaGradeEvent(
                      body: GpaGradeBody(
                        token: token,
                        userid: userId,
                        semester: widget.selectedValue.value,
                      ),
                    ),
                  );
                },
                icon: Row(
                  children: const [
                    VerticalDivider(
                      color: Colors.white,
                    ),
                    Icon(
                      Icons.expand_more,
                      size: 20,
                      color: Palette.darkPurple,
                    ),
                  ],
                ),
                iconSize: 14,
                iconEnabledColor: Palette.darkPurple,
                iconDisabledColor: Palette.darkPurple,
                buttonHeight: 35,
                buttonWidth: 180,
                buttonPadding: const EdgeInsets.only(left: 14, right: 14),
                buttonDecoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                    color: Colors.black26,
                  ),
                  color: Palette.purple1,
                ),
                buttonElevation: 2,
                itemHeight: 40,
                itemPadding: const EdgeInsets.only(left: 14, right: 14),
                dropdownMaxHeight: 200,
                dropdownWidth: 180,
                dropdownPadding: null,
                dropdownDecoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  color: Palette.purple1,
                ),
                dropdownElevation: 8,
                scrollbarRadius: const Radius.circular(40),
                scrollbarThickness: 6,
                scrollbarAlwaysShow: true,
                offset: const Offset(0, 0),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
