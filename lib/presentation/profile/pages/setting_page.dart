import 'package:bryte/components/utils/palette.dart';
import 'package:bryte/components/utils/typography.dart';
import 'package:bryte/components/widgets/back_button.dart';
import 'package:bryte/core/data/model/profile/response/profile_model.dart';
import 'package:bryte/presentation/auth/pages/login_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:recase/recase.dart';
import '../../../components/utils/constant.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({Key? key, required this.user}) : super(key: key);

  final UserModel user;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Palette.lighterGrey, // status bar color
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.light, // status bar icon color
      systemNavigationBarIconBrightness:
          Brightness.dark, // color of navigation controls
    ));
    final box = GetStorage();

    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Palette.lightGrey, // status bar color
          statusBarIconBrightness: Brightness.light,
          statusBarBrightness: Brightness.light, // status bar icon color
          systemNavigationBarIconBrightness:
              Brightness.dark, // color of navigation controls
        ),
        centerTitle: true,
        title: const Text('Settings'),
        leading: const BackButtonAppBar(),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 10,
        ),
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
                      user.profileimageurl!,
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
                    ReCase(user.fullname!
                            .replaceAll(RegExp('[^A-Z ]'), '')
                            .trim())
                        .titleCase,
                    style: BryteTypography.headerExtraBold.copyWith(
                      color: Palette.darkPurple,
                      fontWeight: FontWeight.w800,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    user.fullname!.split(' ').first,
                    style: BryteTypography.headerSemiBold.copyWith(
                      color: const Color(0xff000000).withOpacity(0.6),
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              )
            ],
          ),
          // Padding(
          //   padding: const EdgeInsets.only(bottom: 11, top: 26),
          //   child: Column(
          //     children: [
          //       Row(
          //         children: [
          //           const Icon(
          //             Icons.lock,
          //             size: 15,
          //           ),
          //           const SizedBox(width: 5),
          //           Text(
          //             'Privacy',
          //             style: BryteTypography.titleExtraBold.copyWith(
          //               fontSize: 15,
          //               fontWeight: FontWeight.w600,
          //             ),
          //           ),
          //         ],
          //       ),
          //       const Padding(
          //         padding: EdgeInsets.only(top: 11, bottom: 0),
          //         child: Divider(
          //           height: 0,
          //           thickness: 1,
          //           color: Palette.lighterGrey,
          //         ),
          //       ),
          //       Padding(
          //         padding: const EdgeInsets.symmetric(vertical: 9),
          //         child: Row(
          //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //           children: [
          //             Text(
          //               'Show Badges to others',
          //               style: BryteTypography.titleMedium.copyWith(
          //                 color: Palette.grey,
          //               ),
          //             ),
          //             CupertinoSwitch(
          //               value: true,
          //               activeColor: Palette.secondary100,
          //               thumbColor: Palette.darkPurple,
          //               onChanged: (s) {},
          //             )
          //           ],
          //         ),
          //       ),
          //       const Divider(
          //         height: 0,
          //         thickness: 1,
          //         color: Palette.lighterGrey,
          //       ),
          //     ],
          //   ),
          // ),
          Padding(
            padding: const EdgeInsets.only(bottom: 30, top: 30),
            child: Column(
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.notifications_active,
                      size: 15,
                    ),
                    const SizedBox(width: 5),
                    Text(
                      'Push Notifications',
                      style: BryteTypography.titleExtraBold.copyWith(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 11,
                ),
                const Divider(
                  height: 0,
                  thickness: 1,
                  color: Palette.lighterGrey,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Row(
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
                ),
                const Divider(
                  height: 0,
                  thickness: 1,
                  color: Palette.lighterGrey,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 11),
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
                const Divider(
                  height: 0,
                  thickness: 1,
                  color: Palette.lighterGrey,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 11),
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
                const Divider(
                  height: 0,
                  thickness: 1,
                  color: Palette.lighterGrey,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 30, top: 10),
            child: Column(
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.gpp_good,
                      size: 15,
                    ),
                    const SizedBox(width: 5),
                    Text(
                      'Security',
                      style: BryteTypography.titleExtraBold.copyWith(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 11,
                ),
                const Divider(
                  height: 0,
                  thickness: 1,
                  color: Palette.lighterGrey,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 11),
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
                const Divider(
                  height: 0,
                  thickness: 1,
                  color: Palette.lighterGrey,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 30, top: 10),
            child: Column(
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.live_help,
                      size: 15,
                    ),
                    const SizedBox(width: 5),
                    Text(
                      'Help Center',
                      style: BryteTypography.titleExtraBold.copyWith(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 11,
                ),
                const Divider(
                  height: 0,
                  thickness: 1,
                  color: Palette.lighterGrey,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 11),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Report an issue',
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
                const Divider(
                  height: 0,
                  thickness: 1,
                  color: Palette.lighterGrey,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 11),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Feedback',
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
                const Divider(
                  height: 0,
                  thickness: 1,
                  color: Palette.lighterGrey,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 30, top: 10),
            child: Column(
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.phone,
                      size: 15,
                    ),
                    const SizedBox(width: 5),
                    Text(
                      'Contact Bryte',
                      style: BryteTypography.titleExtraBold.copyWith(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const Divider(
                      height: 1,
                      thickness: 2,
                      color: Colors.pink,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 11,
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
                      Expanded(
                        child: Row(
                          children: [
                            Image.asset(AssetConstant.iconInstagram, width: 15),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              'Instagram',
                              style: BryteTypography.titleMedium.copyWith(
                                color: Palette.grey,
                              ),
                            ),
                          ],
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

          Center(
            child: Text(
              'BryteMobile v1.0',
              style: BryteTypography.bodyMedium.copyWith(
                color: Palette.lightGrey,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFCF1FF),
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () {
                box.remove(KeyConstant.token);
                box.remove(KeyConstant.profileImage);
                Get.offNamed(LoginPage.route);
              },
              child: Text(
                'Log Out',
                style: BryteTypography.button.copyWith(
                  color: Palette.purple,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
