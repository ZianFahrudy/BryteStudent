import 'package:bryte/pages/home/widgets/announcement.dart';
import 'package:bryte/pages/home/widgets/header_home.dart';
import 'package:bryte/pages/home/widgets/today_classes.dart';
import 'package:bryte/pages/home/widgets/upcoming_assignments.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool descTextShowFlag = false;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics:
          const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 22),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            HeaderHome(),
            TodayClasses(),
            UpcomingAssignments(),
            Announcements(),
            SizedBox(
              height: 100,
            )
          ],
        ),
      ),
    );
  }
}
