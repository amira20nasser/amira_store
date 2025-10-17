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
    _sl.registerLazySingleton<HomeRemoteDatasource>(
      () => HomeRemoteDataSourceImpl(_sl.get<ApiService>()),
    );
    _sl.registerLazySingleton<ProductsByCategoryRemoteDatasource>(
      () => ProductsByCategoryRemoteDataSourceImpl(
        apiService: _sl.get<ApiService>(),
      ),
    );
    _sl.registerLazySingleton<SearchProductsDatasource>(
      () => SearchProductsDatasource(_sl.get<ApiService>()),
    );
    _sl.registerLazySingleton<CartFirestoreDatasource>(
      () => CartFirestoreDatasource(_sl.get<FirestoreService>()),
    );
    _sl.registerLazySingleton<CartLocalDatasource>(() => CartLocalDatasource());
    //! Repositories
    _sl.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(_sl<FirebaseAuthDataSource>()),
    );
    _sl.registerLazySingleton<CategoryRepository>(
      () => CategoryRepositoryImpl(_sl<CategoryRemoteDataSource>()),
    );
    _sl.registerLazySingleton<HomeRepo>(
      () => HomeRepoImpl(_sl<HomeRemoteDatasource>()),
    );
    _sl.registerLazySingleton<ProductsByCategoryRepository>(
      () => ProductsByCategoryRepositoryImpl(
        remoteDataSource: _sl<ProductsByCategoryRemoteDatasource>(),
      ),
    );
    _sl.registerLazySingleton<SearchProductsRepo>(
      () => SearchProductsRepoImpl(
        remoteDataSource: _sl<SearchProductsDatasource>(),
      ),
    );
    _sl.registerLazySingleton<CartRepo>(
      () => CartRepoImpl(
        _sl<CartFirestoreDatasource>(),
        _sl<CartLocalDatasource>(),
      ),
    );
    _sl.registerLazySingleton<AllProductsRepo>(
      () => AllProductsRepoImpl(AllProductsDatasource(_sl.get<ApiService>())),
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
    _sl.registerLazySingleton(
      () => FetchSelectedCategoriesUsecase(_sl.get<HomeRepo>()),
    );
    _sl.registerLazySingleton(
      () => GetProductsByCategory(_sl.get<ProductsByCategoryRepository>()),
    );
    _sl.registerLazySingleton(
      () => SearchProductsUsecase(_sl.get<SearchProductsRepo>()),
    );
    _sl.registerLazySingleton<GetProductsUsecase>(
      () => GetProductsUsecase(_sl.get<AllProductsRepo>()),
    );
  }

  static T get<T extends Object>() => _sl<T>();
}
