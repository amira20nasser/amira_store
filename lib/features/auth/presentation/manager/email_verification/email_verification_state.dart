part of 'email_verification_cubit.dart';

sealed class EmailVerificationState {}

class VerificationInit extends EmailVerificationState {}

class VerificationLoading extends EmailVerificationState {}

class VerificationSend extends EmailVerificationState {}

class VerificationDone extends EmailVerificationState {}

class NotVerified extends EmailVerificationState {}

class Verified extends EmailVerificationState {}

class VerificationFailed extends EmailVerificationState {
  String msg;
  VerificationFailed(this.msg);
}
