import 'package:flutter/material.dart';

import '../../../components/utils/constant.dart';

class EmptyAssignmentBryte extends StatelessWidget {
  const EmptyAssignmentBryte({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 100),
      child: Center(
        child: Image.asset(
          AssetConstant.emptyCourseAssignmentWomen,
          width: 210,
        ),
      ),
    );
  }
}
