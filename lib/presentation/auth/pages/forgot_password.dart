import 'package:bryte/core/blocs/auth/auth_bloc.dart';
import 'package:bryte/presentation/auth/pages/otp_password.dart';
import 'package:bryte/components/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

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

  late FToast fToast;
  @override
  void initState() {
    super.initState();
    fToast = FToast();
    fToast.init(context);
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

  @override
  Widget build(BuildContext context) {
    Widget btnDisable() {
      return TextButton(
        style: TextButton.styleFrom(
            backgroundColor: bryteDarkPurple,
            padding: const EdgeInsets.symmetric(vertical: 17),
            side: BorderSide(
                color: bryteDarkPurple, width: 1, style: BorderStyle.solid),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12))),
        onPressed: () {},
        child: Text('Next', style: brytStylebtn.copyWith(color: Colors.white)),
      );
    }

    Widget btn() {
      return TextButton(
        style: TextButton.styleFrom(
            backgroundColor: index == 0 ? bryteFooterForm : bryteDarkPurple,
            padding: const EdgeInsets.symmetric(vertical: 17),
            side: BorderSide(
                color: bryteDarkPurple, width: 1, style: BorderStyle.solid),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12))),
        onPressed: () {
          if (ctrlUsername.text == '') {
            showCustomToast('please enter a valid username');
          } else {
            AuthBloc bloc = BlocProvider.of<AuthBloc>(context, listen: false);
            bloc.add(SubmitedForgotPassword(email: ctrlUsername.text));
          }
        },
        child:
            Text('Next', style: brytStylebtn.copyWith(color: bryteDarkPurple)),
      );
    }

    Widget footer() {
      return Container(
          height: 114,
          width: double.infinity,
          color: bryteFooterForm,
          padding: const EdgeInsets.all(30),
          child: BlocListener<AuthBloc, AuthState>(listener: (context, state) {
            if (state is AuthForgotPasswordError) {
              showCustomToast(state.msg);
            }
            if (state is AuthForgotPasswordSubmited) {
              String? email = state.forgotPasswordModel!.email;
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (context) => OtpPassword(
                          email: email!, username: ctrlUsername.text)),
                  ModalRoute.withName('OtpPassword'));
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
                      labelText: 'Username',
                      textEditingController: ctrlUsername,
                      inputType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 32),
                  ],
                )),
          ),
        ));
  }
}
