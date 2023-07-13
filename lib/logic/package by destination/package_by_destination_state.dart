// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'package_by_destination_cubit.dart';

abstract class PackageByDestinationState extends Equatable {
  const PackageByDestinationState();

  @override
  List<Object> get props => [];
}

class PackageByDestinationInitial extends PackageByDestinationState {}

class PackageByDestinationLoading extends PackageByDestinationState {}

class PackageByDestinationLoaded extends PackageByDestinationState {
  final List<Map<String, dynamic>> data;
  const PackageByDestinationLoaded({required this.data});
}

class PackageByDestinationError extends PackageByDestinationState {
  final String errorMassage;
  const PackageByDestinationError({
    required this.errorMassage,
  });
}
