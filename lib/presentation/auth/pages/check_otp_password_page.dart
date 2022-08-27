import 'dart:async';

import 'package:bryte/core/blocs/auth/auth_bloc.dart';
import 'package:bryte/core/di/injection.dart';
import 'package:bryte/presentation/auth/pages/forgot_password.dart';
import 'package:bryte/presentation/auth/pages/new_password.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/route_manager.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../components/utils/theme.dart';
import '../../../components/widgets/custom_toast.dart';

class CheckOtpPasswordPage extends StatefulWidget {
  const CheckOtpPasswordPage({
    Key? key,
    required this.email,
    required this.username,
  }) : super(key: key);

  final String email;
  final String username;

  @override
  State<CheckOtpPasswordPage> createState() => _CheckOtpPasswordPageState();
}

class _CheckOtpPasswordPageState extends State<CheckOtpPasswordPage> {
  TextEditingController textEditingController = TextEditingController();
  StreamController<ErrorAnimationType>? errorController;
  final authBloc = getIt<AuthBloc>();

  Timer? _timer;

  final startTime = ValueNotifier<int>(10);

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (startTime.value == 0) {
          timer.cancel();
          setState(() {});
        } else {
          startTime.value--;
          setState(() {});
        }
      },
    );
  }

  String _printDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "$twoDigitMinutes:$twoDigitSeconds";
  }

  bool isResendOtp = false;

  late FToast fToast;
  @override
  void initState() {
    startTimer();
    fToast = FToast();
    fToast.init(context);
    super.initState();
  }

  @override
  void dispose() {
    // textEditingController.dispose();
    authBloc.close();
    // errorController!.close();
    _timer!.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget btn() {
      return Column(
        children: [
          ValueListenableBuilder<int>(
            valueListenable: startTime,
            builder: (context, v, __) => v != 0
                ? SizedBox(
                    width: double.infinity,
                    child: TextButton(
                      style: TextButton.styleFrom(
                          backgroundColor: const Color(0xffEADEFF),
                          padding: const EdgeInsets.symmetric(vertical: 18),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12))),
                      onPressed: () {},
                      child: Text(
                          'Resend OTP (' +
                              _printDuration(Duration(seconds: v)) +
                              ')',
                          style: brytStylebtn.copyWith(
                              color: const Color(0xff6A46AA).withOpacity(0.5))),
                    ),
                  )
                : SizedBox(
                    width: double.infinity,
                    child: TextButton(
                        style: TextButton.styleFrom(
                            backgroundColor: bryteDarkPurple,
                            padding: const EdgeInsets.symmetric(vertical: 17),
                            side: BorderSide(
                                color: bryteDarkPurple,
                                width: 1,
                                style: BorderStyle.solid),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12))),
                        onPressed: () {
                          // AuthBloc bloc = BlocProvider.of<AuthBloc>(context, listen: false);
                          // bloc.add(ResenOtp(username: widget.username));
                          // showCustomToastInfo('');
                          authBloc.add(ResenOtp(username: widget.username));
                        },
                        child: Text(
                          'Resend OTP ',
                          style: brytStylebtn.copyWith(color: Colors.white),
                        )),
                  ),
          ),
          // _start != 0 ? btnDisable() : btnEnabled(),
          const SizedBox(
            height: 9,
          ),
          SizedBox(
            width: double.infinity,
            child: TextButton(
              style: TextButton.styleFrom(
                  backgroundColor: bryteFooterForm,
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  side: BorderSide(
                      color: bryteDarkPurple,
                      width: 1,
                      style: BorderStyle.solid),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12))),
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ForgotPassword()),
                    ModalRoute.withName('ForgotPassword'));
              },
              child: Text('Back',
                  style: brytStylebtn.copyWith(color: bryteDarkPurple)),
            ),
          ),
        ],
      );
    }

    showCustomToast(msg) {
      fToast.showToast(
        child: customtoastOtp(context, msg),
        positionedToastBuilder: (context, child) {
          return Positioned(
            child: child,
            top: 55.0,
            left: 26.0,
          );
        },
      );
    }

    void showCustomToastInfo(msg) {
      fToast.showToast(
        child: customtoast(context, msg),
        positionedToastBuilder: (context, child) {
          return Positioned(
            child: child,
            top: 55.0,
            left: 26.0,
          );
        },
      );
    }

    return BlocProvider(
      create: (context) => authBloc,
      child: Scaffold(
        body: BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthFverifyOtpSubmited) {
              Get.off(() => NewPassword(username: widget.username));
            } else if (state is AuthFverifyOtpError) {
              showCustomToast(state.msg!);
              textEditingController.clear();
            } else if (state is AuthResenOtpSubmited) {
              showCustomToastInfo('');
              setState(() {
                startTime.value = 10;
                startTimer();
              });
            }
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                const SizedBox(height: 130),
                Container(
                  width: 60,
                  height: 60,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/email_rec.png'),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  'Check your email for OTP!',
                  style: brytStylebtnBlack.copyWith(
                      fontSize: 20, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 20),
                Text(
                  'Please enter a 4-digit code that we’ve sent to:',
                  style: brytStylegrey,
                ),
                Text(
                  widget.email,
                  style: brytStylePurlple.copyWith(
                      fontSize: 14, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 32),
                Expanded(
                  child: PinCodeTextField(
                    appContext: context,
                    pastedTextStyle: TextStyle(
                      color: brytepurpleligth,
                      fontWeight: FontWeight.bold,
                    ),
                    length: 4,
                    obscureText: false,
                    obscuringCharacter: '*',
                    blinkWhenObscuring: true,
                    animationType: AnimationType.fade,
                    pinTheme: PinTheme(
                      selectedColor: brytepurple,
                      inactiveFillColor: brytepurpleligth,
                      disabledColor: brytepurpleligth,
                      selectedFillColor: brytepurpleligth,
                      inactiveColor: brytepurpleligth,
                      activeColor: brytepurpleligth,
                      shape: PinCodeFieldShape.box,
                      borderRadius: BorderRadius.circular(20),
                      fieldHeight: 70,
                      fieldWidth: 62,
                      activeFillColor: brytepurpleligth,
                    ),
                    cursorColor: Colors.black,
                    animationDuration: const Duration(milliseconds: 300),
                    enableActiveFill: true,
                    errorAnimationController: errorController,
                    controller: textEditingController,
                    keyboardType: TextInputType.number,
                    // boxShadows: [
                    //   BoxShadow(
                    //     offset: Offset(0, 1),
                    //     color: Colors.black12,
                    //     blurRadius: 10,
                    //   )
                    // ],
                    onCompleted: (v) {
                      // AuthBloc bloc = BlocProvider.of<AuthBloc>(context, listen: false);
                      // bloc.add(VerifyOtp(username: widget.username, otp: v));
                      authBloc
                          .add(VerifyOtp(username: widget.username, otp: v));
                      // if (currentText != '123') {
                      //   setState(() {
                      //     textEditingController.clear();
                      //   });
                      // }
                      // print("Completed");
                    },
                    // onTap: () {
                    //   print("Pressed");
                    // },
                    onChanged: (value) {
                      // print(value);
                      // setState(() {
                      //   currentText = value;
                      // });
                    },
                    beforeTextPaste: (text) {
                      // print("Allowing to paste $text");
                      //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                      //but you can show anything you want here, like your pop up saying wrong paste format or etc
                      return true;
                    },
                  ),
                ),
                btn()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
