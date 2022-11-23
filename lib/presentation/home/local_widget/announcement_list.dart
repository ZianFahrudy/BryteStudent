import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jiffy/jiffy.dart';

import '../../../components/utils/constant.dart';
import '../../../components/widgets/announcement_card.dart';
import '../../../components/widgets/empty_state.dart';
import '../../../core/blocs/student/student_bloc.dart';

class AnnouncementList extends StatelessWidget {
  const AnnouncementList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StudentBloc, StudentState>(
      builder: (context, state) {
        if (state is AnnouncementSuccess) {
          return Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 20,
            ),
            child: Column(
              children: List.generate(
                state.response.data.length,
                (i) => AnnouncementCard(
                  author: state.response.data[i].announAuthor,
                  date: Jiffy(state.response.data[i].announDate, 'yyyy-MM-dd')
                      .fromNow(),
                  imageUrl: state.response.data[i].profileimageurl,
                  msg: state.response.data[i].announMsg,
                  role: state.response.data[i].roleDescp,
                  subject: state.response.data[i].announSubject,
                ),
              ),
            ),
          );
        } else if (state is AnnouncementLoading) {
          return SizedBox(
            height: MediaQuery.of(context).size.height / 4,
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (state is AnnouncementFailure) {
          return const Empty(
            assetName: AssetConstant.error,
            padding: 0,
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
