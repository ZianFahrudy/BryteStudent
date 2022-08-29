import 'package:bryte/components/utils/palette.dart';
import 'package:bryte/components/utils/typography.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Column(
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: Palette.grey1,
                  radius: 30,
                  child: Center(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Image.network(
                        'https://randomuser.me/api/portraits/men/8.jpg',
                        width: 52,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Farel Julian Suryadi',
                      style: BryteTypography.headerExtraBold
                          .copyWith(color: Palette.darkPurple),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      '23601810009',
                      style: BryteTypography.headerSemiBold
                          .copyWith(color: Palette.grey),
                    ),
                  ],
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 30, top: 10),
              child: Column(children: [
                Row(
                  children: const [
                    Icon(
                      Icons.lock,
                    ),
                    SizedBox(width: 5),
                    Text(
                      'Privacy',
                      style: BryteTypography.titleExtraBold,
                    ),
                    Divider(
                      height: 1,
                      thickness: 2,
                      color: Colors.pink,
                    ),
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 5,
                    // horizontal: 20,
                  ),
                  child: Divider(
                    height: 0,
                    thickness: 1,
                    color: Palette.lighterGrey,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Show Badges to others',
                      style: BryteTypography.titleMedium.copyWith(
                        color: Palette.grey,
                      ),
                    ),
                    CupertinoSwitch(
                      value: true,
                      activeColor: Palette.secondary100,
                      thumbColor: Palette.darkPurple,
                      onChanged: (s) {},
                    )
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 5,
                    // horizontal: 20,
                  ),
                  child: Divider(
                    height: 0,
                    thickness: 1,
                    color: Palette.lighterGrey,
                  ),
                ),
              ]),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 30, top: 10),
              child: Column(
                children: [
                  Row(
                    children: const [
                      Icon(
                        Icons.notifications,
                      ),
                      SizedBox(width: 5),
                      Text(
                        'Push Notifications',
                        style: BryteTypography.titleExtraBold,
                      ),
                      Divider(
                        height: 1,
                        thickness: 2,
                        color: Colors.pink,
                      ),
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 5,
                      // horizontal: 20,
                    ),
                    child: Divider(
                      height: 0,
                      thickness: 1,
                      color: Palette.lighterGrey,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Pause All',
                        style: BryteTypography.titleMedium.copyWith(
                          color: Palette.grey,
                        ),
                      ),
                      CupertinoSwitch(
                        value: true,
                        activeColor: Palette.secondary100,
                        thumbColor: Palette.darkPurple,
                        onChanged: (s) {},
                      )
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 5,
                    ),
                    child: Divider(
                      height: 0,
                      thickness: 1,
                      color: Palette.lighterGrey,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Announcements',
                          style: BryteTypography.titleMedium.copyWith(
                            color: Palette.grey,
                          ),
                        ),
                        const Icon(
                          Icons.arrow_forward_ios_outlined,
                          size: 15,
                          color: Palette.purple,
                        )
                      ],
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 5,
                      // horizontal: 20,
                    ),
                    child: Divider(
                      height: 0,
                      thickness: 1,
                      color: Palette.lighterGrey,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Notifications & Reminders',
                          style: BryteTypography.titleMedium.copyWith(
                            color: Palette.grey,
                          ),
                        ),
                        const Icon(
                          Icons.arrow_forward_ios_outlined,
                          size: 15,
                          color: Palette.purple,
                        )
                      ],
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 5,
                    ),
                    child: Divider(
                      height: 0,
                      thickness: 1,
                      color: Palette.lighterGrey,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 30, top: 10),
              child: Column(
                children: [
                  Row(
                    children: const [
                      Icon(
                        Icons.notifications,
                      ),
                      SizedBox(width: 5),
                      Text(
                        'Security',
                        style: BryteTypography.titleExtraBold,
                      ),
                      Divider(
                        height: 1,
                        thickness: 2,
                        color: Colors.pink,
                      ),
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 5,
                    ),
                    child: Divider(
                      height: 0,
                      thickness: 1,
                      color: Palette.lighterGrey,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Change Password',
                          style: BryteTypography.titleMedium.copyWith(
                            color: Palette.grey,
                          ),
                        ),
                        const Icon(
                          Icons.arrow_forward_ios_outlined,
                          size: 15,
                          color: Palette.purple,
                        )
                      ],
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 5,
                    ),
                    child: Divider(
                      height: 0,
                      thickness: 1,
                      color: Palette.lighterGrey,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 30, top: 10),
              child: Column(
                children: [
                  Row(
                    children: const [
                      Icon(
                        Icons.notifications,
                      ),
                      SizedBox(width: 5),
                      Text(
                        'Help Center',
                        style: BryteTypography.titleExtraBold,
                      ),
                      Divider(
                        height: 1,
                        thickness: 2,
                        color: Colors.pink,
                      ),
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 5,
                    ),
                    child: Divider(
                      height: 0,
                      thickness: 1,
                      color: Palette.lighterGrey,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Change Password',
                          style: BryteTypography.titleMedium.copyWith(
                            color: Palette.grey,
                          ),
                        ),
                        const Icon(
                          Icons.arrow_forward_ios_outlined,
                          size: 15,
                          color: Palette.purple,
                        )
                      ],
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 5,
                    ),
                    child: Divider(
                      height: 0,
                      thickness: 1,
                      color: Palette.lighterGrey,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
