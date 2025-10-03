import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_routes.dart';
import '../../../../core/di/service_locator.dart';
import '../../domain/usecases/send_email_verification_usecase.dart';
import '../manager/email_verification/email_verification_cubit.dart';
import '../widgets/email_verification/email_verification_bloc_listener.dart';

class EmailVerificationView extends StatelessWidget {
  const EmailVerificationView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          EmailVerificationCubit(
              verificationUsecase:
                  ServiceLocator.get<SendEmailVerificationUsecase>(),
            )
            ..verifyEmail()
            ..setTimerForAutoRedirect(context),
      child: Scaffold(
        appBar: AppBar(
          actions: [
            TextButton(
              onPressed: () {
                GoRouter.of(
                  context,
                ).pushReplacement(ConstantRoutes.profileView);
              },
              child: Icon(FontAwesomeIcons.xmark),
            ),
          ],
        ),
        body: SafeArea(child: EmailVerificationBlocListener()),
      ),
    );
  }
}
