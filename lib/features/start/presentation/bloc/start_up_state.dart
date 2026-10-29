part of 'start_up_bloc.dart';

@freezed
class StartUpState with _$StartUpState {
  const factory StartUpState.initial() = _Initial;
  const factory StartUpState.logged() = _Logged;
  const factory StartUpState.unlogged() = _Unlogged;
}
