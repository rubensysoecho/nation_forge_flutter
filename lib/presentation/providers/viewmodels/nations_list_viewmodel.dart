import '../blocs/nation/nation_bloc.dart';
import '../blocs/nation/nation_event.dart';
import '../blocs/nation/nation_state.dart';
import '../../../data/models/nation/nation.dart';

class NationsListViewModel {
  final NationBloc nationBloc;
  List<Nation> nationsList = [];

  NationsListViewModel({required this.nationBloc});

  void loadNations() {
    nationBloc.add(LoadNations());
  }

  void deleteNation(String nationId) {
    nationBloc.add(DeleteNation(nationId));
  }

  void updateNationsList(NationState state) {
    if (state is NationCreated) {
      nationsList.add(state.newNation);
    } else if (state is NationLoaded) {
      nationsList = state.nations;
    }
  }

  bool get isNationsListEmpty => nationsList.isEmpty;
}
