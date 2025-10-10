import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:laza_ecommerce/core/connection/network_info.dart';
import 'package:laza_ecommerce/core/databases/api/api_consumer.dart';
import 'package:laza_ecommerce/core/databases/api/dio_consumer.dart';
import 'package:laza_ecommerce/features/auth/data/data_source/auth_remote_data_source.dart';
import 'package:laza_ecommerce/features/auth/data/repos/user_repository_impl.dart';
import 'package:laza_ecommerce/features/auth/domain/repos/user_repository.dart';
import 'package:laza_ecommerce/features/auth/domain/usecases/auth_usecase.dart';
import 'package:laza_ecommerce/features/auth/persentation/cubits/cubit/auth_cubit.dart';
import 'package:laza_ecommerce/features/home/data/data_sources/category_remote_data_source.dart';
import 'package:laza_ecommerce/features/home/data/data_sources/product_remote_data_source.dart';
import 'package:laza_ecommerce/features/home/data/repositories/category_repository_impl.dart';
import 'package:laza_ecommerce/features/home/data/repositories/product_repository_impl.dart';
import 'package:laza_ecommerce/features/home/domain/repositories/category_repository.dart';
import 'package:laza_ecommerce/features/home/domain/repositories/product_repository.dart';
import 'package:laza_ecommerce/features/home/domain/usecases/get_categories_usecase.dart';
import 'package:laza_ecommerce/features/home/domain/usecases/product_usecase.dart';
import 'package:laza_ecommerce/features/home/presentation/cubits/product_cubit/product_cubit.dart';
import 'package:laza_ecommerce/features/home/presentation/cubits/category_cubit/category_cubit.dart';
import 'package:laza_ecommerce/features/review/data/data_source/review_remote_data_source.dart';
import 'package:laza_ecommerce/features/review/data/repos/review_repository_impl.dart';
import 'package:laza_ecommerce/features/review/domain/repos/review_repository.dart';
import 'package:laza_ecommerce/features/review/domain/use_cases/get_reviews_usecase.dart';
import 'package:laza_ecommerce/features/review/presentation/cubits/cubit/reviews_cubit.dart';

final sl = GetIt.instance;

void setupServiceLocator() {
  // Dio
  sl.registerLazySingleton(() => Dio());
  sl.registerLazySingleton<ApiConsumer>(() => DioConsumer(dio: sl()));

  // network info
  sl.registerLazySingleton(() => InternetConnectionChecker.createInstance());
  sl.registerLazySingleton<InternetService>(
    () => InternetServiceImpl(internetConnectionChecker: sl()),
  );

  // Auth Feature
  // Cubit

  sl.registerFactory(() => AuthCubit(authUsecase: sl()));

  // Use Cases

  sl.registerLazySingleton(() => AuthUsecase(userRepository: sl()));

  // Repository
  sl.registerLazySingleton<UserRepository>(
    () => UserRepositoryImpl(authRemoteDataSource: sl()),
  );

  // Data Sources

  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(dio: sl()),
  );

  // home feature
  // cubits
  sl.registerFactory(() => ProductCubit(sl()));
  sl.registerFactory(() => CategoryCubit(sl()));
  //usecases
  sl.registerLazySingleton(() => ProductUsecase(sl()));
  sl.registerLazySingleton(() => GetCategoriesUseCase(sl()));
  // repos
  sl.registerLazySingleton<ProductRepository>(
    () => ProductRepositoryImpl(
      internetService: sl(),
      productRemoteDataSource: sl(),
    ),
  );
  sl.registerLazySingleton<CategoryRepository>(
    () => CategoryRepositoryImpl(
      internetService: sl(),
      categoryRemoteDataSource: sl(),
    ),
  );
  // data sources
  sl.registerLazySingleton<ProductRemoteDataSource>(
    () => ProductRemoteDataSourceImpl(sl()),
  );
  sl.registerLazySingleton<CategoryRemoteDataSource>(
    () => CategoryRemoteDataSourceImpl(sl()),
  );

  // Review Feature
  // Cubit
  sl.registerFactory(() => ReviewsCubit(getReviewsUseCase: sl()));

  // Use Cases
  sl.registerLazySingleton(() => GetReviewsUseCase(sl()));

  // Repository
  sl.registerLazySingleton<ReviewRepository>(
    () => ReviewRepositoryImpl(remoteDataSource: sl()),
  );

  // Data Sources
  sl.registerLazySingleton<ReviewRemoteDataSource>(
    () => ReviewRemoteDataSourceImpl(dio: sl()),
  );
}