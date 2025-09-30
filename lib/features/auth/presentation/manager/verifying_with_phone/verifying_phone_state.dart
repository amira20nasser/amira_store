part of 'verifying_phone_cubit.dart';

sealed class VerifyingWithPhoneState {}

class VerifyingWithPhoneInit extends VerifyingWithPhoneState {}

class VerifyingWithPhoneLoading extends VerifyingWithPhoneState {}

class VerifyingWithPhoneCodeSent extends VerifyingWithPhoneState {}

class VerifyingWithPhoneSuccess extends VerifyingWithPhoneState {}

class VerifyingWithPhoneTimeOut extends VerifyingWithPhoneState {}

class VerifyingWithPhoneFailure extends VerifyingWithPhoneState {
  final String message;
  VerifyingWithPhoneFailure(this.message);
}
