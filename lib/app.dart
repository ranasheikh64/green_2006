import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:green_2006/core/theme/app_theme.dart';

import 'package:green_2006/features/splash/splash_screen.dart';
import 'package:green_2006/features/try/data/repositories/try_repository_impl.dart';
import 'package:green_2006/features/try/presentation/bloc/try_on_bloc.dart';


class GreenApp extends StatelessWidget {
  const GreenApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<TryOnBloc>(
          create: (context) => TryOnBloc(repository: TryRepositoryImpl()),
        ),
      ],

      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MaterialApp(
            theme: AppTheme.light,
            darkTheme: AppTheme.dark,
            themeMode: ThemeMode.system,
            debugShowCheckedModeBanner: false,
            title: 'Green App',
            home: const SplashScreen(),
          );
        },
      ),
    );
  }
}

