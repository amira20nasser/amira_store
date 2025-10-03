import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/constants/app_routes.dart';
import '../../../../../core/constants/shared_pref_keys.dart';
import '../../../../../core/services/shared_preferences_service.dart';
import '../../../../../core/utils/logging/logger_helper.dart';
import '../../../../../core/widgets/snack_bar.dart';
import '../../manager/email_verification/email_verification_cubit.dart';
import 'email_verification_body.dart';

class EmailVerificationBlocListener extends StatelessWidget {
  const EmailVerificationBlocListener({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<EmailVerificationCubit, EmailVerificationState>(
      listener: (context, state) {
        if (state is VerificationSend) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBarTypes.warningSnackBar(
              message: "The email verification link is sent",
            ),
          );
        }
        if (state is VerificationFailed) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBarTypes.errorSnackBar(message: state.msg));
        }
        if (state is NotVerified) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBarTypes.errorSnackBar(
              message: "There is error please sign in again",
            ),
          );
          LoggerHelper.debug("message -> not verified ");
          GoRouter.of(context).pushReplacement(ConstantRoutes.profileView);
          LoggerHelper.debug("After go router");
        }
        if (state is Verified) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBarTypes.successSnackBar(message: "Verified Sucessfully"),
          );
          final prefs = SharedPreferencesService();
          prefs.setBool(SharedPrefKeys.sucessViewSeen, true);
          GoRouter.of(context).pushReplacement(
            ConstantRoutes.successView,
            extra: {
              "onPressed": () {
                context.pushReplacement(ConstantRoutes.profileView);
              },
            },
          );
        }
      },
      child: EmailVerificationBody(),
    );
  }
}
