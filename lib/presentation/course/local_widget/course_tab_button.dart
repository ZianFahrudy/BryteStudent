import 'package:bryte/components/utils/typography.dart';
import 'package:flutter/material.dart';

class CourseTabButton extends StatelessWidget {
  const CourseTabButton({
    Key? key,
    required this.label,
    required this.color,
    this.onTap,
  }) : super(key: key);

  final String label;
  final Color color;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 25,
        margin: const EdgeInsets.only(right: 5),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Text(
          label,
          style: BryteTypography.titleSemiBold.copyWith(
            color: color,
          ),
        ),
      ),
    );
  }
}