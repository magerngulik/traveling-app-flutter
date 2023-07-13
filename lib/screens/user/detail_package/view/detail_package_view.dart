// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:healing_apps/screens/user/checkout/view/checkout_view.dart';
import 'package:healing_apps/screens/user/detail_destination/view/detail_destination_view.dart';

import 'package:healing_apps/shared/typografi/heading/q_heading.dart';

import '../../../../shared/fun/convert/convert_to_rupiah.dart';
import '../../../../shared/typografi/point text/q_point.dart';
import '../../../../shared/widget/card/q_card_destination.dart';

class DetailPackageView extends StatelessWidget {
  final Map item;

  const DetailPackageView({
    Key? key,
    required this.item,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String description =
        item['description'].replaceAll('<p>', '').replaceAll('</p>', '');
    var convert = ConvertToRupiah();
    var price = convert.formatRupiah(value: item['price']);
    List<Map<String, dynamic>> itinery =
        List<Map<String, dynamic>>.from(item['itinerary']);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Colors.transparent,
        title: Text(
          item['name'],
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        actions: const [],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 300.0,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(item['image']),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(16.0),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20.0),
                  QHeading(
                    title: "Description",
                    fontSize: 20.0,
                  ),
                  const SizedBox(height: 10.0),
                  Text(
                    description,
                    textAlign: TextAlign.justify,
                    style: const TextStyle(
                      fontSize: 16.0,
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  (itinery.isNotEmpty)
                      ? Column(
                          children: [
                            QHeading(
                              title: "Rencana Perjalanan",
                              fontSize: 18.0,
                            ),
                            ListView.builder(
                              itemCount: itinery.length,
                              shrinkWrap: true,
                              padding: EdgeInsets.zero,
                              clipBehavior: Clip.none,
                              itemBuilder: (context, index) {
                                var item = itinery[index];
                                return QPointText(title: item['destinasi']);
                              },
                            ),
                            const SizedBox(
                              height: 20.0,
                            ),
                          ],
                        )
                      : Container(),
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
                  const SizedBox(height: 20.0),
                  QHeading(
                    title: "Destinations",
                    fontSize: 18.0,
                  ),
                  const SizedBox(height: 10.0),
                  ListView.builder(
                    itemCount: item['destination'].length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.zero,
                    itemBuilder: (BuildContext context, int index) {
                      var destination = item['destination'][index];
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DetailDestinationView(
                                      data: destination,
                                      status: false,
                                    )),
                          );
                        },
                        child: CardDestination(
                          image: destination['image'],
                          title: destination['name'],
                          subtitle: destination['description'],
                          location: destination['location_name'],
                          margin: const EdgeInsets.only(bottom: 20.0),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 100.0,
        padding: const EdgeInsets.all(20.0),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(
              16.0,
            ),
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: SizedBox(
                height: 48,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const CheckoutView(
                                item: {},
                              )),
                    );
                  },
                  child: const Text(
                    "Checkout",
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
