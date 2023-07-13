// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'data_package_bloc.dart';

abstract class DataPackageState extends Equatable {
  const DataPackageState();

  @override
  List<Object> get props => [];
}

class DataPackageInitial extends DataPackageState {}

class Loading extends DataPackageState {}

class Loaded extends DataPackageState {
  final List<Map<String, dynamic>> data;
  const Loaded({
    required this.data,
  });
}

class ErrorMessage extends DataPackageState {
  final String error;
  const ErrorMessage({
    required this.error,
  });
}
