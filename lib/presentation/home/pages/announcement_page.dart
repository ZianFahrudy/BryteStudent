import 'package:bryte/components/widgets/back_button.dart';
import 'package:bryte/presentation/home/local_widget/segmented_announce.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../components/utils/constant.dart';
import '../../../core/blocs/student/student_bloc.dart';
import '../../../core/data/model/student/request/announcement_body.dart';
import '../../../core/di/injection.dart';
import '../../../core/repo/auth/auth_repository.dart';
import '../local_widget/announcement_list.dart';

class AnnouncementPage extends StatefulWidget {
  const AnnouncementPage({Key? key}) : super(key: key);

  @override
  State<AnnouncementPage> createState() => _AnnouncementPageState();
}

class _AnnouncementPageState extends State<AnnouncementPage> {
  final selectedValue =
      ValueNotifier<TabAnnounceType>(TabAnnounceType.announce);

  final studentBloc = getIt<StudentBloc>();

  @override
  Widget build(BuildContext context) {
    String? token = box.read(KeyConstant.token) ?? '';

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Image.asset(
          AssetConstant.bryteLogoWhite,
          width: 59,
        ),
        leading: const BackButtonAppBar(),
      ),
      body: BlocProvider(
        create: (context) => studentBloc
          ..add(
            GetAnnouncementEvent(
              AnnouncementBody(token: token),
            ),
          ),
        child: ValueListenableBuilder<TabAnnounceType>(
          valueListenable: selectedValue,
          builder: (context, value, _) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  SegmentedAnnouncement(selectedValue: selectedValue),
                  // if (selectedValue.value == TabAnnounceType.notif)
                  //   Padding(
                  //     padding: const EdgeInsets.symmetric(horizontal: 20),
                  //     child: Column(
                  //       children: [
                  //         Row(
                  //           children: [
                  //             const Text(
                  //               'New',
                  //               style: BryteTypography.titleExtraBold,
                  //             ),
                  //             const SizedBox(width: 5),
                  //             Text(
                  //               '2',
                  //               style: BryteTypography.titleExtraBold
                  //                   .copyWith(color: Palette.purple),
                  //             ),
                  //             const Spacer(),
                  //             InkWell(
                  //               onTap: () {},
                  //               child: Row(
                  //                 children: [
                  //                   Text(
                  //                     'Settings',
                  //                     style: BryteTypography.titleExtraBold
                  //                         .copyWith(
                  //                       color: Palette.darkPurple,
                  //                     ),
                  //                   ),
                  //                   const SizedBox(width: 5),
                  //                   const Icon(
                  //                     Icons.settings,
                  //                     color: Palette.darkPurple,
                  //                   )
                  //                 ],
                  //               ),
                  //             )
                  //           ],
                  //         )
                  //       ],
                  //     ),
                  // ),
                  if (selectedValue.value == TabAnnounceType.announce)
                    const AnnouncementList()
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
