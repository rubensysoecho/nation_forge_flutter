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
        return emit(NationError("Loading Error: $e"));
      }
    });

    on<CreateNation>(
      (event, emit) async {
        emit(NationLoading());
        try {
          final newNation = await _repository.createNation(
              event.nationName,
              event.governmentType,
              event.age,
            );
            return emit(NationCreated(newNation));
        } catch (e) {
          return emit(NationError("Creating Error: $e"));
        }
      },
    );

    on<CreateNationAdvanced>(
      (event, emit) async {
        emit(NationLoading());
        try {
          final newNation = await _repository.createNationAdvanced(
            event.nationName,
            event.governmentType,
            event.age,
            event.leaderName ?? '',
            event.politicalStability ?? 0.0,
            event.economicSystem ?? '',
            event.currencyName ?? '',
            event.wealthDistribution ?? 0.0,
            event.lifeExpectancy ?? '',
            event.populationGrowth ?? 0.0,
            event.other ?? '',
          );
          return emit(NationCreated(newNation));
        } catch (e) {
          return emit(NationError("Creating Advanced Error: $e"));
        }
      },
    );

    on<DeleteNation>((event, emit) async {
      emit(NationLoading());
      try {
        final success = await _repository.deleteNation(event.nationId);
        if (success) {
          final nations = await _repository.getNations();
          return emit(NationLoaded(nations));
        } else {
          return emit(NationError("Delete operation failed"));
        }
      } catch (e) {
        return emit(NationError("Delete Error: $e"));
      }
    });
  }
}
