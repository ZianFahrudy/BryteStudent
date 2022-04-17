import 'package:bryte/pages/auth/pages/signin.dart';
import 'package:bryte/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final box = GetStorage();
    return Center(
      child: ElevatedButton(
          onPressed: () {
            box.remove(KeyConstant.token);
            box.remove(KeyConstant.role);
            Get.offAllNamed(Signin.route);
          },
          child: const Text('Logout')),
    );
  }
}
