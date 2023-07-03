// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../data/healing_services/healing_service.dart';

part 'data_package_event.dart';
part 'data_package_state.dart';

class DataPackageBloc extends Bloc<DataPackageEvent, DataPackageState> {
  HealingServices services;
  DataPackageBloc({required this.services}) : super(DataPackageInitial()) {
    on<DataPackageEvent>((event, emit) async {
      emit(loading());
      final result = await services.getPackage();
      result.fold((l) {
        emit(ErrorMessage(error: l));
      }, (r) => {emit(loaded(data: r))});
    });
  }
}
