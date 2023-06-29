// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: camel_case_types, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';

import 'package:healing_apps/shared/typografi/heading/q_heading.dart';

import '../../../../shared/fun/convert/convert_to_rupiah.dart';
import '../../../../shared/widget/card/q_card_destination.dart';

// ignore: must_be_immutable
class DetailPackageView extends StatefulWidget {
  Map item;
  DetailPackageView({
    Key? key,
    required this.item,
  }) : super(key: key);

  @override
  State<DetailPackageView> createState() => _DetailPackageViewState();
}

class _DetailPackageViewState extends State<DetailPackageView> {
  @override
  Widget build(BuildContext context) {
    String description =
        widget.item['description'].replaceAll('<p>', '').replaceAll('</p>', '');
    var convert = ConvertToRupiah();

    var price = convert.formatRupiah(value: widget.item['price']);
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Colors.transparent,
        title: Text(
          widget.item['name'],
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        actions: const [],
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              Container(
                height: 300.0,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(
                      widget.item['image'],
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                top: 280,
                right: 0,
                left: 0,
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(
                      Radius.circular(
                        16.0,
                      ),
                    ),
                  ),
                  child: ListView(
                    clipBehavior: Clip.none,
                    shrinkWrap: true,
                    children: [
                      QHeading(
                        title: "Description",
                        fontSize: 20.0,
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        description,
                        textAlign: TextAlign.justify,
                        style: const TextStyle(
                          fontSize: 16.0,
                        ),
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      QHeading(
                        title: "Price",
                        fontSize: 18.0,
                      ),
                      Text(
                        price,
                        style: const TextStyle(
                          fontSize: 15.0,
                        ),
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      QHeading(
                        title: "All Destination",
                        fontSize: 18.0,
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      ListView.builder(
                        itemCount: widget.item['destination'].length,
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, int index) {
                          var item = widget.item['destination'][index];
                          return CardDestination(
                            image: item['image'],
                            title: item['name'],
                            subtitle: item['description'],
                            location: item['location_name'],
                            margin: const EdgeInsets.only(
                              bottom: 20.0,
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
