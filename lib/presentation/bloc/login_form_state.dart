part of 'login_form_bloc.dart';

@freezed
class LoginFormState with _$LoginFormState {
  const factory LoginFormState({
    required EmailAddress emailAddress,
    required Password password,
    @Default(false) bool isSubmitting,
    @Default(false) bool showErrorMessage,
    @Default(true) bool obscurePassword,
    Either<AuthFailure, Unit>? authFailureOrSuccess,
    // Unit comes from Dartz package and is equivalent to void.
  }) = _LoginFormState;

  factory LoginFormState.initial() => LoginFormState(
        emailAddress: EmailAddress(''),
        password: Password(''),
      );
}
