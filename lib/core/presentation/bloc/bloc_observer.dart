import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';

@lazySingleton
class AppBlocObserver extends BlocObserver {
  final Logger _logger = Logger(
    printer: PrettyPrinter(
      methodCount: 0,
      errorMethodCount: 5,
      lineLength: 80,
      colors: true,
      printEmojis: true,
    ),
  );

  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);
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
    // Ideal para rastrear Cubits de forma simplificada
    if (bloc is! Bloc) {
      _logger.i('🔄 Cambio en Cubit ${bloc.runtimeType}\n'
          '   🔸 Actual: ${change.currentState}\n'
          '   🔹 Siguiente: ${change.nextState}');
    }
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    // Ideal para rastrear Blocs con sus eventos detonantes
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
