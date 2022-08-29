import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../components/utils/palette.dart';
import '../../../../components/utils/typography.dart';
import '../course_section_page.dart';
import '../detail_profile_participant.dart';

class ParticipantContent extends StatelessWidget {
  const ParticipantContent({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Row(
            children: [
              const Text(
                'Participants',
                style: BryteTypography.headerExtraBold,
              ),
              const SizedBox(width: 5),
              Text(
                '1',
                style: BryteTypography.headerExtraBold.copyWith(
                  fontSize: 16,
                  color: Palette.purple,
                ),
              ),
            ],
          ),
        ),
        const Divider(
          thickness: 1,
          height: 0,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            children: List.generate(
              listParticipants.length,
              (index) => Card(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    bottomLeft: Radius.circular(30),
                    topRight: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                ),
                child: InkWell(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(30),
                    bottomLeft: Radius.circular(30),
                    topRight: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                  onTap: () => Get.to(() => const DetailProfileParticipant()),
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Row(
                      children: [
                        Stack(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(3),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: listParticipants[index].level < 3
                                    ? Palette.grey2
                                    : Palette.orange2,
                              ),
                              child: CircleAvatar(
                                radius: 25,
                                backgroundImage: NetworkImage(
                                  listParticipants[index].imageUrl,
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              left: 0,
                              right: 0,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(
                                    15,
                                  ),
                                ),
                                margin: const EdgeInsets.symmetric(
                                  horizontal: 5,
                                ),
                                padding: const EdgeInsets.all(2),
                                height: 16,
                                child: Container(
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      color: listParticipants[index].level < 3
                                          ? Palette.grey1
                                          : Palette.orange1,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      const Spacer(),
                                      Text(
                                        'LVL',
                                        style: BryteTypography.bodyRegular
                                            .copyWith(
                                                color: Colors.white,
                                                fontSize: 8),
                                      ),
                                      const Spacer(),
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 5),
                                        decoration: BoxDecoration(
                                            color:
                                                listParticipants[index].level <
                                                        3
                                                    ? Palette.grey2
                                                    : Palette.orange2,
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Text(
                                          listParticipants[index]
                                              .level
                                              .toString(),
                                          style: BryteTypography.bodyRegular
                                              .copyWith(color: Colors.white),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          width: 30,
                        ),
                        Text(
                          listParticipants[index].name,
                          style: BryteTypography.titleExtraBold,
                        ),
                        const Spacer(),
                        const Icon(
                          Icons.chevron_right,
                          color: Palette.purple,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
