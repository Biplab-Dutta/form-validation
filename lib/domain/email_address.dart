import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:login_form/core/value_failure.dart';

class EmailAddress extends Equatable {
  factory EmailAddress(String input) =>
      EmailAddress._(_validateEmailAddress(input));

  const EmailAddress._(this.value);

  final Either<ValueFailure, String> value;

  @override
  List<Object?> get props => [value];
}

Either<ValueFailure, String> _validateEmailAddress(String input) {
  const emailRegex =
      r"""^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+""";
  if (RegExp(emailRegex).hasMatch(input)) {
    return right(input);
  } else {
    return left(
      ValueFailure.invalidEmail(failedValue: input),
    );
  }
}
