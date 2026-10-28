import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'start_up_event.dart';
part 'start_up_state.dart';
part 'start_up_bloc.freezed.dart';

@singleton
class StartUpBloc extends Bloc<StartUpEvent, StartUpState> {
  StartUpBloc() : super(_Initial()) {
    on<_Started>(_onStarted);
    on<_Loaded>(_onLoaded);
  }

  Future<void> _onStarted(_Started event, Emitter<StartUpState> emit) async {
    // await Future.delayed(Duration(seconds: 4), () => emit(_Logged()));
    // emit(_Logged());
    emit(_Unlogged());
  }

  void _onLoaded(_Loaded event, Emitter<StartUpState> emit) {}
}
