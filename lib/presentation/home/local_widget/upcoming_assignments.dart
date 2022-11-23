import 'package:bryte/components/utils/constant.dart';
import 'package:bryte/components/utils/hex_color.dart';
import 'package:bryte/components/widgets/card_class2.dart';
import 'package:bryte/components/widgets/empty_state.dart';
import 'package:bryte/core/blocs/upcoming/upcoming_bloc.dart';

import 'package:bryte/core/data/model/student/response/upcoming_assign_model.dart';
import 'package:bryte/components/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../components/utils/palette.dart';
import '../../navigation/cubits/nav_course/nav_course_cubit.dart';

class UpcomingAssignments extends StatefulWidget {
  const UpcomingAssignments({
    Key? key,
    required this.selectedIndex,
    required this.navCourseCubit,
  }) : super(key: key);

  final ValueNotifier<int> selectedIndex;
  final NavCourseCubit navCourseCubit;

  @override
  State<UpcomingAssignments> createState() => _UpcomingAssignmentsState();
}

class _UpcomingAssignmentsState extends State<UpcomingAssignments> {
  final listNotAssign = <DataUpcomingAssignModel>[];

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<UpcomingBloc, UpcomingState>(
          listener: (context, state) {
            // if (state is UpcomingSuccess) {
            //   for (var i = 0; i < state.response.data.length; i++) {
            //     listNotAssign.length = 0;

            //     if (state.response.data[i].assignAttempt == false) {
            //       listNotAssign.addAll([state.response.data[i]]);
            //     }
            //   }
            // }
          },
        ),
      ],
      child: BlocBuilder<UpcomingBloc, UpcomingState>(
        builder: (context, state) {
          if (state is UpcomingSuccess) {
            return _buildUpcomingSucces(state);
          } else if (state is UpcomingLoading) {
            return _buildUpcomingLoading(context);
          } else if (state is UpcomingFailure) {
            return _buildUpcomingFailure();
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }

  Empty _buildUpcomingFailure() {
    return const Empty(
      assetName: AssetConstant.error,
      padding: 0,
    );
  }

  SizedBox _buildUpcomingLoading(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 4,
      child: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  Column _buildUpcomingSucces(UpcomingSuccess state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                Icons.assignment,
                size: 27,
                color: bryteDarkPurple,
              ),
              Row(
                children: [
                  Text(
                    'Upcoming Assignments',
                    style: brytStyleDarkPurlple.copyWith(
                      fontSize: 16,
                      fontFamily: 'SF Pro Bold',
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  Container(
                    width: 30,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                    decoration: BoxDecoration(
                        color: const Color(0xffFCF1FF),
                        borderRadius: BorderRadiusDirectional.circular(12)),
                    child: Text(
                      '${state.response.data.length}',
                      style: brytStylePurlple.copyWith(
                          fontFamily: 'SF Pro Bold',
                          fontSize: 14,
                          fontWeight: FontWeight.w800),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const Spacer(),
                  InkWell(
                    onTap: () {
                      widget.navCourseCubit.toAssignmentTab();
                      // setState(() {
                      widget.selectedIndex.value = 1;
                      // widget.selectedtabType.value = TabType.assignments;
                      // widget.tapFromHome.value = true;
                      // });
                    },
                    child: Row(
                      children: [
                        Text(
                          'See more',
                          style: brytStylePurlple.copyWith(
                              fontWeight: FontWeight.w500, fontSize: 11),
                        ),
                        const Icon(
                          Icons.chevron_right,
                          color: Palette.purple,
                          size: 10,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        if (state.response.data.isNotEmpty)
          Column(
            children: List.generate(state.response.data.length, (i) {
              final dateTimeNow = DateFormat('dd MMMM').format(DateTime.now());
              final compareDueDate = DateFormat('dd MMMM').format(
                  DateTime.parse(state.response.data[i].assignDeadline));
              final dueDate = DateFormat('dd MMMM • HH:mm').format(
                  DateTime.parse(state.response.data[i].assignDeadline));

              final now = DateTime.now();

              final tomorrow = DateFormat('dd MMMM')
                  .format(now.subtract(const Duration(days: 1)));
              return CardUpcoming(
                  color1: HexColor(state.response.data[i].bgColor1),
                  color2: HexColor(state.response.data[i].bgColor2),
                  textColor1: HexColor(state.response.data[i].textColor1),
                  textColor2: HexColor(state.response.data[i].textColor2),
                  dropShadow: HexColor(state.response.data[i].dropShadow),
                  assignName: state.response.data[i].assignName,
                  title: state.response.data[i].courseName,
                  session: state.response.data[i].assignSession,
                  deadline: dateTimeNow == compareDueDate
                      ? 'Today • '
                      : tomorrow == compareDueDate
                          ? 'Tomorrow • '
                          : dueDate,
                  instructions: state.response.data[i].assignDescp,
                  assignAttempt: state.response.data[i].assignAttempt);
            }),
          )
        else //   Center(
          const Empty(assetName: AssetConstant.noAssignment),
        const SizedBox(
          height: 15,
        ),
        Center(
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  foregroundColor: const Color(0xffFCF1FF),
                  backgroundColor: const Color(0xffFCF1FF),
                  elevation: 0,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10))),
              onPressed: () {
                widget.navCourseCubit.toAssignmentTab();

                widget.selectedIndex.value = 1;
              },
              child: Text(
                'View All Assignments',
                style: brytStylebtn.copyWith(
                    color: Palette.purple,
                    fontSize: 14,
                    fontWeight: FontWeight.bold),
              )),
        ),
        const SizedBox(
          height: 20,
        ),
        Divider(
          color: bryteGreyLight,
          height: 0,
        ),
        const SizedBox(
          height: 15,
        ),
      ],
    );
  }
}
