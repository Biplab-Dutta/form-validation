import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_form/presentation/bloc/login_form_bloc.dart';

class EmailInput extends StatelessWidget {
  const EmailInput({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginFormBloc, LoginFormState>(
      builder: (context, state) {
        return TextFormField(
          decoration: const InputDecoration(
            prefixIcon: Icon(Icons.email),
            labelText: 'Email',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(8),
              ),
            ),
          ),
          keyboardType: TextInputType.emailAddress,
          autocorrect: false,
          onChanged: (value) => context
              .read<LoginFormBloc>()
              .add(LoginFormEvent.emailChanged(value)),
          validator: (_) => state.emailAddress.value.fold<String?>(
            (f) => f.maybeMap<String?>(
              invalidEmail: (_) => 'Invalid Email',
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
