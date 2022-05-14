import 'package:freezed_annotation/freezed_annotation.dart';

part 'value_failure.freezed.dart';

@freezed
class ValueFailure with _$ValueFailure {
  const factory ValueFailure.invalidEmail({
    required String failedValue,
  }) = _InvalidEmail;

  const factory ValueFailure.shortPassword({
    required String failedValue,
  }) = _Password;
}
