import 'package:bloc/bloc.dart';
import 'package:fpdart/fpdart.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:solar_check/core/user/domain/entities/user.entity.dart';
import 'package:solar_check/core/user/domain/usecases/get_user.usecase.dart';

part 'auth_event.dart';
part 'auth_state.dart';
part 'auth_bloc.freezed.dart';

@singleton
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final GetUserUseCase _getUserUseCase;
  AuthBloc(this._getUserUseCase) : super(_Loading()) {
    on<_Validate>(_onValidate);
  }

  Future<void> _onValidate(AuthEvent event, Emitter<AuthState> emit) async {
    Either<UserEntity, String> user = await _getUserUseCase.call();

    user.match(
      (user) =>
          emit(AuthState.authenticated(name: user.name, email: user.email)),
      (error) => emit(AuthState.unauthenticated()),
    );
  }
}
