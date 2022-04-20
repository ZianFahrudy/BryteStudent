import 'package:bryte/core/student/summary/summary_bloc.dart';
import 'package:bryte/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class HeaderHome extends StatefulWidget {
  const HeaderHome({
    Key? key,
  }) : super(key: key);

  @override
  State<HeaderHome> createState() => _HeaderHomeState();
}

class _HeaderHomeState extends State<HeaderHome> {
  @override
  Widget build(BuildContext context) {
    final today = DateTime.now();

    final condition1 = ValueNotifier<bool>(false);
    final condition2 = ValueNotifier<bool>(false);
    final condition3 = ValueNotifier<bool>(false);
    final condition4 = ValueNotifier<bool>(false);
    final condition5 = ValueNotifier<bool>(false);
    final condition6 = ValueNotifier<bool>(false);
    final condition7 = ValueNotifier<bool>(false);
    final condition8 = ValueNotifier<bool>(false);
    final condition9 = ValueNotifier<bool>(false);

    Widget conditionWidget(ClassSummaryStudentSuccess state) {
      if (condition1.value) {
        return RichText(
          text: TextSpan(
            text: 'You have ',
            style: brytStyleJudul.copyWith(fontSize: 14),
            children: [
              (state.response.data.todayClasses == 1)
                  ? TextSpan(
                      text: '${state.response.data.todayClasses} class ',
                      style: brytStyleDarkPurlple.copyWith(fontSize: 14))
                  : TextSpan(
                      text: '${state.response.data.todayClasses} classes ',
                      style: brytStyleDarkPurlple.copyWith(fontSize: 14)),
              TextSpan(
                text: 'today and ',
                style: brytStyleJudul.copyWith(fontSize: 14),
              ),
              TextSpan(
                  text:
                      '${state.response.data.assignAll} upcoming assignments, ',
                  style: brytStyleDarkPurlple.copyWith(fontSize: 14)),
              TextSpan(
                  text:
                      '${state.response.data.assignTomorrow} is due tomorrow.',
                  style: brytStyleJudul.copyWith(fontSize: 14)),
            ],
          ),
        );
      } else if (condition2.value) {
        return RichText(
          text: TextSpan(
            text: 'You have ',
            style: brytStyleJudul.copyWith(fontSize: 14),
            children: [
              (state.response.data.todayClasses == 1)
                  ? TextSpan(
                      text: '${state.response.data.todayClasses} class ',
                      style: brytStyleDarkPurlple.copyWith(fontSize: 14))
                  : TextSpan(
                      text: '${state.response.data.todayClasses} classes ',
                      style: brytStyleDarkPurlple.copyWith(fontSize: 14)),
              TextSpan(
                text: 'today and ',
                style: brytStyleJudul.copyWith(fontSize: 14),
              ),
              TextSpan(
                  text:
                      '${state.response.data.assignAll} upcoming assignments, ',
                  style: brytStyleDarkPurlple.copyWith(fontSize: 14)),
              TextSpan(
                  text:
                      '${state.response.data.assignThisWeek} is due this week.',
                  style: brytStyleJudul.copyWith(fontSize: 14)),
            ],
          ),
        );
      } else if (condition3.value) {
        return RichText(
          text: TextSpan(
            text: 'You have ',
            style: brytStyleJudul.copyWith(fontSize: 14),
            children: [
              (state.response.data.todayClasses == 1)
                  ? TextSpan(
                      text: '${state.response.data.todayClasses} class ',
                      style: brytStyleDarkPurlple.copyWith(fontSize: 14))
                  : TextSpan(
                      text: '${state.response.data.todayClasses} classes ',
                      style: brytStyleDarkPurlple.copyWith(fontSize: 14)),
              TextSpan(
                text: 'today and ',
                style: brytStyleJudul.copyWith(fontSize: 14),
              ),
              TextSpan(
                  text:
                      '${state.response.data.assignAll} upcoming assignments.',
                  style: brytStyleDarkPurlple.copyWith(fontSize: 14)),
            ],
          ),
        );
      } else if (condition4.value) {
        return RichText(
          text: TextSpan(
            text: 'You have ',
            style: brytStyleJudul.copyWith(fontSize: 14),
            children: [
              (state.response.data.todayClasses == 1)
                  ? TextSpan(
                      text: '${state.response.data.todayClasses} class ',
                      style: brytStyleDarkPurlple.copyWith(fontSize: 14))
                  : TextSpan(
                      text: '${state.response.data.todayClasses} classes ',
                      style: brytStyleDarkPurlple.copyWith(fontSize: 14)),
              TextSpan(
                text: 'today.',
                style: brytStyleJudul.copyWith(fontSize: 14),
              ),
            ],
          ),
        );
      } else if (condition5.value) {
        return RichText(
          text: TextSpan(
            text: 'You have ',
            style: brytStyleJudul.copyWith(fontSize: 14),
            children: [
              TextSpan(
                  text:
                      '${state.response.data.assignAll} upcoming assignments.',
                  style: brytStyleDarkPurlple.copyWith(fontSize: 14)),
            ],
          ),
        );
      } else if (condition6.value) {
        return RichText(
          text: TextSpan(
            text: 'You have ',
            style: brytStyleJudul.copyWith(fontSize: 14),
            children: [
              TextSpan(
                  text:
                      '${state.response.data.assignAll} upcoming assignments, ',
                  style: brytStyleDarkPurlple.copyWith(fontSize: 14)),
              TextSpan(
                text: '${state.response.data.assignTomorrow} is due tomorrow.',
                style: brytStyleJudul.copyWith(fontSize: 14),
              ),
            ],
          ),
        );
      } else if (condition7.value) {
        return RichText(
          text: TextSpan(
            text: 'You have ',
            style: brytStyleJudul.copyWith(fontSize: 14),
            children: [
              TextSpan(
                  text:
                      '${state.response.data.assignAll} upcoming assignments, ',
                  style: brytStyleDarkPurlple.copyWith(fontSize: 14)),
              TextSpan(
                text: '${state.response.data.assignThisWeek} is due this week.',
                style: brytStyleJudul.copyWith(fontSize: 14),
              ),
            ],
          ),
        );
      } else if (condition8.value) {
        return RichText(
          text: TextSpan(
            text: 'You have ',
            style: brytStyleJudul.copyWith(fontSize: 14),
            children: [
              (state.response.data.todayClasses == 1)
                  ? TextSpan(
                      text: '${state.response.data.todayClasses} class ',
                      style: brytStyleDarkPurlple.copyWith(fontSize: 14))
                  : TextSpan(
                      text: '${state.response.data.todayClasses} classes ',
                      style: brytStyleDarkPurlple.copyWith(fontSize: 14)),
              TextSpan(
                text: 'today ',
                style: brytStyleJudul.copyWith(fontSize: 14),
              ),
              TextSpan(
                text: '${state.response.data.assignTomorrow} is due tomorrow.',
                style: brytStyleJudul.copyWith(fontSize: 14),
              ),
            ],
          ),
        );
      } else if (condition9.value) {
        return RichText(
          text: TextSpan(
            text: 'You have ',
            style: brytStyleJudul.copyWith(fontSize: 14),
            children: [
              (state.response.data.todayClasses == 1)
                  ? TextSpan(
                      text: '${state.response.data.todayClasses} class ',
                      style: brytStyleDarkPurlple.copyWith(fontSize: 14))
                  : TextSpan(
                      text: '${state.response.data.todayClasses} classes ',
                      style: brytStyleDarkPurlple.copyWith(fontSize: 14)),
              TextSpan(
                text: 'today and ',
                style: brytStyleJudul.copyWith(fontSize: 14),
              ),
              TextSpan(
                  text:
                      '${state.response.data.assignAll} upcoming assignments, ',
                  style: brytStyleDarkPurlple.copyWith(fontSize: 14)),
              TextSpan(
                  text:
                      '${state.response.data.assignTomorrow} is due tomorrow.',
                  style: brytStyleJudul.copyWith(fontSize: 14)),
            ],
          ),
        );
      }

      return const SizedBox();
    }

    return BlocBuilder<SummaryBloc, SummaryState>(
      builder: (context, state) {
        if (state is ClassSummaryStudentSuccess) {
          final data = state.response.data;

          if (data.todayClasses != 0 &&
              data.assignAll != 0 &&
              data.assignTomorrow != 0) {
            condition9.value = true;
          } else if (data.todayClasses != 0 &&
              data.assignAll != 0 &&
              data.assignTomorrow != 0 &&
              data.assignThisWeek != 0) {
            condition1.value = true;
          } else if (data.todayClasses != 0 &&
              data.assignAll != 0 &&
              data.assignTomorrow == 0 &&
              data.assignThisWeek != 0) {
            condition2.value = true;
          } else if (data.todayClasses != 0 &&
              data.assignAll != 0 &&
              data.assignTomorrow == 0 &&
              data.assignThisWeek == 0) {
            condition3.value = true;
          } else if (data.todayClasses != 0 && data.assignAll == 0) {
            condition4.value = true;
          } else if (data.todayClasses == 0 &&
              data.assignAll != 0 &&
              data.assignTomorrow == 0 &&
              data.assignThisWeek == 0) {
            condition5.value = true;
          } else if (data.todayClasses == 0 &&
              data.assignAll != 0 &&
              data.assignTomorrow != 0 &&
              data.assignThisWeek == 0) {
            condition6.value = true;
          } else if (data.todayClasses == 0 &&
              data.assignAll != 0 &&
              data.assignTomorrow == 0) {
            condition7.value = true;
          } else if (data.todayClasses == 0 &&
              data.assignAll != 0 &&
              data.assignTomorrow != 0 &&
              data.assignThisWeek != 0) {
            condition8.value = true;
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 7),
                child: Image.asset(
                  'assets/logo5.png',
                  fit: BoxFit.cover,
                  width: 150,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      DateFormat('EEEE, d MMMM').format(today),
                      style: brytStylebtnBlack,
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    conditionWidget(state),
                    const SizedBox(
                      height: 15,
                    ),
                  ],
                ),
              ),
              Divider(
                color: bryteGreyLight,
              ),
              const SizedBox(
                height: 15,
              ),
            ],
          );
        } else if (state is ClassSummaryStudentLoading) {
          return SizedBox(
            height: MediaQuery.of(context).size.height / 4,
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (state is ClassSummaryStudentFailure) {
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
    );
  }
}
