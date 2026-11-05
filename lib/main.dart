import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_ce_flutter/hive_ce_flutter.dart';
import 'package:solar_check/core/config/di/hive_initializer.dart';
import 'package:solar_check/core/config/observer/bloc_observer.dart';
import 'package:solar_check/core/config/router/router.dart';
import 'package:solar_check/core/config/theme/theme.dart';
import 'package:solar_check/core/user/presentation/bloc/auth_bloc.dart';

import 'core/config/di/injection.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await HiveInitializer.init(sl);
  await configureDependencies();

  Bloc.observer = sl<AppBlocObserver>();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (_) => sl<AuthBloc>(),
        ),
      ],
      child: const MyAppView(),
    );
  }
}

class MyAppView extends StatelessWidget {
  const MyAppView({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<AuthBloc>().add(AuthEvent.validate());
    final router = createRouter();

    return MaterialApp.router(
      title: 'Clean Architecture App',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      routerConfig: router,
    );
  }
}
