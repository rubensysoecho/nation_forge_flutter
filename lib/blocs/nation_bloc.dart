import 'package:flutter_bloc/flutter_bloc.dart';
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
        emit(NationError(e.toString()));
      }
    });

    on<CreateNation>(
      (event, emit) async {
        try {
          emit(NationLoading());
          await _repository.createNation(
            event.nationName,
            event.governmentType,
            event.age,
          );
        } catch (e) {
          emit(NationError(e.toString()));
        }
      },
    );
  }
}
