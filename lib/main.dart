import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_ce_flutter/hive_ce_flutter.dart';
import 'package:solar_check/core/di/hive_initializer.dart';
import 'package:solar_check/core/presentation/bloc/bloc_observer.dart';
import 'package:solar_check/core/router/router.dart';
import 'package:solar_check/core/theme/theme.dart';
import 'package:solar_check/features/start/presentation/bloc/start_up_bloc.dart';

import 'core/di/injection.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await HiveInitializer.init(sl);
  configureDependencies();

  Bloc.observer = sl<AppBlocObserver>();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<StartUpBloc>(
          create: (_) => sl<StartUpBloc>(),
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
    final startupBloc = sl<StartUpBloc>()..add(StartUpEvent.started());
    final router = createRouter(startupBloc);

    return MaterialApp.router(
      title: 'Clean Architecture App',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      routerConfig: router,
    );
  }
}
