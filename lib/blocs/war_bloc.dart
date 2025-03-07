import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:nation_forge/models/war.dart';
import 'package:nation_forge/repos/war_repository.dart';

part 'war_event.dart';
part 'war_state.dart';

class WarBloc extends Bloc<WarEvent, WarState> {
  final WarRepository _repository = WarRepository();

  WarBloc() : super(WarInitial()) {
    on<LoadWars>((event, emit) async {
      emit(WarLoading());
      try {
        final wars = await _repository.getWars();
        return emit(WarLoaded(wars));
      } catch (e) {
        emit(WarError(e.toString()));
      }
    });
  }
}
