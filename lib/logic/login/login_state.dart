// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'login_bloc.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState {}

class Loading extends LoginState {}

// ignore: must_be_immutable
class Loaded extends LoginState {
  Map<String, dynamic> dataUser;
  Loaded({
    required this.dataUser,
  });
}

// ignore: must_be_immutable
class Error extends LoginState {
  String error;
  Error({
    required this.error,
  });
}
