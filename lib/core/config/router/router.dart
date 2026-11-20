import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:logger/logger.dart';
import 'package:solar_check/core/config/router/router.constants.dart';
import 'package:solar_check/core/config/router/router_stream.dart';
import 'package:solar_check/core/user/presentation/bloc/auth_bloc.dart';
import 'package:solar_check/features/landing/presentation/screen/landing.screen.dart';
import 'package:solar_check/features/projects/presentation/screens/calification_screen.dart';
import 'package:solar_check/features/projects/presentation/screens/inspection_resume.screen.dart';
import 'package:solar_check/features/projects/presentation/screens/create_project.screen.dart';
import 'package:solar_check/features/start/presentation/screen/loading.screen.dart';
import 'package:solar_check/features/register/presentation/screens/register.screen.dart';

final Logger _logger = GetIt.I<Logger>();

GoRouter createRouter() {
  final authBloc = GetIt.I<AuthBloc>();

  return GoRouter(
    // initialLocation: '/catalog',
    initialLocation: RouterConstants.landing,
    refreshListenable: GoRouterRefreshStream(authBloc.stream),
    redirect: (context, state) {
      final appState = authBloc.state;
      final currentPath = state.matchedLocation;

      final redirectPath = appState.when(
        loading: () {
          return currentPath != RouterConstants.loading
              ? RouterConstants.loading
              : null;
        },
        unauthenticated: () {
          return currentPath != RouterConstants.login
              ? RouterConstants.login
              : null;
        },
        authenticated: (_, __) {
          if (currentPath == RouterConstants.login ||
              currentPath == RouterConstants.loading) {
            return RouterConstants.landing;
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
        name: RouterConstants.landing,
        path: RouterConstants.getPath(RouterConstants.landing),
        builder: (context, state) => const LandingScreen(),
      ),
      GoRoute(
        name: RouterConstants.loading,
        path: RouterConstants.getPath(RouterConstants.loading),
        builder: (context, state) => const LoadingScreen(),
      ),
      GoRoute(
        name: RouterConstants.login,
        path: RouterConstants.getPath(RouterConstants.login),
        builder: (context, state) => const RegisterFormScreen(),
      ),
      GoRoute(
        name: RouterConstants.createProject,
        path: RouterConstants.getPath(RouterConstants.createProject),
        builder: (context, state) => const CreateProject(),
      ),
      ShellRoute(routes: [
        GoRoute(
          name: RouterConstants.inspectionResume,
          path: RouterConstants.getPathWithPathParameters(
            RouterConstants.inspectionResume,
            ['projectId'],
          ),
          builder: (context, state) {
            final projectId = state.pathParameters['projectId']!;
            return InspectionResumeScreen(projectId: projectId);
          },
        ),
        GoRoute(
          name: RouterConstants.inspectionCalification,
          path: RouterConstants.getPath(RouterConstants.inspectionCalification),
          builder: (context, state) {
            return CalificationScreen();
          },
        ),
      ]),
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
