import 'package:bryte/theme.dart';
import 'package:flutter/material.dart';

Widget validatePassword(String text, bool istrue) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
        height: 12,
        width: 12,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(4)),
          color: istrue ? const Color(0xff81CA80) : const Color(0xffE7E7E7),
        ),
      ),
      const SizedBox(
        width: 8,
      ),
      Text(
        text,
        style: istrue
            ? const TextStyle(
                color: Color(0xff81CA80),
                fontSize: 12,
                fontWeight: FontWeight.w500)
            : brytStylelight.copyWith(
                fontSize: 12, fontWeight: FontWeight.w500),
      )
    ],
  );
}
