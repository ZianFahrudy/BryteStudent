import 'package:bryte/components/widgets/custom_toast.dart';
import 'package:bryte/core/blocs/auth/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../components/utils/theme.dart';
import '../../../components/widgets/text_field_widget.dart';
import '../../../core/di/injection.dart';
import '../../navigation/navigation.dart';
import '../local_widgets/login_button.dart';
import 'forgot_password.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);
  static const route = '/LoginPage';

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final authBloc = getIt<AuthBloc>();
  TextEditingController ctrlUsername = TextEditingController();
  TextEditingController ctrlPass = TextEditingController();
  late FToast fToast;

  @override
  void initState() {
    super.initState();
    fToast = FToast();
    fToast.init(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => authBloc,
      child: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthSubmited) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => const Navigation(),
              ),
              ModalRoute.withName('Dashboard'),
            );
          } else if (state is AuthError) {
            bryteToast(
                state.kode == 'invalidlogin'
                    ? 'You\'ve entered a wrong username or\n password!'
                    : state.msg!,
                context,
                'Please check and login again.',
                fToast);
          } else if (state is AuthRoleFailure) {
            bryteToast('You\'ve entered a wrong role', context,
                'Please check and login again.', fToast);
          } else if (state is AuthUserPasswordEmpty) {
            bryteToast('Username and password cannot be empty!', context,
                'Please check and login again.', fToast);
          }
        },
        child: Scaffold(
            body: Stack(
          children: [
            _buildLoginContent(context),
            LoginButton(
              ctrlUsername: ctrlUsername,
              ctrlPass: ctrlPass,
              bloc: authBloc,
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
        )),
      ),
    );
  }

  Column _buildLoginContent(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 28),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  const SizedBox(height: 140),
                  Container(
                    width: 89,
                    height: 35,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/logo3.png'),
                      ),
                    ),
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
                    onChanged: (text) {
                      setState(() {});
                    },
                  ),
                  const SizedBox(height: 32),
                  TextFieldWidget(
                    iconData: Icons.visibility,
                    labelText: 'Password',
                    textEditingController: ctrlPass,
                    inputType: TextInputType.emailAddress,
                    onChanged: (text) {
                      setState(() {});
                    },
                  ),
                  const SizedBox(height: 20),
                  GestureDetector(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ForgotPassword())),
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
      ],
    );
  }
}
