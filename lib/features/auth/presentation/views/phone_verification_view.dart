import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/di/service_locator.dart';
import '../../domain/usecases/verify_phone_usecase.dart';
import '../../domain/usecases/verify_smscode_usecaase.dart';
import '../manager/verifying_with_phone/verifying_phone_cubit.dart';
import '../widgets/phone_verification/phone_verification_bloc_listener.dart';

class PhoneVerificationView extends StatelessWidget {
  const PhoneVerificationView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(),
      body: BlocProvider<PhoneVerificationCubit>(
        create: (context) => PhoneVerificationCubit(
          verifyPhoneUsecase: ServiceLocator.get<VerifyPhoneUsecase>(),
          smsCodeUsecase: ServiceLocator.get<SmsCodeUsecaase>(),
        ),
        child: PhoneVerificationBlocListener(),
      ),
    );
  }
}
