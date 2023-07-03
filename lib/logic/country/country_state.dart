// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'country_cubit.dart';

abstract class CountryState extends Equatable {
  const CountryState();

  @override
  List<Object> get props => [];
}

class CountryInitial extends CountryState {}

class CountryLoading extends CountryState {}

// ignore: must_be_immutable
class CountryLoaded extends CountryState {
  List<Map<String, dynamic>> data;
  CountryLoaded({
    required this.data,
  });
}

class CountryError extends CountryState {
  final String message;
  const CountryError({
    required this.message,
  });
}
