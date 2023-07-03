// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:healing_apps/logic/Package_by_id/package_by_id_cubit.dart';
import 'package:healing_apps/shared/show_loading/Q_loading.dart';

import 'package:healing_apps/shared/typografi/heading/q_heading.dart';

import '../../../../shared/typografi/simpe_description/q_description.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../shared/widget/card/q_card_rekomendation.dart';
import '../../../../shared/widget/container/q_no_data/q_nodata.dart';

class DetailCountryView extends StatefulWidget {
  Map item;
  DetailCountryView({
    Key? key,
    required this.item,
  }) : super(key: key);

  @override
  State<DetailCountryView> createState() => _DetailCountryViewState();
}

class _DetailCountryViewState extends State<DetailCountryView> {
  @override
  void initState() {
    super.initState();
    context.read<PackageByIdCubit>().getByPackageID(widget.item['id']);
  }

  @override
  Widget build(BuildContext context) {
    PackageByIdCubit package = context.read<PackageByIdCubit>();
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          widget.item['name'],
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
        actions: const [],
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.4,
                decoration: const BoxDecoration(),
                child: Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(
                            widget.item['image'],
                          ),
                          fit: BoxFit.cover,
                        ),
                        borderRadius: const BorderRadius.only(
                          bottomRight: Radius.circular(32.0),
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.2),
                        borderRadius: const BorderRadius.only(
                          bottomRight: Radius.circular(32.0),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    QHeading(title: "Description"),
                    const SizedBox(
                      height: 10.0,
                    ),
                    QDescription(description: widget.item['description']),
                    const SizedBox(
                      height: 20.0,
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    BlocBuilder<PackageByIdCubit, PackageByIdState>(
                      bloc: package,
                      builder: (context, state) {
                        if (state is PackageByLoading) {
                          return const QLoading();
                        }
                        if (state is PackageByLoaded) {
                          if (state.data.isEmpty) {
                            return const QNoData();
                          }
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              QHeading(title: "Top Package Destination"),
                              const SizedBox(
                                height: 10.0,
                              ),
                              ListView.builder(
                                padding: EdgeInsets.zero,
                                itemCount: state.data.length,
                                physics: const ScrollPhysics(),
                                shrinkWrap: true,
                                itemBuilder: (BuildContext context, int index) {
                                  var item = state.data[index];

                                  return QCardListRecomendation(
                                    title: item["name"],
                                    image: item["image"],
                                    fontSize: 15.0,
                                  );
                                },
                              )
                            ],
                          );
                        }
                        return Container();
                      },
                    )
                  ],
                ),
              ),
            ].animate(interval: 200.ms).fade(duration: 200.ms),
          ),
        ),
      ),
    );
  }
}
