import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:nation_forge/blocs/nation_bloc.dart';
import 'package:nation_forge/blocs/nation_event.dart';
import 'package:nation_forge/blocs/nation_state.dart';
import 'package:nation_forge/repos/nation_repository.dart';

@GenerateMocks([NationRepository])
import 'nation_bloc_test.mocks.dart';

void main() {
  late MockNationRepository mockRepository;
  late NationBloc nationBloc;

  setUp(() {
    mockRepository = MockNationRepository();
    nationBloc = NationBloc();
  });

  tearDown(() {
    nationBloc.close();
  });

  test('El estado inicial del NationBloc debe ser NationInitial', () {
    expect(nationBloc.state, isA<NationInitial>());
  });

  group('LoadNations Event', () {
    blocTest<NationBloc, NationState>(
      'Emite [NationLoading, NationLoaded] cuando LoadNations es exitoso',
      build: () {
        // El código real utiliza un repositorio interno (_repository),
        // por lo que este es un test de integración, no una prueba unitaria pura
        return nationBloc;
      },
      act: (bloc) => bloc.add(LoadNations()),
      expect: () => [
        isA<NationLoading>(),
        isA<NationLoaded>(),
      ],
    );
  });

  group('CreateNation Event', () {
    final String testName = "Nación de Prueba";
    final String testGovernment = "Democracia";
    final String testEra = "2000 d.C";

    blocTest<NationBloc, NationState>(
      'Emite [NationLoading, NationCreated] cuando CreateNation es exitoso',
      build: () => nationBloc,
      act: (bloc) => bloc.add(CreateNation(testName, testGovernment, testEra)),
      expect: () => [
        isA<NationLoading>(),
        isA<NationCreated>(),
      ],
    );
  });

  group('DeleteNation Event', () {
    final String testId = "test_id_123";

    blocTest<NationBloc, NationState>(
      'Emite [NationLoading, NationLoaded] cuando DeleteNation es exitoso',
      build: () => nationBloc,
      act: (bloc) => bloc.add(DeleteNation(testId)),
      expect: () => [
        isA<NationLoading>(),
        isA<NationLoaded>(),
      ],
    );
  });
}
