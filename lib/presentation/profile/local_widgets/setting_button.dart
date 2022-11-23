import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../components/utils/typography.dart';
import '../../../core/data/model/profile/response/profile_model.dart';
import '../pages/setting_page.dart';

class SettingButton extends StatelessWidget {
  const SettingButton({
    Key? key,
    required this.user,
  }) : super(key: key);

  final UserModel? user;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.to<void>(() => SettingPage(
              user: user!,
            ));
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Settings',
            style: BryteTypography.bodyExtraBold.copyWith(
                color: Colors.white, fontWeight: FontWeight.w600, fontSize: 14),
          ),
          const SizedBox(width: 5),
          const Icon(
            Icons.settings,
            color: Colors.white,
            size: 20,
          ),
          const SizedBox(width: 10),
        ],
      ),
    );
  }
}