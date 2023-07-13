// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: camel_case_types, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healing_apps/logic/destination/destination_cubit.dart';

import 'package:healing_apps/logic/login/login_bloc.dart';
import 'package:healing_apps/logic/package/data_package_bloc.dart';
import 'package:healing_apps/screens/user/detail_country/view/detail_county.dart';
import 'package:healing_apps/screens/user/detail_destination/view/detail_destination_view.dart';
import 'package:healing_apps/screens/user/detail_package/view/detail_package_view.dart';
import 'package:healing_apps/shared/show_loading/Q_loading.dart';
import 'package:healing_apps/shared/widget/card/q_card_rekomendation.dart';

import '../../../../logic/country/country_cubit.dart';
import '../../../../shared/typografi/heading/q_heading.dart';
import '../../../../shared/widget/caraousel/card_package_item_carousel.dart';
import '../../../../shared/widget/card/q_card_destination2.dart';

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
    context.read<DestinationCubit>().getDestination();
  }

  @override
  Widget build(BuildContext context) {
    var data = context.read<DataPackageBloc>();
    var countryData = context.read<CountryCubit>();
    var destination = context.read<DestinationCubit>();
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: TextFormField(
                      initialValue: null,
                      decoration: InputDecoration(
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 20.0),
                        filled: true,
                        fillColor: Colors.grey[100],
                        hintText: "Search",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(32),
                            borderSide: BorderSide(color: Colors.grey[50]!)),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(32),
                            borderSide: BorderSide(color: Colors.grey[50]!)),
                      ),
                      onChanged: (value) {},
                    ),
                  ),
                  const SizedBox(
                    width: 20.0,
                  ),
                  CircleAvatar(
                    backgroundColor: Colors.grey[100],
                    maxRadius: 25,
                    child: const Icon(
                      Icons.message_outlined,
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 30.0,
              ),
              QHeading(title: "Rekomendasi Paket Liburan"),
              const SizedBox(
                height: 20.0,
              ),
              BlocBuilder<DataPackageBloc, DataPackageState>(
                bloc: data,
                builder: (context, state) {
                  if (state is Loading) {
                    return const QLoading();
                  }
                  if (state is Loaded) {
                    return Builder(builder: (context) {
                      List items = state.data;

                      if (items.isEmpty) {
                        return Container(
                          height: 100.0,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(
                                16.0,
                              ),
                            ),
                          ),
                          child: const Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Yah Belum ada package aktif",
                                style: TextStyle(
                                  fontSize: 20.0,
                                ),
                              ),
                            ],
                          ),
                        );
                      }

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
                title: "Favorite Country",
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
              QHeading(title: "Destinasi Pilihan"),
              const SizedBox(
                height: 20.0,
              ),
              BlocBuilder<DestinationCubit, DestinationState>(
                bloc: destination,
                builder: (context, state) {
                  if (state is DestinationLoading) {
                    return const QLoading();
                  }

                  if (state is DestinationError) {
                    return Center(
                      child: Text(
                        "Error : ${state.message}",
                        style: const TextStyle(
                          fontSize: 20.0,
                        ),
                      ),
                    );
                  }

                  if (state is DestinationLoaded) {
                    return ListView.builder(
                      itemCount: state.data.length,
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      clipBehavior: Clip.none,
                      itemBuilder: (context, index) {
                        var item = state.data[index];

                        return InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => DetailDestinationView(
                                        data: item,
                                        status: true,
                                      )),
                            );
                          },
                          child: SizedBox(
                            height: MediaQuery.of(context).size.height * 0.3,
                            child: QCardDestination(
                                image: item['image'],
                                price: 3000,
                                title: item['name'],
                                location: item['location']['name'],
                                rating: double.parse(item['rating'])),
                          ),
                        );
                      },
                    );
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
              )
            ].animate(interval: 100.ms).fade(duration: 200.ms),
          ),
        ),
      ),
    );
  }
}
