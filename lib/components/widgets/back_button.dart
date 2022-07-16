import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BackButtonAppBar extends StatelessWidget {
  const BackButtonAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.back<void>();
      },
      child: Row(
        children: const [
          Icon(
            Icons.chevron_left,
            color: Colors.white,
          ),
          Text('Back')
        ],
      ),
    );
  }
}
