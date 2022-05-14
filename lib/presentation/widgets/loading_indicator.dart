import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_form/presentation/bloc/login_form_bloc.dart';

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    final isSubmitting = context.select(
      (LoginFormBloc bloc) => bloc.state.isSubmitting,
    );
    if (isSubmitting) {
      return const CircularProgressIndicator();
    } else {
      return const SizedBox();
    }
  }
}
