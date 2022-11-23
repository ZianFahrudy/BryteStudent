import 'dart:developer';

import 'package:bryte/core/blocs/academic_period/academic_period_bloc.dart';
import 'package:bryte/core/blocs/attendance_rate/attendance_rate_bloc.dart';
import 'package:bryte/core/data/model/profile/request/attendance_rate_student.dart';
import 'package:bryte/core/data/model/profile/request/period_student_body.dart';
import 'package:bryte/core/data/model/profile/response/period_per_student_model.dart';
import 'package:bryte/core/di/injection.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';

import '../../../components/utils/constant.dart';
import '../../../components/utils/palette.dart';
import '../../../components/utils/typography.dart';

class DropdownSemester extends StatelessWidget {
  const DropdownSemester({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
            color: Palette.purple1, borderRadius: BorderRadius.circular(48)),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Academic Year',
              style: BryteTypography.titleSemiBold
                  .copyWith(color: Palette.darkPurple),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: SizedBox(
                height: 30,
                child: VerticalDivider(
                  width: 0,
                  thickness: 1,
                  color: Colors.white,
                ),
              ),
            ),
            const Icon(
              Icons.expand_more,
              size: 20,
              color: Palette.darkPurple,
            )
          ],
        ),
      ),
    );
  }
}

class DropdownSemesterButton extends StatefulWidget {
  const DropdownSemesterButton(
      {Key? key, required this.selectedValue, required this.attendanceRateBloc})
      : super(key: key);

  final ValueNotifier<String> selectedValue;
  final AttendanceRateBloc attendanceRateBloc;

  @override
  State<DropdownSemesterButton> createState() => _DropdownSemesterButtonState();
}

class _DropdownSemesterButtonState extends State<DropdownSemesterButton> {
  final academicPeriodBloc = getIt<AcademicPeriodBloc>();

  List<DataPeriodPerStudentModel> academicPeriodStudents = [];

  @override
  Widget build(BuildContext context) {
    final box = GetStorage();
    final token = box.read(KeyConstant.token);
    final userId = box.read(KeyConstant.userId);

    return BlocProvider(
      create: (context) => academicPeriodBloc
        ..add(
          GetAcademicPeriodStudentEvent(
            body: PeriodStudentBody(
              token: token,
              userid: userId,
            ),
          ),
        ),
      child: BlocListener<AcademicPeriodBloc, AcademicPeriodState>(
        listener: (context, state) {
          if (state is AcademicPeriodSuccess) {
            log('get academic success');
            academicPeriodStudents = state.response.data;
            setState(() {});
          } else if (state is AcademicPeriodFailure) {
            log('get academic gagal');
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
                // hint: Row(
                //   children: const [
                //     Expanded(
                //       child: Text(
                //         'Academic Yeasr',
                //         style: TextStyle(
                //             fontSize: 14,
                //             fontWeight: FontWeight.bold,
                //             color: Palette.darkPurple),
                //         overflow: TextOverflow.ellipsis,
                //       ),
                //     ),
                //     VerticalDivider(
                //       color: Colors.white,
                //       thickness: 2,
                //     )
                //   ],
                // ),
                items: academicPeriodStudents
                    .map((item) => DropdownMenuItem<String>(
                          value: item.idAperiod,
                          child: Text(
                            item.aperiod,
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
                  widget.attendanceRateBloc.add(
                    GetAttendanceRateStudentEvent(
                      body: AttendanceRateStudentBody(
                        token: token,
                        userid: userId,
                        idAperiod: widget.selectedValue.value,
                      ),
                    ),
                  );
                  log(widget.selectedValue.value);
                },
                icon: const Icon(
                  Icons.expand_more,
                  size: 20,
                  color: Palette.darkPurple,
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
