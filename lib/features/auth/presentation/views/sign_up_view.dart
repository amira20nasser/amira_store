import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/di/service_locator.dart';
import '../../domain/usecases/sign_in_usecase.dart';
import '../../domain/usecases/sign_up_usecase.dart';
import '../../domain/usecases/signin_facebook_usecase.dart';
import '../../domain/usecases/signin_google_usecase.dart';
import '../manager/auth_cubit.dart';
import '../widgets/signup_body_bloc_consumer.dart';

class SignUpView extends StatelessWidget {
  const SignUpView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(
        signInUsecase: ServiceLocator.get<SignInUsecase>(),
        signUpUsecase: ServiceLocator.get<SignUpUsecase>(),
        signInWithGoogleUsecase: ServiceLocator.get<SignInWithGoogleUsecase>(),
        signInWithFacebookUsecase:
            ServiceLocator.get<SignInWithFacebookUsecase>(),
      ),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          behavior: HitTestBehavior.translucent,
          child: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSizes.defaultPadding,
                ),
                child: SignUpBodyBlocConsumber(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
