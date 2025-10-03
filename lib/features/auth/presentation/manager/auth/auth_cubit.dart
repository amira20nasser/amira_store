import 'package:amira_store/features/auth/domain/usecases/signin_facebook_usecase.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/user_entity.dart';
import '../../../domain/usecases/sign_in_usecase.dart';
import '../../../domain/usecases/sign_out_usecase.dart';
import '../../../domain/usecases/sign_up_usecase.dart';
import '../../../domain/usecases/signin_google_usecase.dart';
part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit({
    required this.signInUsecase,
    required this.signUpUsecase,
    required this.signInWithGoogleUsecase,
    required this.signInWithFacebookUsecase,
    required this.signOutUsecase,
  }) : super(AuthInitial());
  final SignInUsecase signInUsecase;
  final SignUpUsecase signUpUsecase;
  final SignInWithGoogleUsecase signInWithGoogleUsecase;
  final SignInWithFacebookUsecase signInWithFacebookUsecase;
  final SignOutUsecase signOutUsecase;

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
    result.fold((failure) => emit(AuthFailure(failure.message)), (user) async {
      await FirebaseAuth.instance.currentUser?.reload();

      emit(AuthSuccess(user));
    });
  }

  Future<void> signIn(String email, String password) async {
    emit(AuthLoading());
    final result = await signInUsecase.call(email, password);
    result.fold((failure) => emit(AuthFailure(failure.message)), (user) async {
      await FirebaseAuth.instance.currentUser?.reload();

      emit(AuthSuccess(user));
    });
  }

  Future<void> signUp({
    required String email,
    required String password,
    required String username,
  }) async {
    emit(AuthLoading());
    final result = await signUpUsecase(
      email: email,
      password: password,
      username: username,
    );
    result.fold((failure) => emit(AuthFailure(failure.message)), (user) async {
      await FirebaseAuth.instance.currentUser?.reload();

      emit(AuthSuccess(user));
    });
  }

  Future<void> signOut() async {
    final result = await signOutUsecase.call();
    result.fold(
      (failure) => emit(AuthFailure(failure.message)),
      (_) => emit(AuthInitial()),
    );
  }
}
