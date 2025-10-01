import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_routes.dart';
import '../../../../core/widgets/custom_error_dialog.dart';
import '../manager/auth/auth_cubit.dart';
import 'log_in_view_body.dart';

class LoginBodyBlocListener extends StatelessWidget {
  const LoginBodyBlocListener({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Welcome ${state.user.email}")),
          );
          GoRouter.of(context).pushReplacement(ConstantRoutes.homeViewRoute);
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
      child: AbsorbPointer(
        absorbing: context.watch<AuthCubit>().state is AuthLoading,
        child: LogInViewBody(),
      ),
    );
  }
}
