import 'dart:developer';

import 'package:bryte/core/blocs/auth/auth_bloc.dart';
import 'package:bryte/components/utils/theme.dart';
import 'package:bryte/core/di/injection.dart';
import 'package:bryte/presentation/auth/pages/check_otp_password_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/route_manager.dart';

import '../../../components/widgets/custom_toast.dart';
import '../../../components/widgets/text_field_widget.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  static const route = '/ForgotPassword';

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  TextEditingController ctrlUsername = TextEditingController();
  TextEditingController ctrlPass = TextEditingController();
  int index = 0;

  final authBloc = getIt<AuthBloc>();

  late FToast fToast;
  @override
  void initState() {
    super.initState();
    fToast = FToast();
    fToast.init(context);
  }

  @override
  void dispose() {
    ctrlPass.dispose();
    ctrlUsername.dispose();
    authBloc.close();
    super.dispose();
  }

  showCustomToast(msg) {
    fToast.showToast(
      child: customtoast(context, msg),
      positionedToastBuilder: (context, child) {
        return Positioned(
          child: child,
          top: 55.0,
          left: 26.0,
          right: 26,
        );
      },
    );
  }

  bool textFieldNotEmpty = false;

  @override
  Widget build(BuildContext context) {
    Widget btn() {
      return Container(
        color: const Color(0xffFDF7FF),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: SizedBox(
            width: double.infinity,
            child: TextButton(
              style: TextButton.styleFrom(
                  backgroundColor:
                      textFieldNotEmpty ? bryteDarkPurple : bryteFooterForm,
                  padding: const EdgeInsets.symmetric(vertical: 17),
                  side: BorderSide(
                      color: bryteDarkPurple,
                      width: 1,
                      style: BorderStyle.solid),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12))),
              onPressed: () {
                if (ctrlUsername.text == '') {
                  showCustomToast('please enter a valid username');
                } else {
                  authBloc
                      .add(SubmitedForgotPassword(email: ctrlUsername.text));
                }
              },
              child: Text('Next',
                  style: brytStylebtn.copyWith(
                    color: textFieldNotEmpty ? Colors.white : bryteDarkPurple,
                  )),
            ),
          ),
        ),
      );
    }

    return BlocProvider(
      create: (context) => authBloc,
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.white,
        body: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthForgotPasswordSubmited) {
              log('forgot success');
              Get.off(() => CheckOtpPasswordPage(
                  email: state.forgotPasswordModel!.email!,
                  username: ctrlUsername.text));
            } else if (state is AuthForgotPasswordError) {
              bryteToast('You’ve entered a wrong username!', context,
                  'Please check and re-enter your username.', fToast);
            }
          },
          builder: (context, state) {
            return Stack(
              children: [
                Column(
                  children: [
                    Expanded(
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
                                      image:
                                          AssetImage('assets/email_rec.png'))),
                            ),
                            const SizedBox(height: 24),
                            Text(
                              'Forgot your password?',
                              style: brytStylebtnBlack.copyWith(
                                  fontSize: 20, fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(height: 20),
                            Text(
                              'No worries! Please enter your username below.',
                              style: brytStylegrey,
                            ),
                            const SizedBox(height: 32),
                            TextFieldWidget(
                              onChanged: (text) {
                                if (text.isNotEmpty) {
                                  setState(() {
                                    textFieldNotEmpty = true;
                                  });
                                } else {
                                  setState(() {
                                    textFieldNotEmpty = false;
                                  });
                                }
                              },
                              labelText: 'Username',
                              textEditingController: ctrlUsername,
                              inputType: TextInputType.emailAddress,
                            ),
                            // Spacer(),
                          ],
                        ),
                      ),
                    ),
                    btn(),
                  ],
                ),
                BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
                  if (state is AuthWaiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    return const SizedBox();
                  }
                })
              ],
            );
          },
        ),
      ),
    );
  }
}
