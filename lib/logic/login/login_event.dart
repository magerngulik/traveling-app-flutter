// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'login_bloc.dart';

class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

// ignore: must_be_immutable
class TryLogin extends LoginEvent {
  final String email, password;
  const TryLogin({
    required this.email,
    required this.password,
  });
}

class Logout extends LoginEvent {
  String token;
  Logout({
    required this.token,
  });
}
