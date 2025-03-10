import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:nation_forge/repos/auth_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _repository = AuthRepository();

  AuthBloc() : super(AuthInitial()) {
    on<AuthLogin>((event, emit) async {
      emit(AuthLoading());
      try {
        String loginToken =
            await _repository.login(event.email, event.password);
        if (loginToken != "") {
          return emit(AuthSuccesful(loginToken));
        } else {
          return emit(
            AuthRejected(
              'Account not found',
            ),
          );
        }
      } catch (e) {
        return emit(
          AuthRejected(
            e.toString(),
          ),
        );
      }
    });
  }
}
