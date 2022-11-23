import 'package:bloc/bloc.dart';
import 'package:bryte/components/utils/constant.dart';
import 'package:bryte/core/data/model/auth/auth_model.dart';
import 'package:bryte/core/data/model/auth/request/authorization_body.dart';
import 'package:bryte/core/repo/auth/auth_repository.dart';
import 'package:get_storage/get_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

@injectable
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthRepository apiRepository;
  final box = GetStorage();

  AuthBloc(this.apiRepository) : super(AuthInitial()) {
    on<Login>((event, emit) async {
      try {
        emit(AuthWaiting());
        final data = await apiRepository.login(event.email, event.password);
        if (data!.errorcode == null) {
          box.write(KeyConstant.token, data.token);

          if (box.hasData(KeyConstant.token)) {
            String token = box.read(KeyConstant.token);
            final role = await apiRepository.authorization(
              AuthorizationBody(token: token, username: event.email!),
            );
            if (role.status == 200) {
              box.write(KeyConstant.role, role.roleCode);
              box.write(KeyConstant.username, event.email);
              box.write(KeyConstant.userId, role.userid);
            }
          }

          if (box.read(KeyConstant.role) == 'ST') {
            emit(AuthSubmited(authModel: data));
          } else {
            box.remove(KeyConstant.token);
            emit(
              AuthRoleFailure(msg: 'Invalid login, please try again'),
            );
          }
        } else if (event.email!.isEmpty && event.password!.isEmpty) {
          emit(AuthUserPasswordEmpty());
        } else {
          emit(AuthError(data.error!, data.errorcode!));
        }
      } catch (e) {
        emit(AuthError(e.toString(), ''));
      }
    });
    on<SubmitedForgotPassword>(
      (event, emit) async {
        try {
          emit(AuthWaiting());
          final data = await apiRepository.forgotPassword(event.email);
          if (data!.status == 200) {
            emit(AuthForgotPasswordSubmited(forgotPasswordModel: data));
          } else if (data.status == 404) {
            emit(AuthForgotPasswordError('Username not found!', ''));
          }
        } catch (e) {
          emit(AuthForgotPasswordError(e.toString(), ''));
        }
      },
    );
    on<VerifyOtp>((event, emit) async {
      try {
        emit(AuthWaiting());
        final data = await apiRepository.verifyOtp(event.username, event.otp);

        if (data.status == 200) {
          emit(AuthFverifyOtpSubmited(otpdModel: data));
        } else {
          emit(AuthFverifyOtpError('Wrong OTP entered!', ''));
        }
      } catch (e) {
        emit(AuthFverifyOtpError(e.toString(), ''));
      }
    });
    on<ResetPassword>((event, emit) async {
      try {
        emit(AuthWaiting());
        final data =
            await apiRepository.resetPass(event.username, event.password);
        if (data.status == 200) {
          emit(AuthResetPassSubmited(otpdModel: data));
        } else {
          emit(AuthResetPasspError('Reset Password Error', ''));
        }
      } catch (e) {
        emit(AuthResetPasspError(e.toString(), ''));
      }
    });
    on<ResenOtp>((event, emit) async {
      try {
        emit(AuthWaiting());
        final data = await apiRepository.resentOTP(event.username);
        if (data.status == 200) {
          emit(AuthResenOtpSubmited(otpdModel: data));
        } else {
          emit(AuthResenOtpError('Resend OTP Error', ''));
        }
      } catch (e) {
        emit(AuthResenOtpError(e.toString(), ''));
      }
    });
  }
}
