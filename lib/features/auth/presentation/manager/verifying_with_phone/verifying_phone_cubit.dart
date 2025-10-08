import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/di/di_imports.dart';
import '../../../../../core/services/firebase_service.dart';
import '../../../../../core/utils/logging/logger_helper.dart';
import '../../../domain/usecases/verify_phone_usecase.dart';
import '../../../domain/usecases/verify_smscode_usecaase.dart';
part 'verifying_phone_state.dart';

class PhoneVerificationCubit extends Cubit<PhoneAccountVerificationState> {
  final VerifyPhoneUsecase verifyPhoneUsecase;
  final SmsCodeUsecaase smsCodeUsecase;

  String? _verificationId;

  PhoneVerificationCubit({
    required this.verifyPhoneUsecase,
    required this.smsCodeUsecase,
  }) : super(InitState());

  void sendCode(String phoneNumber) async {
    emit(VerifyPhoneLoading());
    final result = await verifyPhoneUsecase(
      phoneNumber: phoneNumber,
      onCodeSent: (String verificationId, int? resendToken) {
        _verificationId = verificationId;
        final user = ServiceLocator.get<FirebaseAuthService>().currentUser;
        LoggerHelper.debug('User verified: $user ');
        LoggerHelper.debug(
          'User verified:  \t \n${user?.uid}\n${user?.email}\n${user?.displayName}\n${user?.phoneNumber ?? "No phone"}',
        );
        emit(VerifyPhoneCodeSent());
      },
    );

    result.fold(
      (failure) => emit(VerifyPhoneFailure(failure.message)),
      (_) => emit(VerifyPhoneSuccess()),
    );
  }

  Future<void> verifySmsCodeLink(String smsCode) async {
    if (_verificationId == null) {
      emit(SmsCodeFailure('No verification ID found.'));
      return;
    }
    emit(SmsCodeLoading());
    final result = await smsCodeUsecase.linkAccount(
      verificationId: _verificationId!,
      smsCode: smsCode,
    );
    result.fold((failure) => emit(SmsCodeFailure(failure.message)), (_) {
      emit(SmsCodeSuccess());
    });
  }

  Future<void> verifySmsCodeSign(String smsCode) async {
    if (_verificationId == null) {
      emit(SmsCodeFailure('No verification ID found.'));
      return;
    }
    emit(SmsCodeLoading());
    final result = await smsCodeUsecase.signIn(
      verificationId: _verificationId!,
      smsCode: smsCode,
    );
    result.fold((failure) => emit(SmsCodeFailure(failure.message)), (_) {
      emit(SmsCodeSuccess());
    });
  }
}
