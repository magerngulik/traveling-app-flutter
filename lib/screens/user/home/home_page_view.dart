// ignore_for_file: camel_case_types, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:healing_apps/logic/package/data_package_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healing_apps/shared/convert/convert_to_rupiah.dart';

class HomePageView extends StatefulWidget {
  const HomePageView({Key? key}) : super(key: key);

  @override
  State<HomePageView> createState() => _HomePageViewState();
}

class _HomePageViewState extends State<HomePageView> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<DataPackageBloc>().add(DataPackageEvent());
  }

  @override
  Widget build(BuildContext context) {
    var data = context.read<DataPackageBloc>();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home page"),
        actions: const [],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(10.0),
          child: BlocBuilder<DataPackageBloc, DataPackageState>(
            bloc: data,
            builder: (context, state) {
              if (state is loading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (state is loaded) {
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: state.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    final item = state.data[index];
                    var convert = ConvertToRupiah();
                    var price = convert.formatRupiah(value: item['price']);
                    return Card(
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(
                            "${item['image']}",
                          ),
                        ),
                        title: Text(
                          item['name'],
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              item['itinerary'].toString(),
                              maxLines: 2,
                            ),
                            const SizedBox(
                              height: 5.0,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  price,
                                  style: const TextStyle(
                                    fontSize: 15.0,
                                  ),
                                ),
                                const SizedBox(
                                  width: 10.0,
                                ),
                                const Icon(
                                  Icons.person,
                                  size: 18.0,
                                ),
                                const SizedBox(
                                  width: 5.0,
                                ),
                                Text(
                                  "3",
                                  style: TextStyle(
                                    fontSize: 15.0,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
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
          ),
        ),
      ),
    );
  }
}
