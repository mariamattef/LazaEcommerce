import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laza_ecommerce/core/connection/network_info.dart';
import 'package:laza_ecommerce/core/databases/api/dio_consumer.dart';
import 'package:laza_ecommerce/core/utiles/http_overrides.dart';
import 'package:laza_ecommerce/features/auth/pesentation/views/welcome_screen.dart';
import 'package:laza_ecommerce/features/home/data/data_sources/category_remote_data_source.dart';
import 'package:laza_ecommerce/features/home/data/data_sources/product_remote_data_source.dart';
import 'package:laza_ecommerce/features/home/data/repositories/category_repository_impl.dart';
import 'package:laza_ecommerce/features/home/data/repositories/product_repository_impl.dart';
import 'package:laza_ecommerce/features/home/domain/repositories/category_repository.dart';
import 'package:laza_ecommerce/features/home/domain/repositories/product_repository.dart';
import 'package:laza_ecommerce/features/home/domain/usecases/get_categories_usecase.dart';
import 'package:laza_ecommerce/features/home/domain/usecases/product_usecase.dart';
import 'package:laza_ecommerce/features/home/presentation/cubits/category_cubit/category_cubit.dart';
import 'package:laza_ecommerce/features/home/presentation/cubits/product_cubit/product_cubit.dart';
import 'package:laza_ecommerce/features/main_nav_bar/main_nav_bar.dart';
import 'package:laza_ecommerce/l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  HttpOverrides.global = MyHttpOverrides();
  InternetService internetService = InternetServiceImpl();

  bool isConnected = await internetService.isConnected;

  if (isConnected) {
    print('Device is connected to the internet');
  } else {
    print('Device is not connected to the internet');
  }
  runApp(const LazaApp());
}

class LazaApp extends StatelessWidget {
  const LazaApp({super.key});

  @override
  Widget build(BuildContext context) {
    final dio = Dio();
    final internetService = InternetServiceImpl();
    final categoryRemoteDataSource =
        CategoryRemoteDataSourceImpl(DioConsumer(dio: dio));
    final categoryRepository = CategoryRepositoryImpl(
      internetService: internetService,
      categoryRemoteDataSource: categoryRemoteDataSource,
    );
    final productRemoteDataSource =
        ProductRemoteDataSourceImpl(DioConsumer(dio: dio));

    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<ProductRepository>(
          create: (context) => ProductRepositoryImpl(
            internetService: internetService,
            productRemoteDataSource: productRemoteDataSource,
          ),
        ),
        RepositoryProvider<ProductUsecase>(
          create: (context) =>
              ProductUsecase(context.read<ProductRepository>()),
        ),
        RepositoryProvider<CategoryRepository>(
          create: (context) => categoryRepository,
        ),
        RepositoryProvider<GetCategoriesUseCase>(
          create: (context) =>
              GetCategoriesUseCase(context.read<CategoryRepository>()),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) {
              return ProductCubit(context.read<ProductUsecase>())
                ..getProducts('1');
            },
          ),
          BlocProvider(
            create: (context) {
              return CategoryCubit(context.read<GetCategoriesUseCase>())
                ..fetchCategories();
            },
          ),
        ],
        child: ScreenUtilInit(
          designSize: const Size(375, 812),
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (_, child) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Laza',
              theme: ThemeData(
                scaffoldBackgroundColor: Colors.white,
                fontFamily: 'Inter',
                useMaterial3: true,
                colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
              ),
              localizationsDelegates: AppLocalizations.localizationsDelegates,
              supportedLocales: AppLocalizations.supportedLocales,
              home: child,
            );
          },
          child: const WelcomeScreen(),
        ),
      ),
    );
  }
}
