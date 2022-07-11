import 'package:bryte/components/utils/palette.dart';
import 'package:flutter/material.dart';

import '../../../components/utils/theme.dart';

class CourseCard extends StatelessWidget {
  const CourseCard({
    Key? key,
    required this.title,
    required this.name,
    required this.color,
    this.onTap,
    required this.shadowColor,
  }) : super(key: key);

  final String title;
  final String name;
  final Color color;
  final Function()? onTap;
  final Color shadowColor;

  @override
  Widget build(BuildContext context) {
    return Card(
      shadowColor: shadowColor,
      child: InkWell(
        borderRadius: BorderRadius.circular(6),
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
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        const SizedBox(width: 15),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () {},
                    child: const Icon(Icons.more_horiz),
                  )
                ],
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 12),
                child: Divider(
                  height: 0,
                  thickness: 2,
                  color: Palette.secondary,
                ),
              ),
              Row(
                children: [
                  Text(
                    name,
                    style: brytStylegrey,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
