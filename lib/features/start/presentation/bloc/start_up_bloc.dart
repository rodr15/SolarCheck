import 'package:bloc/bloc.dart';
import 'package:fpdart/fpdart.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:solar_check/core/user/domain/entities/user.entity.dart';
import 'package:solar_check/core/user/domain/usecases/get_user.usecase.dart';

part 'start_up_event.dart';
part 'start_up_state.dart';
part 'start_up_bloc.freezed.dart';

@singleton
class StartUpBloc extends Bloc<StartUpEvent, StartUpState> {
  GetUserUseCase _getUserUseCase;
  StartUpBloc(this._getUserUseCase) : super(_Initial()) {
    on<_Started>(_onStarted);
    on<_Loaded>(_onLoaded);
  }

  Future<void> _onStarted(_Started event, Emitter<StartUpState> emit) async {
    print('ON ESTARTED');
    Either<UserEntity, String> user = await _getUserUseCase.call();
    user.match((user) => emit(_Logged()), (error) => emit(_Unlogged()));
  }

  void _onLoaded(_Loaded event, Emitter<StartUpState> emit) {}
}
