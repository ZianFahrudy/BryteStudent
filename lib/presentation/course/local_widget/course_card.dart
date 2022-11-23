import 'package:bryte/components/utils/palette.dart';
import 'package:bryte/components/utils/typography.dart';
import 'package:flutter/material.dart';

import '../../../components/utils/theme.dart';
import '../pages/course_page.dart';

class CourseCard extends StatelessWidget {
  const CourseCard({
    Key? key,
    required this.title,
    required this.name,
    required this.color,
    this.onTap,
    required this.shadowColor,
    required this.selectedFilterValue,
  }) : super(key: key);

  final String title;
  final String name;
  final Color color;
  final Function()? onTap;
  final Color shadowColor;
  final ValueNotifier<FilterCourseType> selectedFilterValue;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
            color: shadowColor,
            offset: const Offset(0, 8),
            spreadRadius: -15,
            blurRadius: 10,
            blurStyle: BlurStyle.solid)
      ]),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: InkWell(
          borderRadius: BorderRadius.circular(15),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(13),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          Container(
                            width: 45,
                            height: 45,
                            decoration: BoxDecoration(
                              color: color,
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          const SizedBox(width: 15),
                          Flexible(
                            child: Text(
                              title,
                              maxLines: 2,
                              overflow: TextOverflow.clip,
                              style: brytStyleJudul.copyWith(
                                fontSize: 15,
                                color: Colors.black.withOpacity(0.6),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          const SizedBox(width: 15),
                        ],
                      ),
                    ),
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 12),
                  child: Divider(
                    height: 0,
                    thickness: 2,
                    color: Color(0xffEADEFF),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 250,
                      child: Text(
                        name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: brytStylegrey.copyWith(
                            fontSize: 12,
                            wordSpacing: 2,
                            letterSpacing: 1,
                            fontWeight: FontWeight.w600,
                            color: const Color(
                              0xff969696,
                            )),
                      ),
                    ),
                    selectedFilterValue.value == FilterCourseType.past
                        ? Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 3),
                            decoration: BoxDecoration(
                              color: const Color(
                                0xffE7E7E7,
                              ),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              'PAST',
                              style: BryteTypography.bodyRegular
                                  .copyWith(color: Palette.lightGrey),
                            ),
                          )
                        : const SizedBox()
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
