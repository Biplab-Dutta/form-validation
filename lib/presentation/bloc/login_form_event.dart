part of 'login_form_bloc.dart';

@freezed
class LoginFormEvent with _$LoginFormEvent {
  const factory LoginFormEvent.emailChanged(String emailString) = _EmailChanged;

  const factory LoginFormEvent.passwordChanged(String passwordString) =
      _PasswordChanged;

  const factory LoginFormEvent.obscurePasswordToggled() =
      _ObscurePasswordToggled;

  const factory LoginFormEvent.loginSubmitted() = _LoginSubmitted;
}
