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
    on<Initialize>((event, emit) async {
      emit(AuthenticationLoading());

      final token = await _authenticationService.isAuthenticated();

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
            : AuthenticationNotAuthenticated());
      } on AuthenticationException catch (e) {
        emit(AuthenticationFailure(message: e.message));
        emit(AuthenticationNotAuthenticated());
      } catch (error) {
        emit(const AuthenticationFailure(message: 'An has occurred'));
        emit(AuthenticationNotAuthenticated());
      }
    });

    on<LogoutEvent>((event, emit) async {
      await _authenticationService.logout();

      emit(AuthenticationNotAuthenticated());
    });
  }
}
