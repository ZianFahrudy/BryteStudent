import 'package:flutter/material.dart';

import '../../../components/utils/constant.dart';

class EmptyCourseBryte extends StatelessWidget {
  const EmptyCourseBryte({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 100),
      child: Center(
        child: Image.asset(
          AssetConstant.emptyCourseAssignmentMan,
          width: 210,
        ),
      ),
    );
  }
}
