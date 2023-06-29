// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:healing_apps/data/healing_services/healing_service.dart';

part 'country_state.dart';

class CountryCubit extends Cubit<CountryState> {
  HealingServices services;
  CountryCubit({required this.services}) : super(CountryInitial());

  getAllCountry() {
    emit(CountryLoading());
  }
}
