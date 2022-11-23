import 'dart:developer';

import 'package:bryte/core/blocs/master_section/master_section_bloc.dart';
import 'package:bryte/core/data/model/course/request/master_section_body.dart';
import 'package:bryte/core/data/model/course/response/master_course_section_model.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';

import '../../../components/utils/constant.dart';
import '../../../components/utils/palette.dart';
import '../../../core/di/injection.dart';

class DropdownGeneralSection extends StatefulWidget {
  const DropdownGeneralSection({
    Key? key,
    required this.selectedValue,
    required this.idCourse,
    this.onChanged,
  }) : super(key: key);

  final ValueNotifier<String> selectedValue;
  final String idCourse;
  final Function(String?)? onChanged;

  @override
  State<DropdownGeneralSection> createState() => _DropdownGeneralSectionState();
}

class _DropdownGeneralSectionState extends State<DropdownGeneralSection> {
  final masterSectionBloc = getIt<MasterSectionBloc>();

  List<DataMasterCourseSectionModel> listDataMasterSection = [];

  @override
  Widget build(BuildContext context) {
    final box = GetStorage();

    final token = box.read(KeyConstant.token);
    final userId = box.read(KeyConstant.userId);
    return BlocProvider(
      create: (context) => masterSectionBloc
        ..add(GetMasterCourseSection(
            body: MasterSectionBody(
                token: token, userid: userId, idCourse: widget.idCourse))),
      child: BlocListener<MasterSectionBloc, MasterSectionState>(
        listener: (context, state) {
          if (state is MasterSectionSuccess) {
            log('get master course section success');
            listDataMasterSection = state.response.data;

            // log(listDataMasterSection.length.toString());

            setState(() {});
          } else if (state is MasterSectionFailure) {
            log('get master course section gagal');
          }
        },
        child: DropdownButtonHideUnderline(
          child: ValueListenableBuilder<String>(
            valueListenable: widget.selectedValue,
            builder: (context, _, __) => DropdownButton2(
              isExpanded: true,
              // hint: Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceAround,
              //   children: const [
              //     Expanded(
              //       child: Text(
              //         'All Semester',
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
              items: listDataMasterSection
                  .map((item) => DropdownMenuItem<String>(
                        value: item.id.toString(),
                        child: Text(
                          item.sectionName ?? '',
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
              onChanged: widget.onChanged,
              // onChanged: (value) {
              //   widget.selectedValue.value = value as String;

              //   log(widget.selectedValue.value);

              //   // if (widget.selectedValue.value == )
              // },
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
              // buttonHeight: 35,
              // buttonWidth: 50,
              buttonPadding: const EdgeInsets.only(left: 14, right: 14),
              buttonDecoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: Colors.black26,
                ),
                color: Palette.purple1,
              ),
              buttonElevation: 2,
              customButton: Container(
                width: 30,
                height: 50,
                alignment: Alignment.center,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(14)),
                child: const Icon(Icons.expand_more),
              ),
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
    );
  }
}
