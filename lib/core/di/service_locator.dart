import 'package:amira_store/core/constants/api_constants.dart';
import 'package:amira_store/core/services/dio_service.dart';
import 'package:amira_store/features/auth/domain/usecases/signin_google_usecase.dart';
import 'package:get_it/get_it.dart';
import '../../features/auth/data/data_sources/firebase_auth_datasource.dart';
import '../../features/auth/data/data_sources/firestore_datasource.dart';
import '../../features/auth/data/repos/auth_repository_impl.dart';
import '../../features/auth/domain/repos/auth_repo.dart';
import '../../features/auth/domain/usecases/send_email_verification_usecase.dart';
import '../../features/auth/domain/usecases/sign_in_usecase.dart';
import '../../features/auth/domain/usecases/sign_out_usecase.dart';
import '../../features/auth/domain/usecases/sign_up_usecase.dart';
import '../../features/auth/domain/usecases/signin_facebook_usecase.dart';
import '../../features/auth/domain/usecases/verify_phone_usecase.dart';
import '../../features/auth/domain/usecases/verify_smscode_usecaase.dart';
import '../../features/categories/data/datasource/category_remote_datasource.dart';
import '../../features/categories/data/repos/category_repo_impl.dart';
import '../../features/categories/domain/repos/category_repo.dart';
import '../../features/categories/domain/usecases/fetch_category.dart';
import '../services/api_service.dart';
import '../services/firebase_service.dart';
import '../services/firestore_service.dart';

class ServiceLocator {
  static final GetIt _sl = GetIt.instance;

  static Future<void> init() async {
    //! Core Services
    _sl.registerLazySingleton<FirebaseAuthService>(() => FirebaseAuthService());
    _sl.registerLazySingleton<FirestoreService>(() => FirestoreService());
    _sl.registerLazySingleton<ApiService>(
      () => DioService(baseUrl: ApiConstants.dummyJsonBaseUrl),
    );
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
