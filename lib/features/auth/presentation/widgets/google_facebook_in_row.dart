import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_routes.dart';
import '../../../../core/widgets/custom_button_with_loader.dart';
import '../manager/auth/auth_cubit.dart';

class GoogleFacebookInRow extends StatelessWidget {
  const GoogleFacebookInRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Spacer(flex: 3),

        Expanded(
          flex: 2,
          child: CustomButtonWithLoader(
            isLoading: context.select<AuthCubit, bool>(
              (cubit) => cubit.state is AuthLoading,
            ),
            widget: Icon(FontAwesomeIcons.google),
            onPressed: () async {
              final router = GoRouter.of(context);
              await context.read<AuthCubit>().signInWithGoogle();
              router.pushReplacement(ConstantRoutes.profileView);
            },
          ),
        ),
        Spacer(flex: 3),
        // TODO: enable facebook sign in later
        // Visibility(
        //   visible: context.watch<AuthCubit>().state is AuthLoading,
        //   replacement: IconButton(
        //     onPressed: () async {
        //       await context.read<AuthCubit>().signInWithFacebook();
        //     },
        //     icon: Icon(FontAwesomeIcons.facebookF),
        //   ),
        //   child: IconButton(
        //     onPressed: null,
        //     style: IconButton.styleFrom(
        //       backgroundColor: AppColors.whiteColor40,
        //     ),
        //     icon: Icon(FontAwesomeIcons.facebookF),
        //   ),
        // ),
      ],
    );
  }
}
