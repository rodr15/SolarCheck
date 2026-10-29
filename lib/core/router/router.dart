import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:logger/logger.dart';
import 'package:solar_check/core/router/router_stream.dart';
import 'package:solar_check/features/start/presentation/screen/loading.screen.dart';
import 'package:solar_check/features/register/presentation/screens/register.screen.dart';
import 'package:solar_check/features/start/presentation/bloc/start_up_bloc.dart';

final _logger = Logger(
  printer: PrettyPrinter(methodCount: 0, colors: true, printEmojis: true),
);

GoRouter createRouter(StartUpBloc appBloc) {
  return GoRouter(
    initialLocation: '/loading',
    refreshListenable: GoRouterRefreshStream(appBloc.stream),
    redirect: (context, state) {
      final appState = appBloc.state;

      final targetPath = appState.when(
        initial: () => '/loading',
        logged: () => '/',
        unlogged: () => '/login',
      );
      if (state.matchedLocation != targetPath) {
        _logger.i('🔀 Redirección GoRouter:\n'
            '   🔹 Estado Bloc: ${appState.runtimeType}\n'
            '   📍 Ruta Actual: ${state.matchedLocation}\n'
            '   ➡️ Nueva Ruta:  $targetPath');
      }

      return targetPath;
    },
    observers: [
      _GoRouterObserver(),
    ],
    routes: [
      GoRoute(
        path: '/loading',
        builder: (context, state) => const LoadingScreen(),
      ),
      GoRoute(
        path: '/login',
        builder: (context, state) => const RegisterFormScreen(),
      ),
    ],
  );
}

class _GoRouterObserver extends NavigatorObserver {
  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPush(route, previousRoute);
    _logger.d(
        '🗺️ GoRouter: Navegando a ➡️ ${route.settings.name ?? route.settings.arguments ?? route.toString()}');
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPop(route, previousRoute);
    _logger.d(
        '⬅️ GoRouter: Regresando desde ↩️ ${route.settings.name ?? route.toString()}');
  }

  @override
  void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didRemove(route, previousRoute);
    _logger.t('🗑️ GoRouter: Ruta eliminada ➡️ ${route.settings.name}');
  }
}
