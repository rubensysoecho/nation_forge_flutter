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

  void deleteNation(NationSketch nation) {
    nationsList.removeWhere((n) => n.id == nation.id);
    nationBloc.add(DeleteNation(nation));
  }
  
  void updateNationsList(NationState state) {
    if (state is NationSketchesLoaded) {
      nationsList = state.nations;
    } else if (state is NationCreated) {
      NationSketch sketch = NationSketch(
        id: state.newNation.id,
        nationName: state.newNation.nationName,
      );
      nationsList.add(sketch);
    }
  }

  bool get isNationsListEmpty => nationsList.isEmpty;
}
