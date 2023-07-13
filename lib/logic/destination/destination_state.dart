// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'destination_cubit.dart';

abstract class DestinationState extends Equatable {
  const DestinationState();

  @override
  List<Object> get props => [];
}

class DestinationInitial extends DestinationState {}

class DestinationLoading extends DestinationState {}

class DestinationLoaded extends DestinationState {
  final List<Map<String, dynamic>> data;
  const DestinationLoaded({
    required this.data,
  });
}

class DestinationError extends DestinationState {
  final String message;
  const DestinationError({
    required this.message,
  });
}
