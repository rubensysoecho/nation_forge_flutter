import 'package:nation_forge/data/models/nation/nation_sketch.dart';

import '../blocs/nation/nation_bloc.dart';
import '../blocs/nation/nation_event.dart';
import '../blocs/nation/nation_state.dart';

class NationsSketchListViewmodel {
  final NationBloc nationBloc;
  List<NationSketch> nationsList = [];

  NationsSketchListViewmodel({required this.nationBloc});

  void loadNations() {
    nationBloc.add(LoadNationSketches());
  }

  void deleteNation(String nationId) {
    nationBloc.add(DeleteNation(nationId));
  }

  void updateNationsList(NationState state) {
    if (state is NationSketchesLoaded) {
      nationsList = state.nations;
    }
  }

  bool get isNationsListEmpty => nationsList.isEmpty;
}
