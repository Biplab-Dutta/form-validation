import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_form/presentation/bloc/login_form_bloc.dart';
import 'package:login_form/presentation/widgets/widgets.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginFormBloc, LoginFormState>(
      listener: (context, state) {
        final authFailureOrSuccess = state.authFailureOrSuccess;

        if (authFailureOrSuccess != null) {
          authFailureOrSuccess.fold(
            (failure) {
              // Do something to handle failure. For example, show a
              // snackbar saying "Invalid Email and Password Combination" or
              // "Server Error" depending on the failure.

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    failure.when<String>(
                      invalidEmailAndPasswordCombination: () =>
                          'Invaid email and password combination!',
                      serverError: () => 'Server Error!',
                    ),
                  ),
                ),
              );
            },
            (success) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Sign in successful...'),
                ),
              );
            },
          );
        }
      },
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Center(
          child: SingleChildScrollView(
            reverse: true,
            child: Form(
              child: Column(
                children: const [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 30),
                    child: EmailInput(),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: PasswordInput(),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  LoginButton(),
                  SizedBox(height: 15),
                  LoadingIndicator(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
