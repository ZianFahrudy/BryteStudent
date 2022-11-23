import 'dart:developer';

import 'package:bryte/core/blocs/academic_period/academic_period_bloc.dart';
import 'package:bryte/core/blocs/attendance_rate/bloc/attendance_rate_det_bloc.dart';
import 'package:bryte/core/data/model/profile/request/attendance_rate_student.dart';
import 'package:bryte/core/data/model/profile/request/period_student_body.dart';
import 'package:bryte/core/data/model/profile/response/period_per_student_model.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';
import '../../../components/utils/constant.dart';
import '../../../components/utils/palette.dart';
import '../../../core/di/injection.dart';

class DropdownAttdRate extends StatefulWidget {
  const DropdownAttdRate({
    Key? key,
    required this.selectedValue,
    required this.attendanceRateDetBloc,
  }) : super(key: key);

  final ValueNotifier<String> selectedValue;
  final AttendanceRateDetBloc attendanceRateDetBloc;

  @override
  State<DropdownAttdRate> createState() => _DropdownAttdRateState();
}

class _DropdownAttdRateState extends State<DropdownAttdRate> {
  final academicPeriodBloc = getIt<AcademicPeriodBloc>();

  List<DataPeriodPerStudentModel> listPeriodStudents = [];

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
            log('get academic period success');
            listPeriodStudents = state.response.data;

            setState(() {});
          } else if (state is AcademicPeriodFailure) {
            log('get academic period gagal');
          }
        },
        child: Padding(
          padding: const EdgeInsets.only(
            left: 20,
            top: 15,
            bottom: 15,
          ),
          child: DropdownButtonHideUnderline(
            child: ValueListenableBuilder<String>(
              valueListenable: widget.selectedValue,
              builder: (context, _, __) => DropdownButton2(
                isExpanded: true,
                items: listPeriodStudents
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
                  widget.attendanceRateDetBloc.add(
                    GetAttendaceRateDetEvent(
                      body: AttendanceRateStudentBody(
                        token: token,
                        userid: userId,
                        idAperiod: widget.selectedValue.value,
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
                buttonWidth: 200,
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
                dropdownWidth: 200,
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
