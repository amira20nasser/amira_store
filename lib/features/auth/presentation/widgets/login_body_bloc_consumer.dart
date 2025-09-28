import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_routes.dart';
import '../../../../core/widgets/custom_error_dialog.dart';
import '../manager/auth_cubit.dart';
import 'log_in_view_body.dart';

class LoginBodyBlocConsumber extends StatelessWidget {
  const LoginBodyBlocConsumber({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
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
      builder: (context, state) {
        return AbsorbPointer(
          absorbing: state is AuthLoading,
          child: LogInViewBody(),
        );
      },
    );
  }
}
