import 'dart:async';

import 'package:amira_store/core/constants/app_routes.dart';
import 'package:amira_store/core/di/service_locator.dart';
import 'package:amira_store/core/services/firebase_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart' show GoRouter;
import '../../../domain/usecases/send_email_verification_usecase.dart';

part 'email_verification_state.dart';

class EmailVerificationCubit extends Cubit<EmailVerificationState> {
  final SendEmailVerificationUsecase _verificationUsecase;
  EmailVerificationCubit({
    required SendEmailVerificationUsecase verificationUsecase,
  }) : _verificationUsecase = verificationUsecase,
       super(VerificationInit());

  void verifyEmail() async {
    emit(VerificationLoading());
    final res = await _verificationUsecase.call();
    emit(VerificationSend());
    res.fold(
      (failure) => emit(VerificationFailed(failure.message)),
      (_) => emit(VerificationDone()),
    );
  }

  void setTimerForAutoRedirect(context) {
    Timer.periodic(const Duration(seconds: 3), (timer) {
      FirebaseAuth.instance.currentUser?.reload();
      final user = FirebaseAuth.instance.currentUser;
      if (user!.emailVerified) {
        timer.cancel();
        GoRouter.of(context).pushReplacement(ConstantRoutes.successView);
      }
    });
  }

  Future<void> checkVerification() async {
    final user = ServiceLocator.get<FirebaseAuthService>().currentUser;
    await user?.reload();
    if (user != null) {
      if (user.emailVerified) {
        emit(Verified());
      } else {
        emit(NotVerified());
      }
    } else {
      emit(VerificationFailed("There isn't any user."));
    }
  }
}
