// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable, prefer_const_constructors_in_immutables
part of 'package_by_id_cubit.dart';

abstract class PackageByIdState extends Equatable {
  const PackageByIdState();

  @override
  List<Object> get props => [];
}

class PackageByIdInitial extends PackageByIdState {}

class PackageByLoading extends PackageByIdState {}

class PackageByLoaded extends PackageByIdState {
  List<Map<String, dynamic>> data;
  PackageByLoaded({
    required this.data,
  });
}

class PackageByError extends PackageByIdState {
  final String errorMessage;
  PackageByError({
    required this.errorMessage,
  });
}
