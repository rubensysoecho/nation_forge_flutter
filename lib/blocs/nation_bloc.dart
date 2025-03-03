import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/nation.dart';
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
        emit(NationLoaded(nations));
      } catch (e) {
        emit(NationError(e.toString()));
      }
    });

    on<CreateNation>((event, emit) async {
      try {
        final newNation = await _repository.createNation(event.nation);
        if (state is NationLoaded) {
          final updatedList = List<Nation>.from((state as NationLoaded).nations)..add(newNation);
          emit(NationLoaded(updatedList));
        }
      } catch (e) {
        emit(NationError(e.toString()));
      }
    });
  }
}