import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../core/constants/app_colors.dart';
import '../manager/auth_cubit.dart';

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
          child: Visibility(
            visible: context.watch<AuthCubit>().state is AuthLoading,
            replacement: ElevatedButton(
              onPressed: () async {
                await context.read<AuthCubit>().signInWithGoogle();
                // GoRouter.of(
                //   context,
                // ).pushReplacement(ConstantRoutes.verifyYourAccountViewRoute);
              },
              style: ElevatedButton.styleFrom(shape: CircleBorder()),

              child: Icon(FontAwesomeIcons.google),
            ),
            child: ElevatedButton(
              onPressed: null,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.whiteColor40,
                shape: CircleBorder(),
              ),
              child: Icon(FontAwesomeIcons.google),
            ),
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
