import 'dart:async';

import 'package:bryte/core/auth/auth_bloc.dart';
import 'package:bryte/pages/auth/pages/signin.dart';
import 'package:bryte/utils/function.dart';
import 'package:bryte/widgets/validate_password.dart';
import 'package:flutter/material.dart';
import 'package:bryte/theme.dart';
import 'package:bryte/widgets/custom_toast.dart';
import 'package:bryte/widgets/text_field_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

class NewPassword extends StatefulWidget {
  final String? username;
  const NewPassword({required this.username, Key? key}) : super(key: key);

  static const route = '/NewPassword';

  @override
  _NewPasswordState createState() => _NewPasswordState();
}

class _NewPasswordState extends State<NewPassword> {
  TextEditingController ctrlConfirmPass = TextEditingController();
  TextEditingController ctrlPass = TextEditingController();
  bool islenghtMin = false;
  bool islowerCase = false;
  bool isUpperCase = false;
  bool isContainNumber = false;
  bool isContainSimbol = false;
  bool ismatchConfirm = false;
  bool isvalidate = false;
  int index = 0;
  late FToast fToast;
  @override
  void initState() {
    ctrlConfirmPass.addListener(() {
      //ismatch
      if (ctrlConfirmPass.text.isNotEmpty &&
          ctrlPass.text == ctrlConfirmPass.text) {
        setState(() {
          ismatchConfirm = true;
        });
      } else {
        setState(() {
          ismatchConfirm = false;
        });
      }

      //validate all
      if (islenghtMin &&
          islowerCase &&
          isUpperCase &&
          isContainNumber &&
          isContainSimbol &&
          ismatchConfirm) {
        setState(() {
          isvalidate = true;
        });
      } else {
        isvalidate = false;
      }
    });
    ctrlPass.addListener(() {
      //8 kareakter
      if (ctrlPass.text.length >= 8) {
        setState(() {
          islenghtMin = true;
        });
      } else {
        setState(() {
          islenghtMin = false;
        });
      }

      //lowercase
      if (ctrlPass.text.contains(RegExp(r'[a-z]'))) {
        setState(() {
          islowerCase = true;
        });
      } else {
        setState(() {
          islowerCase = false;
        });
      }

      //uppercase
      if (ctrlPass.text.contains(RegExp(r'[A-Z]'))) {
        setState(() {
          isUpperCase = true;
        });
      } else {
        setState(() {
          isUpperCase = false;
        });
      }

      //iscontainnamer
      if (ctrlPass.text.contains(RegExp(r'[0-9]'))) {
        setState(() {
          isContainNumber = true;
        });
      } else {
        setState(() {
          isContainNumber = false;
        });
      }
      //iscontainSymbol
      if (ctrlPass.text.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
        setState(() {
          isContainSimbol = true;
        });
      } else {
        setState(() {
          isContainSimbol = false;
        });
      }

      //ismatch
      if (ctrlConfirmPass.text.isNotEmpty &&
          ctrlPass.text == ctrlConfirmPass.text) {
        setState(() {
          ismatchConfirm = true;
        });
      } else {
        setState(() {
          ismatchConfirm = false;
        });
      }

      //validate all
      if (islenghtMin &&
          islowerCase &&
          isUpperCase &&
          isContainNumber &&
          isContainSimbol &&
          ismatchConfirm) {
        setState(() {
          isvalidate = true;
        });
      } else {
        isvalidate = false;
      }

      printWarning(ismatchConfirm);
    });
    super.initState();
    fToast = FToast();
    fToast.init(context);
  }

  @override
  void dispose() {
    ctrlConfirmPass.dispose();
    ctrlPass.dispose();
    super.dispose();
  }

  showCustomToast(msg) {
    fToast.showToast(
      child: customtoastToWeak(context, msg),
      positionedToastBuilder: (context, child) {
        return Positioned(
          child: child,
          top: 55.0,
          left: 26.0,
        );
      },
    );
  }

  showCustomToastNewPass(msg) {
    fToast.showToast(
      child: customtoastNewPass(context, msg),
      positionedToastBuilder: (context, child) {
        return Positioned(
          child: child,
          top: 55.0,
          left: 26.0,
        );
      },
    );
  }

  Widget btnDisable() {
    return TextButton(
      style: TextButton.styleFrom(
          backgroundColor: bryteDarkPurple,
          padding: const EdgeInsets.symmetric(vertical: 17),
          side: BorderSide(
              color: bryteDarkPurple, width: 1, style: BorderStyle.solid),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
      onPressed: () {},
      child: Text('Save', style: brytStylebtn.copyWith(color: Colors.white)),
    );
  }

  Widget btn() {
    return TextButton(
      style: TextButton.styleFrom(
          backgroundColor: index == 0 ? bryteFooterForm : bryteDarkPurple,
          padding: const EdgeInsets.symmetric(vertical: 17),
          side: BorderSide(
              color: bryteDarkPurple, width: 1, style: BorderStyle.solid),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
      onPressed: () {
        if (!isvalidate) {
          showCustomToast('Please Match the requested format');
        } else {
          AuthBloc bloc = BlocProvider.of<AuthBloc>(context, listen: false);
          bloc.add(ResetPassword(
              username: widget.username, password: ctrlPass.text));
        }
      },
      child: Text('Save',
          style: brytStylebtn.copyWith(
              color: index == 0 ? bryteDarkPurple : Colors.white)),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget footer() {
      return Container(
          height: 114,
          width: double.infinity,
          color: bryteFooterForm,
          padding: const EdgeInsets.all(30),
          child: BlocListener<AuthBloc, AuthState>(listener: (context, state) {
            if (state is AuthResetPasspError) {
              showCustomToast(state.msg);
            }
            if (state is AuthResetPassSubmited) {
              showCustomToastNewPass('');
              Timer(
                  const Duration(seconds: 3),
                  () => Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => const Signin()),
                      ModalRoute.withName('Signin')));
            }
          }, child: BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
            if (state is AuthWaiting) {
              return btnDisable();
            }
            if (state is AuthError) {
              return btn();
            }
            return btn();
          })));
    }

    return Scaffold(
        resizeToAvoidBottomInset: false,
        bottomSheet: footer(),
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 28),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  const SizedBox(height: 140),
                  Text(
                    'Create your new password!',
                    style: brytStylebtnBlack.copyWith(
                        fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 32),
                  TextFieldWidget(
                    iconData: Icons.visibility,
                    labelText: 'New Password',
                    textEditingController: ctrlPass,
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 33),
                    child: Column(
                      children: [
                        Text(
                          'Your password must contain:',
                          style: brytStylelight.copyWith(
                              fontSize: 12, fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            validatePassword(
                                '8 characters minimum', islenghtMin),
                            validatePassword('Number', isContainNumber)
                          ],
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            validatePassword('Lowercase', islowerCase),
                            validatePassword('Symbol', isContainSimbol)
                          ],
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            validatePassword('Uppercase', isUpperCase),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                  const Divider(),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFieldWidget(
                    iconData: Icons.visibility,
                    labelText: 'Re-type new password',
                    textEditingController: ctrlConfirmPass,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  ismatchConfirm
                      ? const Center(
                          child: Text(
                            'Yep. It’s a match!',
                            style: TextStyle(color: Color(0xff81CA80)),
                          ),
                        )
                      : const SizedBox()
                ],
              )),
        ));
  }
}
