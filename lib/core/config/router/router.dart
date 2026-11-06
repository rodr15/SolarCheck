import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:logger/logger.dart';
import 'package:solar_check/core/config/router/router_stream.dart';
import 'package:solar_check/core/user/presentation/bloc/auth_bloc.dart';
import 'package:solar_check/features/landing/presentation/screen/landing.screen.dart';
import 'package:solar_check/features/projects/screens/create_project.screen.dart';
import 'package:solar_check/features/projects/screens/inspection.screen.dart';
import 'package:solar_check/features/start/presentation/screen/loading.screen.dart';
import 'package:solar_check/features/register/presentation/screens/register.screen.dart';

final Logger _logger = GetIt.I<Logger>();

GoRouter createRouter() {
  final authBloc = GetIt.I<AuthBloc>();

  return GoRouter(
    initialLocation: '/',
    refreshListenable: GoRouterRefreshStream(authBloc.stream),
    redirect: (context, state) {
      final appState = authBloc.state;
      final currentPath = state.matchedLocation;

      final redirectPath = appState.when(
        loading: () {
          return currentPath != '/loading' ? '/loading' : null;
        },
        unauthenticated: () {
          return currentPath != '/login' ? '/login' : null;
        },
        authenticated: (_, __) {
          if (currentPath == '/login' || currentPath == '/loading') {
            return '/';
          }
          return null;
        },
      );

      if (redirectPath != null && redirectPath != currentPath) {
        _logger.i('🔀 Redirección GoRouter:\n'
            '   🔹 Estado Bloc: ${appState.runtimeType}\n'
            '   📍 Ruta Actual: $currentPath\n'
            '   ➡️ Nueva Ruta:  $redirectPath');
      }

      return redirectPath;
    },
    observers: [
      _GoRouterObserver(),
    ],
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const LandingScreen(),
      ),
      GoRoute(
        path: '/loading',
        builder: (context, state) => const LoadingScreen(),
      ),
      GoRoute(
        path: '/login',
        builder: (context, state) => const RegisterFormScreen(),
      ),
      GoRoute(
        name: 'CreateProject',
        path: '/createProject',
        builder: (context, state) => const CreateProject(),
      ),
      GoRoute(
        name: 'Inspection',
        path: '/inspection',
        builder: (context, state) => const Inspection(),
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
