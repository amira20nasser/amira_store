part of 'verifying_phone_cubit.dart';

sealed class AccountVerificationWithPhoneState {}

class InitState extends AccountVerificationWithPhoneState {}

class VerifyPhoneLoading extends AccountVerificationWithPhoneState {}

class VerifyPhoneCodeSent extends AccountVerificationWithPhoneState {}

class VerifyPhoneFailure extends AccountVerificationWithPhoneState {
  final String message;
  VerifyPhoneFailure(this.message);
}

class VerifyPhoneSuccess extends AccountVerificationWithPhoneState {}

class SmsCodeLoading extends AccountVerificationWithPhoneState {}

class SmsCodeSuccess extends AccountVerificationWithPhoneState {}

class SmsCodeFailure extends AccountVerificationWithPhoneState {
  final String message;
  SmsCodeFailure(this.message);
}
