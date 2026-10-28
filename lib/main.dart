import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:solar_check/core/router/router.dart';
import 'package:solar_check/core/theme/theme.dart';
import 'package:solar_check/features/start/bloc/start_up_bloc.dart';
import 'core/di/injection.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // (Opcional) Inicializa Hive aquí si lo usas:
  // await Hive.initFlutter();
  // await Hive.openBox('settings_box');

  configureDependencies();

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
    final startupBloc = context.read<StartUpBloc>()
      ..add(StartUpEvent.started());
    final router = createRouter(startupBloc);

    return MaterialApp.router(
      title: 'Clean Architecture App',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      routerConfig: router,
    );
  }
}
