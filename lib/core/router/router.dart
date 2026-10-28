import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:solar_check/core/router/router_stream.dart';
import 'package:solar_check/features/register/bloc/register_form_bloc.dart';
import 'package:solar_check/features/register/screen/loading.screen.dart';
import 'package:solar_check/features/register/screens/register.screen.dart';
import 'package:solar_check/features/start/bloc/start_up_bloc.dart';

GoRouter createRouter(StartUpBloc appBloc) {
  return GoRouter(
    initialLocation: '/',
    refreshListenable: GoRouterRefreshStream(appBloc.stream),
    redirect: (context, state) {
      final appState = appBloc.state;

      return appState.when(
        initial: () => '/loading',
        logged: () => '/',
        unlogged: () => '/login',
      );
    },
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
