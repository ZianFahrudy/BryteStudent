import 'package:bryte/components/utils/constant.dart';
import 'package:bryte/components/widgets/announcement_card.dart';
import 'package:bryte/components/widgets/empty_state.dart';
import 'package:bryte/core/blocs/student/student_bloc.dart';
import 'package:bryte/components/utils/theme.dart';
import 'package:bryte/presentation/home/pages/announcement_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/route_manager.dart';
import 'package:jiffy/jiffy.dart';

import '../../../components/utils/palette.dart';

class Announcements extends StatelessWidget {
  const Announcements({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StudentBloc, StudentState>(
      builder: (context, state) {
        if (state is AnnouncementSuccess) {
          return _buildAnnouncementSuccess(state);
        } else if (state is AnnouncementLoading) {
          return _buildAnnouncementLoading(context);
        } else if (state is AnnouncementFailure) {
          return _buildAnnouncementFailure();
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }

  Empty _buildAnnouncementFailure() {
    return const Empty(
      assetName: AssetConstant.error,
      padding: 0,
    );
  }

  SizedBox _buildAnnouncementLoading(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 4,
      child: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  Column _buildAnnouncementSuccess(AnnouncementSuccess state) {
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
                    style: brytStyleDarkPurlple.copyWith(
                        fontSize: 16,
                        fontFamily: 'SF Pro Bold',
                        fontWeight: FontWeight.w800),
                  ),
                  const Spacer(),
                  InkWell(
                    onTap: () {
                      Get.to(() => const AnnouncementPage());
                    },
                    child: Text(
                      'See more',
                      style: brytStylePurlple.copyWith(
                          fontWeight: FontWeight.w500, fontSize: 11),
                    ),
                  ),
                  const Icon(
                    Icons.chevron_right,
                    color: Palette.purple,
                    size: 10,
                  )
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
                          imageUrl: state.response.data[i].profileimageurl,
                          msg: state.response.data[i].announMsg,
                          role: state.response.data[i].roleDescp,
                          subject: state.response.data[i].announSubject,
                        )),
              )
            : const Empty(assetName: AssetConstant.noAnnouncement)
      ],
    );
  }
}
