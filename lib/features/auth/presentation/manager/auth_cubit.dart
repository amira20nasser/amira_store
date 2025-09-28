import 'package:amira_store/features/auth/domain/usecases/signin_facebook_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/user_entity.dart';
import '../../domain/usecases/sign_in_usecase.dart';
import '../../domain/usecases/sign_up_usecase.dart';
import '../../domain/usecases/signin_google_usecase.dart';
part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit({
    required this.signInUsecase,
    required this.signUpUsecase,
    required this.signInWithGoogleUsecase,
    required this.signInWithFacebookUsecase,
  }) : super(AuthInitial());
  final SignInUsecase signInUsecase;
  final SignUpUsecase signUpUsecase;
  final SignInWithGoogleUsecase signInWithGoogleUsecase;
  final SignInWithFacebookUsecase signInWithFacebookUsecase;

  Future<void> signInWithGoogle() async {
    emit(AuthLoading());
    final result = await signInWithGoogleUsecase.call();
    result.fold(
      (failure) => emit(AuthFailure(failure.message)),
      (user) => emit(AuthSuccess(user)),
    );
  }

  Future<void> signInWithFacebook() async {
    emit(AuthLoading());
    final result = await signInWithFacebookUsecase.call();
    result.fold(
      (failure) => emit(AuthFailure(failure.message)),
      (user) => emit(AuthSuccess(user)),
    );
  }

  Future<void> signIn(String email, String password) async {
    emit(AuthLoading());
    final result = await signInUsecase.call(email, password);
    result.fold(
      (failure) => emit(AuthFailure(failure.message)),
      (user) => emit(AuthSuccess(user)),
    );
  }

  Future<void> signUp({
    required String email,
    required String password,
    required String username,
  }) async {
    emit(AuthLoading());
    final result = await signUpUsecase.call(
      email: email,
      password: password,
      username: username,
    );
    result.fold(
      (failure) => emit(AuthFailure(failure.message)),
      (user) => emit(AuthSuccess(user)),
    );
  }
}
