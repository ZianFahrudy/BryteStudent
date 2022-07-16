import 'dart:async';

import 'package:bryte/core/blocs/auth/auth_bloc.dart';
import 'package:bryte/presentation/auth/pages/forgot_password.dart';
import 'package:bryte/presentation/auth/pages/new_password.dart';
import 'package:bryte/components/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../components/widgets/custom_toast.dart';

class OtpPassword extends StatefulWidget {
  const OtpPassword({required this.email, required this.username, Key? key})
      : super(key: key);
  final String email;
  final String username;

  static const route = '/OtpPassword';
  @override
  State<OtpPassword> createState() => _OtpPasswordState();
}

class _OtpPasswordState extends State<OtpPassword> {
  int index = 0;
  TextEditingController textEditingController = TextEditingController();
  StreamController<ErrorAnimationType>? errorController;

  bool hasError = false;
  String currentText = "";
  final formKey = GlobalKey<FormState>();
  late FToast fToast;

  Timer? _timer;
  int _start = 120;

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        setState(() {
          if (_start != 0) {
            _start--;
          }
        });
      },
    );
  }

  String _printDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "$twoDigitMinutes:$twoDigitSeconds";
  }

  @override
  void initState() {
    startTimer();
    super.initState();
    fToast = FToast();
    fToast.init(context);
  }

  @override
  void dispose() {
    _timer!.cancel();
    super.dispose();
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

  showCustomToastInfo(msg) {
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

  @override
  Widget build(BuildContext context) {
    Widget btnEnabled() {
      return SizedBox(
        width: double.infinity,
        child: TextButton(
            style: TextButton.styleFrom(
                backgroundColor: bryteDarkPurple,
                padding: const EdgeInsets.symmetric(vertical: 17),
                side: BorderSide(
                    color: bryteDarkPurple, width: 1, style: BorderStyle.solid),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12))),
            onPressed: () {
              AuthBloc bloc = BlocProvider.of<AuthBloc>(context, listen: false);
              bloc.add(ResenOtp(username: widget.username));
              // showCustomToastInfo('');
            },
            child: Text(
              'Resend OTP ',
              style: brytStylebtn.copyWith(color: Colors.white),
            )),
      );
    }

    Widget btnDisable() {
      return SizedBox(
        width: double.infinity,
        child: TextButton(
          style: TextButton.styleFrom(
              backgroundColor: const Color(0xffEADEFF),
              padding: const EdgeInsets.symmetric(vertical: 18),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12))),
          onPressed: () {},
          child: Text(
              'Resend OTP (' + _printDuration(Duration(seconds: _start)) + ')',
              style: brytStylebtn.copyWith(
                  color: const Color(0xff6A46AA).withOpacity(0.5))),
        ),
      );
    }

    Widget btn() {
      return Column(
        children: [
          _start != 0 ? btnDisable() : btnEnabled(),
          const SizedBox(
            height: 9,
          ),
          SizedBox(
            width: double.infinity,
            child: TextButton(
              style: TextButton.styleFrom(
                  backgroundColor:
                      index == 0 ? bryteFooterForm : bryteDarkPurple,
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

    Widget footer() {
      return Container(
          height: 165,
          width: double.infinity,
          color: bryteFooterForm,
          padding: const EdgeInsets.all(20),
          child: btn());
    }

    Widget form() {
      return Form(
        key: formKey,
        child: PinCodeTextField(
          appContext: context,
          pastedTextStyle: TextStyle(
            color: brytepurpleligth,
            fontWeight: FontWeight.bold,
          ),
          length: 4,
          obscureText: false,
          obscuringCharacter: '*',
          // obscuringWidget: FlutterLogo(
          //   size: 24,
          // ),
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
            borderRadius: BorderRadius.circular(5),
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
            AuthBloc bloc = BlocProvider.of<AuthBloc>(context, listen: false);
            bloc.add(VerifyOtp(username: widget.username, otp: v));
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
      );
    }

    return Scaffold(
        resizeToAvoidBottomInset: false,
        bottomSheet: footer(),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: SafeArea(
            child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 18),
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
                              image: AssetImage('assets/email_rec.png'))),
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
                    SizedBox(
                      child: BlocListener<AuthBloc, AuthState>(
                        listener: (context, state) {
                          if (state is AuthFverifyOtpError) {
                            showCustomToast(state.msg!);
                            textEditingController.clear();
                          }
                          if (state is AuthFverifyOtpSubmited) {
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        NewPassword(username: widget.username)),
                                ModalRoute.withName('OtpPassword'));
                          }
                        },
                        child: BlocBuilder<AuthBloc, AuthState>(
                          builder: (context, state) {
                            return form();
                          },
                        ),
                      ),
                    ),
                    // form(),
                    const SizedBox(height: 32),
                    SizedBox(
                      child: BlocListener<AuthBloc, AuthState>(
                        listener: (context, state) {
                          if (state is AuthResenOtpError) {
                            showCustomToast(state.msg!);
                          }
                          if (state is AuthResenOtpSubmited) {
                            showCustomToastInfo('');
                            setState(() {
                              _start = 120;
                            });
                          }
                        },
                        child: BlocBuilder<AuthBloc, AuthState>(
                          builder: (context, state) {
                            return Container();
                          },
                        ),
                      ),
                    ),
                  ],
                )),
          ),
        ));
  }
}
