// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: camel_case_types, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healing_apps/logic/login/login_bloc.dart';

import 'package:healing_apps/logic/package/data_package_bloc.dart';
import 'package:healing_apps/screens/user/detail_country/view/detail_county.dart';
import 'package:healing_apps/screens/user/detail_package/view/detail_package_view.dart';
import 'package:healing_apps/shared/show_loading/Q_loading.dart';
import 'package:healing_apps/shared/widget/card/q_card_rekomendation.dart';

import '../../../../logic/country/country_cubit.dart';
import '../../../../shared/typografi/heading/q_heading.dart';
import '../../../../shared/widget/caraousel/card_package_item_carousel.dart';

class HomePageView extends StatefulWidget {
  const HomePageView({Key? key}) : super(key: key);

  @override
  State<HomePageView> createState() => _HomePageViewState();
}

class _HomePageViewState extends State<HomePageView> {
  @override
  void initState() {
    super.initState();
    context.read<DataPackageBloc>().add(const DataPackageEvent());
    context.read<CountryCubit>().getAllCountry();
  }

  @override
  Widget build(BuildContext context) {
    var data = context.read<DataPackageBloc>();
    var countryData = context.read<CountryCubit>();
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              QHeading(title: "Rekomendasi Paket Liburan"),
              const SizedBox(
                height: 20.0,
              ),
              BlocBuilder<DataPackageBloc, DataPackageState>(
                bloc: data,
                builder: (context, state) {
                  if (state is loading) {
                    return const QLoading();
                  }
                  if (state is loaded) {
                    return Builder(builder: (context) {
                      List items = state.data;

                      return CardPackageItemCarousel(
                        items: items,
                        onChanged: (value) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DetailPackageView(
                                      item: value,
                                    )),
                          );
                        },
                      );
                    });
                  }
                  return const Center(
                    child: Text(
                      "Undefiniton error",
                      style: TextStyle(
                        fontSize: 20.0,
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(
                height: 20.0,
              ),
              QHeading(
                title: "Recomendation",
                subtile: "See All",
              ),
              const SizedBox(
                height: 20.0,
              ),
              BlocBuilder<CountryCubit, CountryState>(
                bloc: countryData,
                builder: (context, state) {
                  if (state is CountryLoaded) {
                    return SizedBox(
                      height: 200.0,
                      child: ListView.builder(
                        itemCount: state.data.length,
                        scrollDirection: Axis.horizontal,
                        padding: EdgeInsets.zero,
                        itemBuilder: (context, index) {
                          var item = state.data[index];
                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => DetailCountryView(
                                          item: item,
                                        )),
                              );
                            },
                            child: QCardListRecomendation(
                              title: item["name"],
                              image: item["image"],
                              fontSize: 15.0,
                              margin: const EdgeInsets.only(
                                left: 10.0,
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  }
                  if (state is LoginLoading) {
                    return const QLoading();
                  }
                  return Container();
                },
              ),
              const SizedBox(
                height: 20.0,
              ),
            ].animate(interval: 100.ms).fade(duration: 200.ms),
          ),
        ),
      ),
    );
  }
}
