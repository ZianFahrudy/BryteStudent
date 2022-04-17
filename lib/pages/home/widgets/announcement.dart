import 'package:bryte/core/student/student_bloc.dart';
import 'package:bryte/theme.dart';
import 'package:bryte/widgets/announcement_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jiffy/jiffy.dart';

class Announcements extends StatelessWidget {
  const Announcements({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StudentBloc, StudentState>(
      builder: (context, state) {
        if (state is AnnouncementSuccess) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.campaign,
                      size: 27,
                      color: bryteDarkPurple,
                    ),
                    Row(
                      children: [
                        Text(
                          'Announcements',
                          style: brytStyleDarkPurlple.copyWith(fontSize: 16),
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
              (state.response.data.isNotEmpty)
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: List.generate(
                          1,
                          (i) => AnnouncementCard(
                                author: state.response.data[i].announAuthor,
                                date: Jiffy(state.response.data[i].announDate,
                                        'yyyy-MM-dd')
                                    .fromNow(),
                                imageUrl:
                                    state.response.data[i].profileimageurl,
                                msg: state.response.data[i].announMsg,
                                role: state.response.data[i].roleDescp,
                                subject: state.response.data[i].announSubject,
                              )),
                    )
                  : Center(
                      child: Image.asset(
                        'assets/no_announcement.png',
                        fit: BoxFit.cover,
                      ),
                    )
            ],
          );
        } else if (state is AnnouncementLoading) {
          return SizedBox(
            height: MediaQuery.of(context).size.height / 4,
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (state is AnnouncementFailure) {
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
