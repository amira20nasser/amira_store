import 'package:amira_store/core/utils/logging/logger_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_routes.dart';
import '../../../../core/widgets/custom_error_dialog.dart';
import '../../../../core/widgets/snack_bar.dart';
import '../manager/auth/auth_cubit.dart';
import 'log_in_view_body.dart';

class LoginBodyBlocConsumer extends StatelessWidget {
  const LoginBodyBlocConsumer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      buildWhen: (previous, current) =>
          current is AuthLoading || current is AuthFailure,
      listener: (context, state) {
        if (state is AuthSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBarTypes.successSnackBar(
              message: "Welcome ${state.user.email}",
            ),
          );
          LoggerHelper.debug("GO TO PROFILE ");
          GoRouter.of(context).pushReplacement(ConstantRoutes.profileView);
        } else if (state is AuthFailure) {
          showDialog(
            context: context,
            builder: (_) => CustomErrorDialog(
              title: "Login Failed",
              message: state.message,
            ),
          );
        }
      },
      builder: (context, state) => AbsorbPointer(
        absorbing: state is AuthLoading,
        child: LogInViewBody(),
      ),
    );
  }
}
