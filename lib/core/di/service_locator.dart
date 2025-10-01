import 'package:amira_store/features/auth/domain/usecases/signin_google_usecase.dart';
import 'package:get_it/get_it.dart';
import '../../features/auth/data/data_sources/firebase_auth_datasource.dart';
import '../../features/auth/data/data_sources/firestore_datasource.dart';
import '../../features/auth/data/repos/auth_repository_impl.dart';
import '../../features/auth/domain/repos/auth_repo.dart';
import '../../features/auth/domain/usecases/sign_in_usecase.dart';
import '../../features/auth/domain/usecases/sign_up_usecase.dart';
import '../../features/auth/domain/usecases/signin_facebook_usecase.dart';
import '../../features/auth/domain/usecases/verify_phone_usecase.dart';
import '../../features/auth/domain/usecases/verify_smscode_usecaase.dart';
import '../services/firebase_service.dart';
import '../services/firestore_service.dart';

class ServiceLocator {
  static final GetIt _sl = GetIt.instance;

  static Future<void> init() async {
    //! Core Services
    _sl.registerLazySingleton<FirebaseAuthService>(() => FirebaseAuthService());
    _sl.registerLazySingleton<FirestoreService>(() => FirestoreService());

    //! Data Sources
    _sl.registerLazySingleton<FirebaseAuthDataSource>(
      () => FirebaseAuthDataSource(authService: _sl.get<FirebaseAuthService>()),
    );
    _sl.registerLazySingleton<FirestoreDataSource>(
      () => FirestoreDataSource(firestoreService: _sl.get<FirestoreService>()),
    );

    //! Repositories
    _sl.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(_sl<FirebaseAuthDataSource>()),
    );

    //! Use Cases
    _sl.registerLazySingleton(() => SignInUsecase(_sl.get<AuthRepository>()));
    _sl.registerLazySingleton(() => SignUpUsecase(_sl.get<AuthRepository>()));
    _sl.registerLazySingleton(
      () => SignInWithGoogleUsecase(_sl.get<AuthRepository>()),
    );
    _sl.registerLazySingleton(
      () => SignInWithFacebookUsecase(_sl.get<AuthRepository>()),
    );
    _sl.registerLazySingleton(
      () => VerifyPhoneUsecase(_sl.get<AuthRepository>()),
    );
    _sl.registerLazySingleton(() => SmsCodeUsecaase(_sl.get<AuthRepository>()));
  }

  static T get<T extends Object>() => _sl<T>();
}
