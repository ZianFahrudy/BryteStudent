import 'package:bryte/presentation/home/pages/home_page.dart';
import 'package:bryte/presentation/profile/pages/profile_page.dart';
import 'package:bryte/components/utils/theme.dart';
import 'package:flutter/material.dart';

class Navigation extends StatefulWidget {
  const Navigation({Key? key}) : super(key: key);
  static const route = '/navigation';
  @override
  State<Navigation> createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  final _selectedIndex = ValueNotifier<int>(0);

  final _pages = <Widget>[
    const HomePage(),
    // const CoursePage(),
    // const CalenderPage(),
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
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
                        child: Icon(Icons.home_outlined,
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
              // BottomNavigationBarItem(
              //     icon: Column(
              //       children: [
              //         Container(
              //             margin: const EdgeInsets.only(top: 6),
              //             child: Icon(Icons.school,
              //                 size: 24,
              //                 color: selectedIndex.value == 1
              //                     ? brytepurple
              //                     : bryteGreyLight)),
              //         Text(
              //           'Courses',
              //           style: selectedIndex.value == 1
              //               ? brytStylebtnActive
              //               : brytStylebtnNonActive,
              //         )
              //       ],
              //     ),
              //     label: ''),
              // BottomNavigationBarItem(
              //     icon: Column(
              //       children: [
              //         Container(
              //             margin: const EdgeInsets.only(top: 6),
              //             child: Icon(Icons.calendar_today_rounded,
              //                 size: 24,
              //                 color: selectedIndex.value == 2
              //                     ? brytepurple
              //                     : bryteGreyLight)),
              //         Text(
              //           'Calendar',
              //           style: selectedIndex.value == 2
              //               ? brytStylebtnActive
              //               : brytStylebtnNonActive,
              //         )
              //       ],
              //     ),
              //     label: ''),
              BottomNavigationBarItem(
                  icon: Column(
                    children: [
                      Container(
                          margin: const EdgeInsets.only(top: 6),
                          child: const Icon(Icons.person)),
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
