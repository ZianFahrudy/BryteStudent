import 'package:bryte/components/utils/constant.dart';
import 'package:bryte/components/utils/palette.dart';
import 'package:bryte/components/utils/typography.dart';
import 'package:flutter/material.dart';

class AsssignmentDialogSuccess extends StatelessWidget {
  const AsssignmentDialogSuccess({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 200,
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 50),
            child: Image.asset(AssetConstant.iconDownload),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
              color: Color(0xffFFEEFF),
            ),
          ),
          Container(
            height: 100,
            width: double.infinity,
            padding: const EdgeInsets.all(10),
            decoration: const BoxDecoration(
                color: Palette.darkPurple,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20))),
            child: Column(
              children: [
                Text(
                  'Your assignment has been submitted successfully!',
                  textAlign: TextAlign.center,
                  style: BryteTypography.headerExtraBold
                      .copyWith(color: Colors.white),
                ),
                Text(
                  'Take a break, you’ve earned it!\nYou received 2 XP!',
                  textAlign: TextAlign.center,
                  style:
                      BryteTypography.titleMedium.copyWith(color: Colors.white),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
