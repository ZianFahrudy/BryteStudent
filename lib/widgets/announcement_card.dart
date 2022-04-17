import 'package:bryte/theme.dart';
import 'package:flutter/material.dart';

class AnnouncementCard extends StatelessWidget {
  const AnnouncementCard({
    Key? key,
    required this.author,
    required this.role,
    required this.subject,
    required this.msg,
    required this.imageUrl,
    required this.date,
  }) : super(key: key);

  final String author;
  final String role;
  final String subject;
  final String msg;
  final String imageUrl;
  final String date;

  @override
  Widget build(BuildContext context) {
    final descTextShowFlag = ValueNotifier<bool>(false);
    return ValueListenableBuilder(
      valueListenable: descTextShowFlag,
      builder: (context, value, __) => Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 11),
              child: Row(
                children: [
                  SizedBox(
                    width: 35,
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(imageUrl),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(35),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 9,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        author,
                        style: brytStyleJudul.copyWith(
                            fontWeight: FontWeight.w600, fontSize: 14),
                      ),
                      Text(
                        role,
                        style: brytStylegrey.copyWith(
                            color: const Color(0xFF969696),
                            fontWeight: FontWeight.w500,
                            fontSize: 12),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Text(
                    date,
                    style: brytStylegrey.copyWith(
                        color: const Color(0xFF969696),
                        fontWeight: FontWeight.w500,
                        fontSize: 13),
                  )
                ],
              ),
            ),
            const Divider(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 11),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    subject,
                    style: brytStyleJudul.copyWith(
                        fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    msg,
                    maxLines: descTextShowFlag.value ? 8 : 5,
                    style: brytStyleJudul.copyWith(
                        fontSize: 14, fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(height: 10),
                  GestureDetector(
                      onTap: () {
                        descTextShowFlag.value = !descTextShowFlag.value;
                      },
                      child: Text(
                        !descTextShowFlag.value ? 'show more' : 'show less',
                        style: brytStyleJudul.copyWith(
                            fontSize: 13,
                            color: const Color(0xFFB742FF),
                            fontWeight: FontWeight.bold),
                      ))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
