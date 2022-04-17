import 'package:bryte/theme.dart';
import 'package:flutter/material.dart';

class CardUpcoming extends StatelessWidget {
  const CardUpcoming(
      {Key? key,
      required this.color1,
      required this.color2,
      required this.textColor1,
      required this.textColor2,
      required this.assignName,
      required this.title,
      required this.session,
      required this.deadline,
      required this.instructions,
      required this.dropShadow,
      required this.assignAttempt})
      : super(key: key);

  final Color color1;
  final Color color2;
  final Color textColor1;
  final Color textColor2;
  final String assignName;
  final String title;
  final int session;
  final String deadline;
  final String instructions;
  final bool assignAttempt;
  final Color dropShadow;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: SizedBox(
        height: 208,
        child: Stack(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 10),
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      color: dropShadow,
                      offset: const Offset(0, 3),
                      spreadRadius: -3,
                      blurRadius: 10)
                ],
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(18),
              ),
            ),
            Container(
              margin:
                  const EdgeInsets.only(top: 14, left: 4, right: 4, bottom: 4),
              // padding: EdgeInsets.only(top: 10, left: 12, right: 12),
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: color1,
                // border: Border.all(color: Palette.purpleColor, width: 3),
              ),
              height: 198,
              child: Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(12, 12, 12, 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.school, color: color2),
                                const SizedBox(width: 5),
                                Text('ASSIGNMENT',
                                    style: brytStyleWhite.copyWith(
                                        color: color2,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400))
                              ],
                            ),
                            Text(
                              assignName,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: brytStyleWhite.copyWith(
                                  color: color2,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w800),
                            ),
                          ],
                        ),
                      ),
                      const Spacer(),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Title',
                                style: brytStyledarkGreen.copyWith(
                                    color: color2,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w400)),
                            Text(
                              title,
                              style: brytStyleWhite.copyWith(
                                  color: color2,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w800),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text('INSTRUCTIONS',
                                style: brytStyledarkGreen.copyWith(
                                    color: color2,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w400)),
                            Text(
                              instructions,
                              style: brytStyleWhite.copyWith(
                                  color: textColor1,
                                  fontSize: 10,
                                  overflow: TextOverflow.ellipsis,
                                  fontWeight: FontWeight.w600),
                            )
                          ],
                        ),
                      ),
                      const Spacer(),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        decoration: BoxDecoration(
                            color: color2,
                            borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(15),
                                bottomRight: Radius.circular(15))),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(deadline,
                                    style: brytStyleWhite.copyWith(
                                        fontSize: 11,
                                        fontWeight: FontWeight.w800)),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text('ASSIGNMENT #$session',
                                    style: brytStyleWhite.copyWith(
                                        fontSize: 11,
                                        fontWeight: FontWeight.w500))
                              ],
                            ),
                            TextButton(
                                onPressed: () {},
                                style: TextButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 18),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    backgroundColor: Colors.white),
                                child: Text(
                                  'View',
                                  style: TextStyle(fontSize: 10, color: color2),
                                ))
                          ],
                        ),
                      ),
                    ],
                  ),
                  if (!assignAttempt)
                    Align(
                        alignment: Alignment.topRight,
                        child: Container(
                          height: 25,
                          width: 95,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 4),
                          decoration: const BoxDecoration(
                              color: Color(0xffFF5858),
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(10),
                                  bottomLeft: Radius.circular(10))),
                          child: Center(
                            child: Text(
                              'NOT ATTEMPTED',
                              style: brytStyleWhite.copyWith(
                                  fontSize: 9, fontWeight: FontWeight.w600),
                            ),
                          ),
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
