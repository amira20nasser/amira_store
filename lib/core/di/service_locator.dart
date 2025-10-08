part of 'di_imports.dart';

class ServiceLocator {
  static final GetIt _sl = GetIt.instance;

  static Future<void> init() async {
    //! Core Services
    _sl.registerLazySingleton<FirebaseAuthService>(() => FirebaseAuthService());
    _sl.registerLazySingleton<FirestoreService>(() => FirestoreService());
    _sl.registerLazySingleton<ApiService>(() => DioService());
    //! Data Sources
    _sl.registerLazySingleton<FirebaseAuthDataSource>(
      () => FirebaseAuthDataSource(authService: _sl.get<FirebaseAuthService>()),
    );
    _sl.registerLazySingleton<FirestoreDataSource>(
      () => FirestoreDataSource(firestoreService: _sl.get<FirestoreService>()),
    );
    _sl.registerLazySingleton<CategoryRemoteDataSource>(
      () => CategoryRemoteDataSourceImpl(_sl.get<ApiService>()),
    );
    //! Repositories
    _sl.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(_sl<FirebaseAuthDataSource>()),
    );
    _sl.registerLazySingleton<CategoryRepository>(
      () => CategoryRepositoryImpl(_sl<CategoryRemoteDataSource>()),
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
      () => SendEmailVerificationUsecase(_sl.get<AuthRepository>()),
    );
    _sl.registerLazySingleton(() => SignOutUsecase(_sl.get<AuthRepository>()));
    _sl.registerLazySingleton(
      () => VerifyPhoneUsecase(_sl.get<AuthRepository>()),
    );
    _sl.registerLazySingleton(() => SmsCodeUsecaase(_sl.get<AuthRepository>()));
    _sl.registerLazySingleton(
      () => FetchCategoriesUseCase(_sl.get<CategoryRepository>()),
    );
  }

  static T get<T extends Object>() => _sl<T>();
}
