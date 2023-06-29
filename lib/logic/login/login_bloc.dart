// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:healing_apps/data/healing_services/healing_service.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  HealingServices healing;
  LoginBloc({required this.healing}) : super(LoginInitial()) {
    on<TryLogin>((event, emit) async {
      emit(Loading());
      final result =
          await healing.login(email: event.email, password: event.password);

      result.fold((l) {
        emit(Error(error: l));
      }, (r) => {emit(Loaded(dataUser: r.cast()))});
    });
  }
}
