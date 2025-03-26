import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nation_forge/models/nation.dart';
import '../repos/nation_repository.dart';
import 'nation_event.dart';
import 'nation_state.dart';

class NationBloc extends Bloc<NationEvent, NationState> {
  final NationRepository _repository = NationRepository();

  NationBloc() : super(NationInitial()) {
    on<LoadNations>((event, emit) async {
      emit(NationLoading());
      try {
        final nations = await _repository.getNations();
        return emit(NationLoaded(nations));
      } catch (e) {
        return emit(NationError("Loading Error: $e"));
      }
    });

    on<CreateNation>(
      (event, emit) async {
        emit(NationLoading());
        try {
          final newNation = await _repository.createNation(
              event.nationName, event.governmentType, event.age);
          return emit(NationCreated(newNation));
        } catch (e) {
          return emit(NationError("Creating Error: $e"));
        }
      },
    );
  }
}
