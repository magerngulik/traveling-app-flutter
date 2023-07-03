// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'login_bloc.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

// ignore: must_be_immutable
class LoginLoaded extends LoginState {
  Map<String, dynamic> dataUser;
  LoginLoaded({
    required this.dataUser,
  });
}

// ignore: must_be_immutable
class LoginError extends LoginState {
  String error;
  LoginError({
    required this.error,
  });
}

class LogoutErorr extends LoginState {
  String logoutError;
  LogoutErorr({
    required this.logoutError,
  });
}
