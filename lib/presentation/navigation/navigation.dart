import 'package:bryte/components/utils/constant.dart';
import 'package:bryte/components/utils/palette.dart';
import 'package:bryte/core/di/injection.dart';
import 'package:bryte/core/repo/auth/auth_repository.dart';
import 'package:bryte/presentation/home/pages/home_page.dart';
import 'package:bryte/presentation/profile/pages/profile_page.dart';
import 'package:bryte/components/utils/theme.dart';
import 'package:flutter/material.dart';

import '../calendar/pages/calendar_page.dart';
import '../course/pages/course_page.dart';
import 'cubits/nav_course/nav_course_cubit.dart';

class Navigation extends StatefulWidget {
  const Navigation({Key? key}) : super(key: key);
  static const route = '/navigation';
  @override
  State<Navigation> createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  final _selectedIndex = ValueNotifier<int>(0);
  final navCourseCubit = getIt<NavCourseCubit>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _pages = <Widget>[
      HomePage(
        navCourseCubit: navCourseCubit,
        selectedIndex: _selectedIndex,
      ),
      CoursePage(
        navCourseCubit: navCourseCubit,
        selectedIndex: _selectedIndex,
      ),
      const CalenderPage(),
      const ProfilePage(),
    ];

    return SafeArea(
      child: Scaffold(
        extendBody: true,
        body: ValueListenableBuilder(
          valueListenable: _selectedIndex,
          builder: (context, _, __) => IndexedStack(
            index: _selectedIndex.value,
            children: _pages.map((page) => page).toList(),
          ),
        ),
        bottomNavigationBar: ValueListenableBuilder(
          valueListenable: _selectedIndex,
          builder: (context, _, __) => BottomNavigation(
            onTap: (int index) {
              _selectedIndex.value = index;
            },
            selectedIndex: _selectedIndex,
          ),
        ),
      ),
    );
  }
}

class BottomNavigation extends StatelessWidget {
  const BottomNavigation({Key? key, required this.selectedIndex, this.onTap})
      : super(key: key);
  final ValueNotifier<int> selectedIndex;
  final Function(int)? onTap;
  @override
  Widget build(BuildContext context) {
    final profileUrl = box.read(KeyConstant.profileImage);
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(40),
        ),
        boxShadow: [
          BoxShadow(
            color: Color(0xffDBDBDB),
            spreadRadius: 1,
            blurRadius: 1,
          )
        ],
      ),
      margin: const EdgeInsets.all(10),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(40)),
        child: BottomNavigationBar(
            elevation: 0,
            onTap: onTap,
            currentIndex: selectedIndex.value,
            type: BottomNavigationBarType.fixed,
            items: [
              BottomNavigationBarItem(
                  icon: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 6),
                        child: Icon(
                            selectedIndex.value == 0
                                ? Icons.home
                                : Icons.home_outlined,
                            size: 24,
                            color: selectedIndex.value == 0
                                ? brytepurple
                                : bryteGreyLight),
                      ),
                      Text(
                        'Home',
                        style: selectedIndex.value == 0
                            ? brytStylebtnActive
                            : brytStylebtnNonActive,
                      )
                    ],
                  ),
                  label: ''),
              BottomNavigationBarItem(
                  icon: Column(
                    children: [
                      Container(
                          margin: const EdgeInsets.only(top: 6),
                          child: Icon(
                              selectedIndex.value == 1
                                  ? Icons.school
                                  : Icons.school_outlined,
                              size: 24,
                              color: selectedIndex.value == 1
                                  ? brytepurple
                                  : bryteGreyLight)),
                      Text(
                        'Courses',
                        style: selectedIndex.value == 1
                            ? brytStylebtnActive
                            : brytStylebtnNonActive,
                      )
                    ],
                  ),
                  label: ''),
              BottomNavigationBarItem(
                  icon: Column(
                    children: [
                      Container(
                          margin: const EdgeInsets.only(top: 6),
                          child: Icon(
                              selectedIndex.value == 2
                                  ? Icons.date_range
                                  : Icons.event,
                              size: 24,
                              color: selectedIndex.value == 2
                                  ? brytepurple
                                  : bryteGreyLight)),
                      Text(
                        'Calendar',
                        style: selectedIndex.value == 2
                            ? brytStylebtnActive
                            : brytStylebtnNonActive,
                      )
                    ],
                  ),
                  label: ''),
              BottomNavigationBarItem(
                  icon: Column(
                    children: [
                      Container(
                          margin: const EdgeInsets.only(top: 6),
                          padding: const EdgeInsets.all(3),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: selectedIndex.value == 3
                                ? Palette.purple
                                : Palette.lightGrey,
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: Image.network(
                              profileUrl ??
                                  'https://cdn-icons-png.flaticon.com/512/3135/3135715.png',
                              width: 19,
                              fit: BoxFit.cover,
                            ),
                          )),
                      Text(
                        'Profile',
                        style: selectedIndex.value == 3
                            ? brytStylebtnActive
                            : brytStylebtnNonActive,
                      )
                    ],
                  ),
                  label: ''),
            ]),
      ),
    );
  }
}
