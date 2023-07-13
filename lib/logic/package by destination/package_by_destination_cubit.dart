// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:healing_apps/data/healing_services/healing_service.dart';

part 'package_by_destination_state.dart';

class PackageByDestinationCubit extends Cubit<PackageByDestinationState> {
  HealingServices services;
  PackageByDestinationCubit({required this.services})
      : super(PackageByDestinationInitial());

  getPackage(int id) async {
    emit(PackageByDestinationLoading());
    var response = await services.getPackagebyDestination(id: id);
    response.fold((l) {
      emit(PackageByDestinationError(errorMassage: l));
    }, (r) {
      emit(PackageByDestinationLoaded(data: r));
    });
  }
}
