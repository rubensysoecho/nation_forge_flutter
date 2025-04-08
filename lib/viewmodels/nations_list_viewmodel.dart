import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/nation_bloc.dart';
import '../blocs/nation_event.dart';
import '../blocs/nation_state.dart';
import '../models/nation/nation.dart';

class NationsListViewModel {
  final NationBloc nationBloc;
  List<Nation> nationsList = [];

  NationsListViewModel({required this.nationBloc});

  // Cargar las naciones
  void loadNations() {
    nationBloc.add(LoadNations());
  }

  // Eliminar una nación
  void deleteNation(String nationId) {
    nationBloc.add(DeleteNation(nationId));
  }

  // Actualizar la lista de naciones cuando cambia el estado
  void updateNationsList(NationState state) {
    if (state is NationCreated) {
      nationsList.add(state.newNation);
    } else if (state is NationLoaded) {
      nationsList = state.nations;
    }
  }

  bool get isNationsListEmpty => nationsList.isEmpty;
}
