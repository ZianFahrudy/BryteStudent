import 'package:flutter/material.dart';
import 'package:bryte/components/utils/theme.dart';

Widget customtoast(BuildContext context, String msg) {
  return Container(
    height: 78,
    width: 319,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10.0),
      color: const Color(0xffFFF0F0),
    ),
    child: Row(
      // mainAxisSize: MainAxisSize.min,
      children: [
        Container(
            width: 55,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  bottomLeft: Radius.circular(10)),
              color: Color(0xffFFCECE),
            ),
            // color: const Color(0xffFFCECE),
            child: Center(
              child: Image.asset(
                'assets/error_icon.png',
                width: 20,
                height: 20,
              ),
            )),
        Container(
          width: MediaQuery.of(context).size.width - 55 - 16 - 52 - 16,
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  msg,
                  maxLines: 2,
                  // "You've entered a wrong username or\n password!",
                  style: brytStyleError.copyWith(fontWeight: FontWeight.w600),
                ),
              ),
              Text(
                "Please check and login again.",
                style: brytStyleError,
              ),
            ],
          ),
        )
      ],
    ),
  );
}

Widget customtoastForgot(BuildContext context, String msg) {
  return Container(
    height: 78,
    width: 300,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10.0),
      color: const Color(0xffFFF0F0),
    ),
    child: Row(
      // mainAxisSize: MainAxisSize.min,
      children: [
        Container(
            width: 55,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  bottomLeft: Radius.circular(10)),
              color: Color(0xffFFCECE),
            ),
            // color: const Color(0xffFFCECE),
            child: Center(
              child: Image.asset(
                'assets/error_icon.png',
                width: 20,
                height: 20,
              ),
            )),
        Container(
          width: MediaQuery.of(context).size.width - 115,
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  'You’ve entered a wrong username!',
                  style: brytStyleError.copyWith(fontWeight: FontWeight.w600),
                ),
              ),
              Text(
                "Please check and re-enter your\n username.",
                style: brytStyleError,
              ),
            ],
          ),
        )
      ],
    ),
  );
}

Widget customtoastOtp(BuildContext context, String msg) {
  return Container(
    height: 78,
    width: 300,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10.0),
      color: const Color(0xffFFF0F0),
    ),
    child: Row(
      // mainAxisSize: MainAxisSize.min,
      children: [
        Container(
            width: 55,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  bottomLeft: Radius.circular(10)),
              color: Color(0xffFFCECE),
            ),
            // color: const Color(0xffFFCECE),
            child: Center(
              child: Image.asset(
                'assets/error_icon.png',
                width: 20,
                height: 20,
              ),
            )),
        Container(
          width: MediaQuery.of(context).size.width - 115,
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  'You’ve entered the wrong OTP code!!',
                  style: brytStyleError.copyWith(fontWeight: FontWeight.w600),
                ),
              ),
              Text(
                "Please check the email and re-enter the\n correct OTP code..",
                style: brytStyleError,
              ),
            ],
          ),
        )
      ],
    ),
  );
}

Widget customtoastToWeak(BuildContext context, String msg) {
  return Container(
    height: 78,
    width: 300,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10.0),
      color: const Color(0xffFFF0F0),
    ),
    child: Row(
      // mainAxisSize: MainAxisSize.min,
      children: [
        Container(
            width: 55,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  bottomLeft: Radius.circular(10)),
              color: Color(0xffFFCECE),
            ),
            // color: const Color(0xffFFCECE),
            child: Center(
              child: Image.asset(
                'assets/error_icon.png',
                width: 20,
                height: 20,
              ),
            )),
        Container(
          width: MediaQuery.of(context).size.width - 115,
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  'Your new password is too weak!',
                  style: brytStyleError.copyWith(fontWeight: FontWeight.w600),
                ),
              ),
              Text(
                "Please follow the password strength\n guide.",
                style: brytStyleError,
              ),
            ],
          ),
        )
      ],
    ),
  );
}

Widget customtoastNewPass(BuildContext context, String msg) {
  return Container(
    height: 78,
    width: 300,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10.0),
      color: const Color(0xffF5EFFF),
    ),
    child: Row(
      // mainAxisSize: MainAxisSize.min,
      children: [
        Container(
            width: 55,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  bottomLeft: Radius.circular(10)),
              color: Color(0xffEADEFF),
            ),
            // color: const Color(0xffFFCECE),
            child: Center(
              child: Image.asset(
                'assets/error_icon2.png',
                width: 20,
                height: 20,
              ),
            )),
        Container(
          width: MediaQuery.of(context).size.width - 115,
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  "Your new password will also apply to\n your Moodle LMS account!",
                  style: brytStyleDarkPurlple.copyWith(
                      fontSize: 12, fontWeight: FontWeight.w600),
                ),
              ),
              Text("Thanks to integration, right?",
                  style: brytStyleDarkPurlple.copyWith(
                      color: bryteDarkPurple.withOpacity(0.8),
                      fontSize: 12,
                      fontWeight: FontWeight.w500)),
            ],
          ),
        )
      ],
    ),
  );
}

Widget customtoastUntitle(BuildContext context, String msg) {
  return Container(
    height: 78,
    width: 300,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10.0),
      color: const Color(0xffFFF0F0),
    ),
    child: Row(
      // mainAxisSize: MainAxisSize.min,
      children: [
        Container(
            width: 55,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  bottomLeft: Radius.circular(10)),
              color: Color(0xffFFCECE),
            ),
            // color: const Color(0xffFFCECE),
            child: Center(
              child: Image.asset(
                'assets/error_icon.png',
                width: 20,
                height: 20,
              ),
            )),
        Container(
          width: MediaQuery.of(context).size.width - 115,
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
          child: Text(
            msg,
            style: brytStyleError,
          ),
        )
      ],
    ),
  );
}

Widget infoPassChange(BuildContext context, String msg) {
  return Container(
    height: 78,
    width: 300,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10.0),
      color: const Color(0xffE7F9E7),
    ),
    child: Row(
      // mainAxisSize: MainAxisSize.min,
      children: [
        Container(
            width: 55,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  bottomLeft: Radius.circular(10)),
              color: Color(0xffCEF2CE),
            ),
            // color: const Color(0xffFFCECE),
            child: Center(
              child: Image.asset(
                'assets/success.png',
                width: 20,
                height: 20,
              ),
            )),
        Container(
          width: MediaQuery.of(context).size.width - 115,
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  "Your password has been changed!",
                  style: brytStyleDarkPurlple.copyWith(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xff4D794D)),
                ),
              ),
              Text("Please login again.",
                  style: brytStyleDarkPurlple.copyWith(
                    color: const Color(0xff4D794D).withOpacity(0.8),
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  )),
            ],
          ),
        )
      ],
    ),
  );
}

Widget infoResenOtp(BuildContext context, String msg) {
  return Container(
    height: 78,
    width: 300,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10.0),
      color: const Color(0xffE7F9E7),
    ),
    child: Row(
      // mainAxisSize: MainAxisSize.min,
      children: [
        Container(
            width: 55,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  bottomLeft: Radius.circular(10)),
              color: Color(0xffCEF2CE),
            ),
            // color: const Color(0xffFFCECE),
            child: Center(
              child: Image.asset(
                'assets/success.png',
                width: 20,
                height: 20,
              ),
            )),
        Container(
          width: MediaQuery.of(context).size.width - 115,
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
          child: Text(
            "OTP has been sent...",
            style: brytStyleDarkPurlple.copyWith(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: const Color(0xff4D794D)),
          ),
        ),
      ],
    ),
  );
}
