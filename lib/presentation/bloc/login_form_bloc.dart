import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:login_form/core/auth_failure.dart';
import 'package:login_form/domain/email_address.dart';
import 'package:login_form/domain/password.dart';

part 'login_form_bloc.freezed.dart';
part 'login_form_event.dart';
part 'login_form_state.dart';

class LoginFormBloc extends Bloc<LoginFormEvent, LoginFormState> {
  LoginFormBloc() : super(LoginFormState.initial()) {
    on<LoginFormEvent>(
      (event, emit) async {
        await event.when<FutureOr<void>>(
          emailChanged: (emailString) => _onEmailChanged(emit, emailString),
          passwordChanged: (passwordString) =>
              _onPasswordChanged(emit, passwordString),
          obscurePasswordToggled: () => _onObscurePasswordToggled(emit),
          loginSubmitted: () => _onLoginSubmitted(emit),
        );
      },
    );
  }

  void _onEmailChanged(Emitter<LoginFormState> emit, String emailString) {
    emit(
      state.copyWith(
        emailAddress: EmailAddress(emailString),
        authFailureOrSuccess: null,
      ),
    );
  }

  void _onPasswordChanged(Emitter<LoginFormState> emit, String passwordString) {
    emit(
      state.copyWith(
        password: Password(passwordString),
        authFailureOrSuccess: null,
      ),
    );
  }

  void _onObscurePasswordToggled(Emitter<LoginFormState> emit) {
    emit(state.copyWith(obscurePassword: !state.obscurePassword));
  }

  Future<void> _onLoginSubmitted(Emitter<LoginFormState> emit) async {
    final isEmailValid = state.emailAddress.value.isRight();
    final isPasswordValid = state.password.value.isRight();

    if (isEmailValid && isPasswordValid) {
      emit(
        state.copyWith(
          isSubmitting: true,
          authFailureOrSuccess: null,
        ),
      );

      // Perform network request to get a token.

      await Future.delayed(const Duration(seconds: 1));
    }
    emit(
      state.copyWith(
        isSubmitting: false,
        showErrorMessage: true,

        // Depending on the response received from the server after loggin in,
        // emit proper authFailureOrSuccess.

        // For now we will just see if the email and password were valid or not
        // and accordingly set authFailureOrSuccess' value.

        authFailureOrSuccess:
            (isEmailValid && isPasswordValid) ? right(unit) : null,
      ),
    );
  }
}
