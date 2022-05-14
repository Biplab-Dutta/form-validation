import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_form/presentation/bloc/login_form_bloc.dart';

class PasswordInput extends StatelessWidget {
  const PasswordInput({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginFormBloc, LoginFormState>(
      builder: (context, state) {
        return TextFormField(
          decoration: InputDecoration(
            prefixIcon: const Icon(Icons.lock),
            suffixIcon: IconButton(
              onPressed: () => context
                  .read<LoginFormBloc>()
                  .add(const LoginFormEvent.obscurePasswordToggled()),
              icon: state.obscurePassword
                  ? const Icon(Icons.visibility)
                  : const Icon(Icons.visibility_off),
            ),
            labelText: 'Password',
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(8),
              ),
            ),
          ),
          autocorrect: false,
          obscureText: state.obscurePassword,
          onChanged: (value) => context
              .read<LoginFormBloc>()
              .add(LoginFormEvent.passwordChanged(value)),
          validator: (_) => state.password.value.fold<String?>(
            (f) => f.maybeMap<String?>(
              shortPassword: (_) => 'Short Password',
              orElse: () => null,
            ),
            (_) => null,
          ),
          autovalidateMode: state.showErrorMessage == true
              ? AutovalidateMode.always
              : AutovalidateMode.disabled,
        );
      },
    );
  }
}
