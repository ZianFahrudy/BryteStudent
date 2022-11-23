import 'package:flutter/material.dart';

import '../../../components/utils/palette.dart';
import '../../../components/utils/typography.dart';
import 'badge_card.dart';

class ProfileParticipant extends StatelessWidget {
  const ProfileParticipant({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 30),
          color: Palette.fanta200,
          child: Column(
            children: [
              Center(
                child: Stack(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(5),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: 1 < 3 ? Palette.grey2 : Palette.orange2,
                      ),
                      child: const CircleAvatar(
                        radius: 50,
                        backgroundImage: NetworkImage(
                          'https://randomuser.me/api/portraits/men/3.jpg',
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
                          horizontal: 10,
                        ),
                        padding: const EdgeInsets.all(2),
                        height: 25,
                        child: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: 1 < 3 ? Palette.grey1 : Palette.orange1,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Spacer(),
                              Text(
                                'LEVEL',
                                style: BryteTypography.bodyRegular.copyWith(
                                  color: Colors.white,
                                  fontSize: 12,
                                ),
                              ),
                              const Spacer(),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 2,
                                ),
                                margin: const EdgeInsets.only(right: 2),
                                decoration: BoxDecoration(
                                  color:
                                      1 < 3 ? Palette.grey2 : Palette.orange2,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Text(
                                  '3',
                                  style: BryteTypography.bodyRegular.copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              Text(
                'Kevin Matthew Kandi',
                style: BryteTypography.headerExtraBold
                    .copyWith(color: Palette.orange2),
              ),
              const SizedBox(height: 5),
              Text(
                'S1 Product Design Engineering 2018',
                style: BryteTypography.headerSemiBold
                    .copyWith(fontWeight: FontWeight.normal),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          child: Row(
            children: [
              const Text(
                'Badges',
                style: BryteTypography.headerExtraBold,
              ),
              const SizedBox(width: 10),
              Text(
                '14',
                style: BryteTypography.headerExtraBold.copyWith(
                  color: Palette.purple,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0),
          child: Center(
            child: Wrap(
              alignment: WrapAlignment.center,
              direction: Axis.horizontal,
              crossAxisAlignment: WrapCrossAlignment.start,
              runAlignment: WrapAlignment.spaceAround,
              runSpacing: 0,
              spacing: 0,
              children: const [
                BadgeCard(),
                BadgeCard(),
                BadgeCard(),
                BadgeCard(),
                BadgeCard(),
                BadgeCard(),
              ],
            ),
          ),
        )
      ],
    );
  }
}
