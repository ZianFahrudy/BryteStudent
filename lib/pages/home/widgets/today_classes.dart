import 'package:bryte/core/student/class/class_bloc.dart';
import 'package:bryte/theme.dart';
import 'package:bryte/widgets/card_class.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class TodayClasses extends StatefulWidget {
  const TodayClasses({
    Key? key,
  }) : super(key: key);

  @override
  State<TodayClasses> createState() => _TodayClassesState();
}

class _TodayClassesState extends State<TodayClasses> {
  final todayClassesTotal = ValueNotifier<int>(0);
  final ongoingClassesTotal = ValueNotifier<int>(0);

  final totalToday = ValueNotifier<int>(0);

  @override
  Widget build(BuildContext context) {
    return BlocListener<ClassBloc, ClassState>(
      listener: (context, state) {
        if (state is ClassSuccess) {
          if (state.response.data
              .every((element) => element.status == 'past')) {
            state.response.message = 'all_past';
          }
        }
      },
      child: BlocBuilder<ClassBloc, ClassState>(
        builder: (context, state) {
          if (state is ClassSuccess) {
            todayClassesTotal.value = state.response.data
                .where((element) => element.status == 'today')
                .length;
            ongoingClassesTotal.value = state.response.data
                .where((element) => element.status == 'ongoing')
                .length;

            totalToday.value =
                todayClassesTotal.value + ongoingClassesTotal.value;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.school,
                        size: 27,
                        color: bryteDarkPurple,
                      ),
                      Row(
                        children: [
                          Text(
                            'Today\'s Classes',
                            style: brytStyleDarkPurlple.copyWith(fontSize: 16),
                          ),
                          const SizedBox(
                            width: 4,
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                                color: const Color(0xffFCF1FF),
                                borderRadius:
                                    BorderRadiusDirectional.circular(12)),
                            child: Row(
                              children: [
                                Text(
                                  totalToday.value.toString(),
                                  style: brytStylePurlple.copyWith(
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.center,
                                ),
                                Text(
                                  ' left',
                                  style: brytStylePurlple.copyWith(
                                      fontWeight: FontWeight.normal),
                                ),
                              ],
                            ),
                          ),
                          const Spacer(),
                          Text(
                            'See Weekly >',
                            style: brytStylePurlple.copyWith(
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                if (state.response.data.isNotEmpty)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: List.generate(
                        state.response.message == 'all_past'
                            ? 1
                            : state.response.data.length, (i) {
                      return (state.response.data[i].status == 'ongoing' ||
                              state.response.data[i].status == 'today')
                          ? CardClasses(
                              status: state.response.data[i].status,
                              boxShadowColor: Color(int.parse(state
                                  .response.data[i].dropShadow
                                  .replaceAll('#', '0xff'))),
                              textColor1: Color(int.parse(state
                                  .response.data[i].textColor1
                                  .replaceAll('#', '0xff'))),
                              textColor2: Color(int.parse(state
                                  .response.data[i].textColor1
                                  .replaceAll('#', '0xff'))),
                              absentTotal:
                                  state.response.data[i].statusset.length,
                              className: state.response.data[i].classes,
                              credits: state.response.data[i].sks,
                              absentLeft: int.parse(state.response.data[i].sks),
                              session: state.response.data[i].attdSession,
                              startTime: DateFormat('HH:mm').format(
                                  DateTime.parse(
                                      state.response.data[i].startTime)),
                              endTime: DateFormat('HH:mm').format(
                                  DateTime.parse(
                                      state.response.data[i].endTime)),
                              selected: true,
                              color1: Color(int.parse(state
                                  .response.data[i].bgColor1
                                  .replaceAll('#', '0xff'))),
                              color2: Color(int.parse(state
                                  .response.data[i].bgColor2
                                  .replaceAll('#', '0xff'))),
                            )
                          : (state.response.message == 'all_past')
                              ? Center(
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 15),
                                    child: Image.asset(
                                        'assets/no_classes_left.png',
                                        fit: BoxFit.cover),
                                  ),
                                )
                              : const SizedBox();
                    }),
                  )
                else
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: Image.asset(
                        'assets/no_classes.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                const SizedBox(
                  height: 15,
                ),
                Divider(
                  color: bryteGreyLight,
                ),
                const SizedBox(
                  height: 15,
                ),
              ],
            );
          } else if (state is ClassLoading) {
            return SizedBox(
              height: MediaQuery.of(context).size.height / 4,
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else if (state is ClassFailure) {
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
