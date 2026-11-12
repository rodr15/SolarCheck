import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'inspection_event.dart';
part 'inspection_state.dart';
part 'inspection_bloc.freezed.dart';

class InspectionBloc extends Bloc<InspectionEvent, InspectionState> {
  InspectionBloc() : super(_Initial()) {
    on<InspectionEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
