import 'package:flutter/material.dart';
import 'package:flutter_html/shims/dart_ui_real.dart';

PreferredSize appbar(BuildContext context) {
  return PreferredSize(
    preferredSize: const Size(double.infinity, 56),
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 0),
      color: Colors.transparent,
      child: ClipRRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width - 40,
                child: Center(
                  child: Image.asset(
                    'assets/logo4.png',
                    width: 59,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              // Stack(
              //   children: [
              //     GestureDetector(
              //       onTap: () {},
              //       child: Icon(
              //         Icons.notifications,
              //         color: bryteDarkPurple,
              //         size: 24,
              //       ),
              //     ),
              //     const Positioned(
              //       top: 1,
              //       right: -1,
              //       child: CircleAvatar(
              //         maxRadius: 7,
              //         backgroundColor: Colors.red,
              //         child: Text(
              //           '2',
              //           style: TextStyle(color: Colors.white, fontSize: 10),
              //         ),
              //       ),
              //     )
              //   ],
              // ),
            ],
          ),
        ),
      ),
    ),
  );
}
