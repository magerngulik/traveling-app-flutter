// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:healing_apps/data/healing_services/healing_service.dart';

part 'destination_state.dart';

class DestinationCubit extends Cubit<DestinationState> {
  HealingServices services;
  DestinationCubit({required this.services}) : super(DestinationInitial());

  getDestination() async {
    emit(DestinationLoading());
    var data = await services.getDestination();

    data.fold((l) {
      emit(DestinationError(message: l));
    }, (r) {
      emit(DestinationLoaded(data: r));
    });
  }
}
