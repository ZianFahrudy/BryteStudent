import 'package:bryte/core/auth/auth_bloc.dart';
import 'package:bryte/pages/auth/pages/forgot_password.dart';
import 'package:bryte/widgets/custom_toast.dart';
import 'package:flutter/material.dart';
import 'package:bryte/theme.dart';
import 'package:bryte/widgets/text_field_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../navigation.dart';

class Signin extends StatefulWidget {
  const Signin({Key? key}) : super(key: key);

  static const route = '/SignIn';

  @override
  _SigninState createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  TextEditingController ctrlUsername = TextEditingController();
  TextEditingController ctrlPass = TextEditingController();
  int index = 0;
  late FToast fToast;

  @override
  void initState() {
    super.initState();
    fToast = FToast();
    fToast.init(context);

    // if (widget.isresetPass!) {
    //   Timer(const Duration(seconds: 3), () => showCustomToastInfo(''));
    // }
  }

  @override
  void dispose() {
    ctrlUsername.dispose();
    ctrlPass.dispose();
    super.dispose();
  }

  showCustomToast(msg, context) {
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

  // showCustomToastInfo(msg) {
  //   fToast.showToast(
  //     child: infoPassChange(context, msg),
  //     // gravity: ToastGravity.TOP_RIGHT,
  //     positionedToastBuilder: (context, child) {
  //       return Positioned(
  //         child: child,
  //         top: 55.0,
  //         left: 26.0,
  //       );
  //     },
  //   );
  // }

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
      child: Text('Login', style: brytStylebtn.copyWith(color: Colors.white)),
    );
  }

  Widget btn(context) {
    return TextButton(
      style: TextButton.styleFrom(
          backgroundColor: index == 0 ? bryteFooterForm : bryteDarkPurple,
          padding: const EdgeInsets.symmetric(vertical: 17),
          side: BorderSide(
              color: bryteDarkPurple, width: 1, style: BorderStyle.solid),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
      onPressed: () {
        if (ctrlUsername.text == '' || ctrlPass.text == '') {
          showCustomToast('Username and password cannot be empty!', context);
        } else {
          AuthBloc bloc = BlocProvider.of<AuthBloc>(context, listen: false);
          bloc.add(Login(email: ctrlUsername.text, password: ctrlPass.text));
        }
      },
      child: Text('Login',
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
            if (state is AuthError) {
              setState(() {
                showCustomToast(
                    state.kode == 'invalidlogin'
                        ? 'You\'ve entered a wrong username or\n password!'
                        : state.msg,
                    context);
              });
            }
            if (state is AuthSubmited) {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const Navigation()),
                  ModalRoute.withName('Dashboard'));
            }
            if (state is AuthRoleFailure) {
              showCustomToast(state.msg, context);
            }
          }, child: BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
            if (state is AuthWaiting) {
              return btnDisable();
            }
            if (state is AuthError) {
              return btn(context);
            }
            return btn(context);
          })));
    }

    return Scaffold(
        resizeToAvoidBottomInset: false,
        bottomSheet: footer(),
        backgroundColor: Colors.white,
        body: Stack(
          fit: StackFit.expand,
          children: [
            SingleChildScrollView(
              child: SafeArea(
                child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 28),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        const SizedBox(height: 130),
                        Container(
                          width: 89,
                          height: 35,
                          decoration: const BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage('assets/logo3.png'))),
                        ),
                        const SizedBox(height: 36),
                        Text(
                          'Please login with your Moodle account.',
                          style: brytStyleJudul,
                        ),
                        const SizedBox(height: 32),
                        TextFieldWidget(
                          labelText: 'Username',
                          textEditingController: ctrlUsername,
                          inputType: TextInputType.emailAddress,
                        ),
                        const SizedBox(height: 32),
                        TextFieldWidget(
                          iconData: Icons.visibility,
                          labelText: 'Password',
                          textEditingController: ctrlPass,
                          inputType: TextInputType.emailAddress,
                        ),
                        const SizedBox(height: 20),
                        GestureDetector(
                          onTap: () {
                            // Navigator.pushAndRemoveUntil(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: (context) => const NewPassword()),
                            //     ModalRoute.withName('NewPassword'));

                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const ForgotPassword()));
                          },
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              'Forgot your password?',
                              style: brytStylelight.copyWith(
                                  decoration: TextDecoration.underline),
                              textAlign: TextAlign.end,
                            ),
                          ),
                        ),
                      ],
                    )),
              ),
            ),
            BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
              if (state is AuthWaiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return const SizedBox.shrink();
              }
            })
          ],
        ));
  }
}
