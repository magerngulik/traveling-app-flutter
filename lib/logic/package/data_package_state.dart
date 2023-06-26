// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'data_package_bloc.dart';

abstract class DataPackageState extends Equatable {
  const DataPackageState();

  @override
  List<Object> get props => [];
}

class DataPackageInitial extends DataPackageState {}

class loading extends DataPackageState {}

class loaded extends DataPackageState {
  List<Map<String, dynamic>> data;
  loaded({
    required this.data,
  });
}

class ErrorMessage extends DataPackageState {
  String error;
  ErrorMessage({
    required this.error,
  });
}
