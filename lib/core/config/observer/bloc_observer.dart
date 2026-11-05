import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';

@singleton
class AppBlocObserver extends BlocObserver {
  final Logger _logger;

  AppBlocObserver(this._logger);

  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);
    print('Here is created');
    _logger.t('🟢 Creado: ${bloc.runtimeType}');
  }

  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    _logger.d('⚡ Evento en ${bloc.runtimeType} ➡️ $event');
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    if (bloc is! Bloc) {
      _logger.i('🔄 Cambio en Cubit ${bloc.runtimeType}\n'
          '   🔸 Actual: ${change.currentState}\n'
          '   🔹 Siguiente: ${change.nextState}');
    }
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    _logger.i('⏭️ Transición en ${bloc.runtimeType}\n'
        '   💥 Evento: ${transition.event}\n'
        '   🔸 Actual: ${transition.currentState}\n'
        '   🔹 Siguiente: ${transition.nextState}');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    _logger.e(
      '🔴 Error en ${bloc.runtimeType}',
      error: error,
      stackTrace: stackTrace,
    );
    super.onError(bloc, error, stackTrace);
  }

  @override
  void onClose(BlocBase bloc) {
    super.onClose(bloc);
    _logger.t('🗑️ Cerrado: ${bloc.runtimeType}');
  }
}
