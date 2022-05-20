import 'package:bryte/components/utils/theme.dart';
import 'package:flutter/material.dart';

class FilterCourses extends StatelessWidget {
  const FilterCourses({
    Key? key,
    required this.label,
    required this.color,
    required this.textColor,
    this.onTap,
  }) : super(key: key);

  final String label;
  final Color color;
  final Color textColor;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
        decoration: BoxDecoration(
            color: color, borderRadius: BorderRadius.circular(20)),
        child: Text(
          label,
          style: brytStylebtn.copyWith(
              color: textColor, fontWeight: FontWeight.w500, fontSize: 16),
        ),
      ),
    );
  }
}
