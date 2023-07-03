// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:healing_apps/data/healing_services/healing_service.dart';

part 'package_by_id_state.dart';

class PackageByIdCubit extends Cubit<PackageByIdState> {
  final HealingServices services;
  PackageByIdCubit({required this.services}) : super(PackageByIdInitial());

  getByPackageID(int id) async {
    emit(PackageByLoading());
    var data = await services.getPackageByCountryId(id: id);

    data.fold((l) {
      emit(PackageByError(errorMessage: l));
    }, (r) {
      emit(PackageByLoaded(data: r));
    });
  }
}
