import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:shoppingify/services/authentication.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthenticationService _authenticationService;

  AuthenticationBloc(this._authenticationService)
      : super(AuthenticationInitial()) {
    on<Initialize>((event, emit) {
      emit(AuthenticationLoading());

      final token = _authenticationService.isAuthenticated();

      emit(token != null
          ? AuthenticationSuccess(token)
          : AuthenticationNotAuthenticated());
    });

    on<LoginEvent>((event, emit) async {
      try {
        emit(AuthenticationLoading());
        final token =
            await _authenticationService.login(event.email, event.password);

        emit(token != null
            ? AuthenticationSuccess(token)
            : const AuthenticationFailure(message: 'Login failed'));
      } catch (error) {
        emit(const AuthenticationFailure(message: 'An has occurred'));
      }
    });
  }
}
