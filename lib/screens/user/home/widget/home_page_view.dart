// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: camel_case_types, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:healing_apps/logic/package/data_package_bloc.dart';
import 'package:healing_apps/screens/user/detail_package/view/detail_package_view.dart';
import 'package:healing_apps/shared/widget/card/q_card_rekomendation.dart';

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
  }

  @override
  Widget build(BuildContext context) {
    var data = context.read<DataPackageBloc>();
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
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
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
              QCardListRecomendation(
                title: "Indonesia",
                image: "https://picsum.photos/1000",
                fontSize: 15.0,
              )
            ].animate(interval: 100.ms).fade(duration: 200.ms),
          ),
        ),
      ),
    );
  }
}
