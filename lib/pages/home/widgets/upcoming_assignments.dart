
import 'package:bryte/core/model/student/response/upcoming_assign_model.dart';
import 'package:bryte/core/student/upcoming/upcoming_bloc.dart';
import 'package:bryte/theme.dart';
import 'package:bryte/utils/palette.dart';
import 'package:bryte/widgets/card_class2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class UpcomingAssignments extends StatefulWidget {
  const UpcomingAssignments({
    Key? key,
  }) : super(key: key);

  @override
  State<UpcomingAssignments> createState() => _UpcomingAssignmentsState();
}

class _UpcomingAssignmentsState extends State<UpcomingAssignments> {
  final listNotAssign = <DataUpcomingAssignModel>[];

  @override
  Widget build(BuildContext context) {
    // final assignNotAttempt = ValueNotifier<int>(0);
    return BlocListener<UpcomingBloc, UpcomingState>(
      listener: (context, state) {
        if (state is UpcomingSuccess) {
          for (var i = 0; i < state.response.data.length; i++) {
            if (state.response.data[i].assignAttempt == false) {
              listNotAssign.addAll([state.response.data[i]]);
            }
          }
        }
      },
      child: BlocBuilder<UpcomingBloc, UpcomingState>(
        builder: (context, state) {
          if (state is UpcomingSuccess) {
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
                            style: brytStyleDarkPurlple.copyWith(fontSize: 16),
                          ),
                          const SizedBox(
                            width: 4,
                          ),
                          Container(
                            width: 30,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 3),
                            decoration: BoxDecoration(
                                color: const Color(0xffFCF1FF),
                                borderRadius:
                                    BorderRadiusDirectional.circular(12)),
                            child: Text(
                              '${state.response.data.where((element) => element.assignAttempt == false).length}',
                              style: brytStylePurlple,
                              textAlign: TextAlign.center,
                            ),
                          ),
                          const Spacer(),
                          Text(
                            'See more >',
                            style: brytStylePurlple.copyWith(
                                fontWeight: FontWeight.normal),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                if (listNotAssign.isNotEmpty)
                  Column(
                    children: List.generate(
                        listNotAssign.length >= 2 ? 2 : listNotAssign.length,
                        (i) {
                      final dateTimeNow =
                          DateFormat('dd MMMM').format(DateTime.now());
                      final compareDueDate = DateFormat('dd MMMM').format(
                          DateTime.parse(listNotAssign[i].assignDeadline));
                      final dueDate = DateFormat('dd MMMM • HH:mm').format(
                          DateTime.parse(listNotAssign[i].assignDeadline));
                      // final dueHour = DateFormat('HH:mm').format(
                      //     DateTime.parse(
                      //         state.response.data[i].assignDeadline));
                      final now = DateTime.now();

                      final tomorrow = DateFormat('dd MMMM')
                          .format(now.subtract(const Duration(days: 1)));
                      return CardUpcoming(
                          color1: Color(int.parse(listNotAssign[i]
                              .bgColor1
                              .replaceAll('#', '0xff'))),
                          color2: Color(int.parse(listNotAssign[i]
                              .bgColor2
                              .replaceAll('#', '0xff'))),
                          textColor1: Color(int.parse(listNotAssign[i]
                              .textColor1
                              .replaceAll('#', '0xff'))),
                          textColor2: Color(int.parse(listNotAssign[i]
                              .textColor2
                              .replaceAll('#', '0xff'))),
                          dropShadow: Color(
                              int.parse(listNotAssign[i].dropShadow.replaceAll('#', '0xff'))),
                          assignName: listNotAssign[i].assignName,
                          title: listNotAssign[i].courseName,
                          session: listNotAssign[i].assignSession,
                          deadline: dateTimeNow == compareDueDate
                              ? 'Today • '
                              : tomorrow == compareDueDate
                                  ? 'Tomorrow • '
                                  : dueDate,
                          instructions: listNotAssign[i].assignDescp,
                          assignAttempt: listNotAssign[i].assignAttempt);
                      // : SizedBox();
                    }),
                  )
                else //   Center(
                  Center(
                    child: Image.asset('assets/no_assignment.png'),
                  ),
                const SizedBox(
                  height: 15,
                ),
                Center(
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          elevation: 0,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 30, vertical: 15),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          onPrimary: const Color(0xffFCF1FF),
                          primary: const Color(0xffFCF1FF)),
                      onPressed: () {},
                      child: Text(
                        'View All Assignments',
                        style: brytStylebtn.copyWith(
                            color: Palette.purpleColor,
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
          } else if (state is UpcomingLoading) {
            return SizedBox(
              height: MediaQuery.of(context).size.height / 4,
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else if (state is UpcomingFailure) {
            return SizedBox(
              height: MediaQuery.of(context).size.height / 4,
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}
