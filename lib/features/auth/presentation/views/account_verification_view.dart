import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/di/service_locator.dart';
import '../../domain/usecases/verify_phone_usecase.dart';
import '../../domain/usecases/verify_smscode_usecaase.dart';
import '../manager/verifying_with_phone/verifying_phone_cubit.dart';
import '../widgets/account_verification/account_verification_bloc_consumer.dart';

class AccountVerificationView extends StatelessWidget {
  const AccountVerificationView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: BlocProvider<VerifyingWithPhoneCubit>(
        create: (context) => VerifyingWithPhoneCubit(
          verifyPhoneUsecase: ServiceLocator.get<VerifyPhoneUsecase>(),
          verifySmsCodeUsecase: ServiceLocator.get<VerifySmscodeUsecaase>(),
        ),
        child: AccountVerificationBlocConsumer(),
      ),
    );
  }
}
