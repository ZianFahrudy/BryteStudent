import 'package:flutter/material.dart';

import '../../../components/utils/palette.dart';

class SelectFileTypeLabel extends StatelessWidget {
  const SelectFileTypeLabel(
      {Key? key,
      required this.label,
      required this.icon,
      this.divider = true,
      this.onTap})
      : super(key: key);

  final String label;
  final IconData icon;
  final bool? divider;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: InkWell(
            onTap: onTap,
            child: Row(
              children: [
                Icon(
                  icon,
                  color: Palette.darkPurple,
                ),
                const SizedBox(
                  width: 15,
                ),
                Text(label)
              ],
            ),
          ),
        ),
        if (divider!)
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Divider(
              height: 0,
              thickness: 1,
              color: Palette.lightPB,
            ),
          ),
      ],
    );
  }
}
