// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: camel_case_types, prefer_typing_uninitialized_variables

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';

import 'package:healing_apps/logic/package%20by%20destination/package_by_destination_cubit.dart';
import 'package:healing_apps/shared/show_loading/Q_loading.dart';
import 'package:healing_apps/shared/typografi/heading/q_heading.dart';
import 'package:healing_apps/shared/widget/container/q_no_data/q_nodata.dart';

import '../../../../shared/typografi/point text/q_point.dart';
import '../../../../shared/widget/card/q_card_detail_destination.dart';

class DetailDestinationView extends StatefulWidget {
  final Map data;
  final bool status;
  const DetailDestinationView({
    Key? key,
    required this.data,
    required this.status,
  }) : super(key: key);

  @override
  State<DetailDestinationView> createState() => _DetailDestinationViewState();
}

class _DetailDestinationViewState extends State<DetailDestinationView> {
  var loger = Logger();
  @override
  void initState() {
    super.initState();
    context.read<PackageByDestinationCubit>().getPackage(widget.data['id']);
    loger.v(widget.data['id']);
    loger.v(widget.data);
  }

  @override
  Widget build(BuildContext context) {
    var package = context.read<PackageByDestinationCubit>();
    String description =
        widget.data['description'].replaceAll('<p>', '').replaceAll('</p>', '');
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.white),
          backgroundColor: Colors.transparent,
          title: const Text(
            "Detail Destinasi",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          actions: const [],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              CachedNetworkImage(
                imageUrl: widget.data['image'],
                imageBuilder: (context, imageProvider) => Container(
                  height: MediaQuery.of(context).size.height / 3,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.cover,
                    ),
                    borderRadius: const BorderRadius.only(
                      bottomRight: Radius.circular(
                        32.0,
                      ),
                    ),
                  ),
                  child: Container(
                    color: Colors.black.withOpacity(0.2),
                  ),
                ),
                placeholder: (context, url) =>
                    const CircularProgressIndicator(),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
              Container(
                margin: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            widget.data['name'],
                            style: const TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Spacer(),
                          const Icon(
                            Icons.star,
                            size: 18.0,
                            color: Colors.orange,
                          ),
                          const SizedBox(
                            width: 5.0,
                          ),
                          Text(
                            widget.data['rating'],
                            style: const TextStyle(
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.orange,
                            ),
                          ),
                        ]),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.location_on,
                          size: 13.0,
                          color: Colors.blue,
                        ),
                        const SizedBox(
                          width: 5.0,
                        ),
                        (widget.data['location'] == null)
                            ? Text(
                                widget.data['location_name'],
                                style: const TextStyle(
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue,
                                ),
                              )
                            : Text(
                                widget.data['location']['name'],
                                style: const TextStyle(
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue,
                                ),
                              )
                      ],
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    QHeading(title: "Tentang", fontSize: 15),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      description,
                      textAlign: TextAlign.justify,
                      style: const TextStyle(
                        fontSize: 13.0,
                      ),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    (widget.data['accommodation'] != null)
                        ? Column(
                            children: [
                              QHeading(title: "Akomodasi", fontSize: 15),
                              const SizedBox(
                                height: 10.0,
                              ),
                              ListView.builder(
                                itemCount: widget.data['accommodation'].length,
                                shrinkWrap: true,
                                padding: EdgeInsets.zero,
                                itemBuilder: (BuildContext context, int index) {
                                  var item =
                                      widget.data['accommodation'][index];
                                  return QPointText(title: item['name']);
                                },
                              ),
                            ],
                          )
                        : Container(),
                    const SizedBox(
                      height: 10.0,
                    ),
                    (widget.status)
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              QHeading(
                                  title: "Package yang tersedia", fontSize: 15),
                              const SizedBox(
                                height: 10.0,
                              ),
                              BlocBuilder<PackageByDestinationCubit,
                                  PackageByDestinationState>(
                                bloc: package,
                                builder: (context, state) {
                                  if (state is PackageByDestinationLoaded) {
                                    if (state.data.isEmpty) {
                                      return const QNoData(
                                        message:
                                            "Belum ada tujuan yang aktif menuju destinasi ini",
                                      );
                                    }
                                    return ListView.builder(
                                      itemCount: state.data.length,
                                      shrinkWrap: true,
                                      padding: EdgeInsets.zero,
                                      clipBehavior: Clip.none,
                                      itemBuilder: (context, index) {
                                        var item = state.data[index];
                                        return QCardPackageDetailDestination(
                                            imageUrl: item['image'],
                                            title: item['name'],
                                            price: item['price'],
                                            people: "${item['person']}",
                                            days: "${item['days']}");
                                      },
                                    );
                                  }
                                  if (state is PackageByDestinationInitial ||
                                      state is PackageByDestinationLoading) {
                                    return const QLoading();
                                  }

                                  if (state is PackageByDestinationError) {
                                    return Center(
                                      child: Text(
                                        "Error : ${state.errorMassage}",
                                        style: const TextStyle(
                                          fontSize: 20.0,
                                        ),
                                      ),
                                    );
                                  }
                                  return Container();
                                },
                              )
                            ],
                          )
                        : Container()
                  ],
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: (widget.status == false)
            ? Container(
                height: 50,
                margin: const EdgeInsets.all(10.0),
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("Kembali"),
                ),
              )
            : null);
  }
}
