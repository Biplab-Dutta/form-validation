import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:login_form/core/value_failure.dart';

class Password extends Equatable {
  factory Password(String input) => Password._(_validatePassword(input));

  const Password._(this.value);

  final Either<ValueFailure, String> value;

  @override
  List<Object?> get props => [value];
}

Either<ValueFailure, String> _validatePassword(String input) {
  if (input.length >= 5) {
    return right(input);
  } else {
    return left(
      ValueFailure.shortPassword(failedValue: input),
    );
  }
}
