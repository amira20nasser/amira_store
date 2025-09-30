import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../domain/usecases/verify_phone_usecase.dart';
import '../../../domain/usecases/verify_smscode_usecaase.dart';
part 'verifying_phone_state.dart';

class VerifyingWithPhoneCubit extends Cubit<VerifyingWithPhoneState> {
  final VerifyPhoneUsecase verifyPhoneUsecase;
  final VerifySmscodeUsecaase verifySmsCodeUsecase;

  String? _verificationId;

  VerifyingWithPhoneCubit({
    required this.verifyPhoneUsecase,
    required this.verifySmsCodeUsecase,
  }) : super(VerifyingWithPhoneInit());

  Future<void> verifyPhoneNumber(String phoneNumber) async {
    emit(VerifyingWithPhoneLoading());
    final result = await verifyPhoneUsecase(
      phoneNumber: phoneNumber,
      onVerificationCompleted: (PhoneAuthCredential credential) {
        emit(VerifyingWithPhoneSuccess());
      },
      onVerificationFailed: (FirebaseAuthException e) {
        emit(VerifyingWithPhoneFailure(e.message ?? 'Verification failed'));
      },
      onCodeSent: (String verificationId, int? resendToken) {
        _verificationId = verificationId;
        emit(VerifyingWithPhoneCodeSent());
      },
      onCodeAutoRetrievalTimeout: (String verificationId) {
        _verificationId = verificationId;
        emit(VerifyingWithPhoneTimeOut());
      },
    );

    result.fold((failure) => emit(VerifyingWithPhoneFailure(failure.message)), (
      _,
    ) {
      emit(VerifyingWithPhoneInit());
    });
  }

  Future<void> verifySmsCode(String smsCode) async {
    if (_verificationId == null) {
      emit(VerifyingWithPhoneFailure('No verification ID found.'));
      return;
    }
    emit(VerifyingWithPhoneLoading());
    final result = await verifySmsCodeUsecase(
      verificationId: _verificationId!,
      smsCode: smsCode,
    );
    result.fold(
      (failure) => emit(VerifyingWithPhoneFailure(failure.message)),
      (user) => emit(VerifyingWithPhoneSuccess()),
    );
  }
}
