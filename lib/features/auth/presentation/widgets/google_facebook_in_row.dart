import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';
import '../manager/auth_cubit.dart';

class GoogleFacebookInRow extends StatelessWidget {
  const GoogleFacebookInRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Visibility(
          visible: context.watch<AuthCubit>().state is AuthLoading,
          replacement: IconButton(
            onPressed: () {
              context.read<AuthCubit>().signInWithGoogle();
            },
            icon: Icon(FontAwesomeIcons.google),
          ),
          child: IconButton(
            onPressed: null,
            style: IconButton.styleFrom(
              backgroundColor: AppColors.whiteColor40,
            ),
            icon: Icon(FontAwesomeIcons.google),
          ),
        ),
        SizedBox(width: AppSizes.defaultPadding),

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
