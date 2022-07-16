import 'package:bryte/components/utils/palette.dart';
import 'package:bryte/components/utils/typography.dart';
import 'package:bryte/presentation/course/pages/course_section_page.dart';
import 'package:flutter/material.dart';

class DetailProfileParticipant extends StatelessWidget {
  const DetailProfileParticipant({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: const [
            ProfileParticipant(),
          ],
        ),
      ),
    );
  }
}

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
                      child: CircleAvatar(
                        radius: 50,
                        backgroundImage: NetworkImage(
                          listParticipants[0].imageUrl,
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
                              borderRadius: BorderRadius.circular(10)),
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

class BadgeCard extends StatelessWidget {
  const BadgeCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 130,
      child: Stack(
        children: [
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Container(
              decoration: BoxDecoration(
                // color: Colors.pink,
                borderRadius: BorderRadius.circular(15),
              ),
              width: 100,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      // color: Colors.blue,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15),
                      ),
                    ),
                    height: 97,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Text(
                      'Perfect Attendance',
                      style: BryteTypography.headerSemiBold
                          .copyWith(color: Palette.darkPurple),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 10,
            right: 15,
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Palette.purple),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
              child: Text(
                '3x',
                style:
                    BryteTypography.bodyExtraBold.copyWith(color: Colors.white),
              ),
            ),
          )
        ],
      ),
    );
  }
}
