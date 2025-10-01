part of 'verifying_phone_cubit.dart';

sealed class PhoneAccountVerificationState {}

class InitState extends PhoneAccountVerificationState {}

class VerifyPhoneLoading extends PhoneAccountVerificationState {}

class VerifyPhoneCodeSent extends PhoneAccountVerificationState {}

class VerifyPhoneFailure extends PhoneAccountVerificationState {
  final String message;
  VerifyPhoneFailure(this.message);
}

class VerifyPhoneSuccess extends PhoneAccountVerificationState {}

class SmsCodeLoading extends PhoneAccountVerificationState {}

class SmsCodeSuccess extends PhoneAccountVerificationState {}

class SmsCodeFailure extends PhoneAccountVerificationState {
  final String message;
  SmsCodeFailure(this.message);
}
