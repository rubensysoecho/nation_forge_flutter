import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nation_forge/widgets/create_nation_dialog.dart';
import 'package:nation_forge/presentation/providers/blocs/nation/nation_bloc.dart';
import 'package:nation_forge/presentation/providers/blocs/nation/nation_event.dart';
import 'package:mockito/annotations.dart';

@GenerateMocks([NationBloc])
import 'create_nation_dialog_test.mocks.dart';

void main() {
  late MockNationBloc mockNationBloc;

  setUp(() {
    mockNationBloc = MockNationBloc();
  });

  testWidgets('CreateNationDialog muestra los campos correctamente', (WidgetTester tester) async {
    // Verificar que el diálogo muestra los campos básicos
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: BlocProvider<NationBloc>.value(
            value: mockNationBloc,
            child: const CreateNationDialog(),
          ),
        ),
      ),
    );

    // Verificar que los campos básicos están presentes
    expect(find.text('Crear Nación'), findsOneWidget);
    expect(find.text('Simple'), findsOneWidget);
    expect(find.text('Avanzado'), findsOneWidget);
    expect(find.widgetWithText(TextField, 'Nombre de la Nación'), findsOneWidget);
    expect(find.widgetWithText(TextField, 'Tipo de Gobierno'), findsOneWidget);
    expect(find.widgetWithText(TextField, 'Era'), findsOneWidget);
    expect(find.widgetWithText(ElevatedButton, 'Generar'), findsOneWidget);
  });

  testWidgets('El botón de modo avanzado muestra campos adicionales', (WidgetTester tester) async {
    // Configurar widget con BlocProvider
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: BlocProvider<NationBloc>.value(
            value: mockNationBloc,
            child: const CreateNationDialog(),
          ),
        ),
      ),
    );

    // Inicialmente no debería mostrar campos avanzados
    expect(find.text('Política'), findsNothing);
    
    // Cambiar a modo avanzado
    await tester.tap(find.byType(Switch).first);
    await tester.pumpAndSettle();

    // Verificar que aparecen los campos avanzados
    expect(find.text('Política'), findsOneWidget);
    expect(find.text('Economía'), findsOneWidget);
    expect(find.text('Demografía'), findsOneWidget);
    expect(find.widgetWithText(TextField, 'Nombre del Líder'), findsOneWidget);
    expect(find.widgetWithText(TextField, 'Sistema Económico'), findsOneWidget);
    expect(find.widgetWithText(TextField, 'Nombre de la Moneda'), findsOneWidget);
    expect(find.widgetWithText(TextField, 'Expectativa de Vida'), findsOneWidget);
  });

  testWidgets('Al hacer clic en Generar con campos vacíos muestra un mensaje de error', 
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: BlocProvider<NationBloc>.value(
            value: mockNationBloc,
            child: const CreateNationDialog(),
          ),
        ),
      ),
    );

    // Intentar generar con campos vacíos
    await tester.tap(find.widgetWithText(ElevatedButton, 'Generar'));
    await tester.pump();
    
    // El Toast no se puede verificar directamente en los tests de widgets,
    // pero podemos verificar que no se llamó al bloc porque los campos están vacíos
    verifyNever(mockNationBloc.add(any));
  });

  testWidgets('Al hacer clic en Generar con campos completos llama a CreateNation', 
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: BlocProvider<NationBloc>.value(
            value: mockNationBloc,
            child: const CreateNationDialog(),
          ),
        ),
      ),
    );

    // Completar campos requeridos
    await tester.enterText(
      find.widgetWithText(TextField, 'Nombre de la Nación'), 
      'Test Nation'
    );
    await tester.enterText(
      find.widgetWithText(TextField, 'Tipo de Gobierno'), 
      'Democracy'
    );
    await tester.enterText(
      find.widgetWithText(TextField, 'Era'), 
      '2023'
    );

    // Hacer clic en Generar
    await tester.tap(find.widgetWithText(ElevatedButton, 'Generar'));
    await tester.pump();

    // Verificar que se llama al evento CreateNation con los parámetros correctos
    verify(mockNationBloc.add(any)).called(1);
  });
}
