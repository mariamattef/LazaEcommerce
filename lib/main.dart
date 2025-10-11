import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laza_ecommerce/core/di/service_locator.dart';
import 'package:laza_ecommerce/core/utiles/http_overrides.dart';
import 'package:laza_ecommerce/features/auth/persentation/cubits/cubit/auth_cubit.dart';
import 'package:laza_ecommerce/features/auth/persentation/views/initial_screen.dart';
import 'package:laza_ecommerce/features/home/domain/usecases/get_categories_usecase.dart';
import 'package:laza_ecommerce/features/home/domain/usecases/product_usecase.dart';
import 'package:laza_ecommerce/features/home/presentation/cubits/category_cubit/category_cubit.dart';
import 'package:laza_ecommerce/features/home/presentation/cubits/product_cubit/product_cubit.dart';
import 'package:laza_ecommerce/features/review/presentation/cubits/cubit/reviews_cubit.dart';
import 'package:laza_ecommerce/l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();
  setupServiceLocator();
  runApp(const LazaApp());
}

class LazaApp extends StatelessWidget {
  const LazaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) {
            return ProductCubit(sl<ProductUsecase>())..getProducts('');
          },
        ),
        BlocProvider(
          create: (context) {
            return CategoryCubit(sl<GetCategoriesUseCase>())..fetchCategories();
          },
        ),
        BlocProvider(create: (context) => sl<AuthCubit>()),
        BlocProvider(create: (context) => sl<ReviewsCubit>()),
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
        child: const InitialScreen(),
      ),
    );
  }
}
