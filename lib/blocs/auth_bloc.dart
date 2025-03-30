import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final _auth = FirebaseAuth.instance;

  Future<void> saveSession(String userId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_id', userId);
  }

  AuthBloc() : super(AuthInitial()) {
    on<AuthLoginGoogle>((event, emit) async {
      try {
        emit(AuthLoading());
        final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

        if (googleUser == null) {
          emit(AuthError("Inicio de sesión cancelado"));
          return;
        }

        final GoogleSignInAuthentication? googleAuth = await googleUser.authentication;

        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth?.accessToken,
          idToken: googleAuth?.idToken,
        );

        final UserCredential userCredential = await _auth.signInWithCredential(credential);
        await saveSession(userCredential.user!.uid);
        return emit(AuthAuthenticated(userCredential.user!));
      }
      catch (e) {
        emit(AuthError(e.toString()));
      }
    });
  }
}
