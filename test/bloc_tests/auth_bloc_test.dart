// filepath: /Users/administrador/AndroidStudioProjects/nation_forge/test/bloc_tests/auth_bloc_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:nation_forge/presentation/providers/blocs/auth/auth_bloc.dart';

@GenerateMocks([
  FirebaseAuth, 
  GoogleSignIn, 
  GoogleSignInAccount, 
  GoogleSignInAuthentication,
  UserCredential,
  User
])

import 'auth_bloc_test.mocks.dart';

// Creamos una clase para hacer override del AuthBloc y permitir inyección de dependencias
class TestableAuthBloc extends AuthBloc {
  final FirebaseAuth mockAuth;
  final GoogleSignIn mockGoogleSignIn;

  TestableAuthBloc({
    required this.mockAuth,
    required this.mockGoogleSignIn,
  });

  @override
  FirebaseAuth get _auth => mockAuth;

  @override
  GoogleSignIn get _googleSignIn => mockGoogleSignIn;
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  
  late MockFirebaseAuth mockFirebaseAuth;
  late MockGoogleSignIn mockGoogleSignIn;
  late MockGoogleSignInAccount mockGoogleSignInAccount;
  late MockGoogleSignInAuthentication mockGoogleSignInAuthentication;
  late MockUserCredential mockUserCredential;
  late MockUser mockUser;
  late TestableAuthBloc authBloc;

  setUp(() async {
    // Configurar SharedPreferences para pruebas
    SharedPreferences.setMockInitialValues({});
    
    // Configurar mocks
    mockFirebaseAuth = MockFirebaseAuth();
    mockGoogleSignIn = MockGoogleSignIn();
    mockGoogleSignInAccount = MockGoogleSignInAccount();
    mockGoogleSignInAuthentication = MockGoogleSignInAuthentication();
    mockUserCredential = MockUserCredential();
    mockUser = MockUser();

    // Configurar comportamiento de los mocks
    when(mockGoogleSignIn.signIn())
        .thenAnswer((_) async => mockGoogleSignInAccount);
    
    when(mockGoogleSignInAccount.authentication)
        .thenAnswer((_) async => mockGoogleSignInAuthentication);
    
    when(mockGoogleSignInAuthentication.accessToken)
        .thenReturn('mock-access-token');
    
    when(mockGoogleSignInAuthentication.idToken)
        .thenReturn('mock-id-token');
    
    when(mockFirebaseAuth.signInWithCredential(any))
        .thenAnswer((_) async => mockUserCredential);
    
    when(mockUserCredential.user).thenReturn(mockUser);
    when(mockUser.uid).thenReturn('mock-user-id');

    // Inicializar el bloc con mocks inyectados
    authBloc = TestableAuthBloc(
      mockAuth: mockFirebaseAuth,
      mockGoogleSignIn: mockGoogleSignIn,
    );
  });

  tearDown(() {
    authBloc.close();
  });

  test('El estado inicial del AuthBloc debe ser AuthInitial', () {
    expect(authBloc.state, isA<AuthInitial>());
  });

  blocTest<TestableAuthBloc, AuthState>(
    'Emite [AuthLoading, AuthAuthenticated] cuando la autenticación con Google es exitosa',
    build: () => authBloc,
    act: (bloc) => bloc.add(AuthLoginGoogle()),
    expect: () => [
      isA<AuthLoading>(),
      isA<AuthAuthenticated>(),
    ],
    verify: (_) {
      verify(mockGoogleSignIn.signIn()).called(1);
      verify(mockGoogleSignInAccount.authentication).called(1);
      verify(mockFirebaseAuth.signInWithCredential(any)).called(1);
    },
  );

  blocTest<TestableAuthBloc, AuthState>(
    'Emite [AuthLoading, AuthError] cuando el usuario cancela inicio de sesión con Google',
    build: () {
      when(mockGoogleSignIn.signIn()).thenAnswer((_) async => null);
      return authBloc;
    },
    act: (bloc) => bloc.add(AuthLoginGoogle()),
    expect: () => [
      isA<AuthLoading>(),
      isA<AuthError>(),
    ],
    verify: (_) {
      verify(mockGoogleSignIn.signIn()).called(1);
    },
  );

  blocTest<TestableAuthBloc, AuthState>(
    'Emite [AuthLoading, AuthError] cuando ocurre un error en la autenticación con Google',
    build: () {
      when(mockFirebaseAuth.signInWithCredential(any))
          .thenThrow(Exception('Error de autenticación'));
      return authBloc;
    },
    act: (bloc) => bloc.add(AuthLoginGoogle()),
    expect: () => [
      isA<AuthLoading>(),
      isA<AuthError>(),
    ],
    verify: (_) {
      verify(mockGoogleSignIn.signIn()).called(1);
      verify(mockGoogleSignInAccount.authentication).called(1);
      verify(mockFirebaseAuth.signInWithCredential(any)).called(1);
    },
  );
}
