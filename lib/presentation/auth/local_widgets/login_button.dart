import 'package:flutter/material.dart';

import '../../../components/utils/theme.dart';
import '../../../core/blocs/auth/auth_bloc.dart';

class LoginButton extends StatelessWidget {
  const LoginButton({
    Key? key,
    required this.ctrlUsername,
    required this.ctrlPass,
    required this.bloc,
  }) : super(key: key);

  final TextEditingController ctrlUsername;
  final TextEditingController ctrlPass;
  final AuthBloc bloc;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 30,
          vertical: 20,
        ),
        child: SizedBox(
          width: double.infinity,
          child: TextButton(
            style: TextButton.styleFrom(
                backgroundColor:
                    ctrlUsername.text.isNotEmpty && ctrlPass.text.isNotEmpty
                        ? bryteDarkPurple
                        : bryteFooterForm,
                padding: const EdgeInsets.symmetric(vertical: 17),
                side: BorderSide(
                    color: bryteDarkPurple, width: 1, style: BorderStyle.solid),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12))),
            onPressed: () {
              // if (ctrlUsername.text == '' || ctrlPass.text == '') {
              //   showCustomToast(
              //       'Username and password cannot be empty!', context);
              // } else {
              bloc.add(
                  Login(email: ctrlUsername.text, password: ctrlPass.text));
              // }
            },
            child: Text(
              'Login',
              style: brytStylebtn.copyWith(
                color: ctrlUsername.text.isNotEmpty && ctrlPass.text.isNotEmpty
                    ? Colors.white
                    : bryteDarkPurple,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
