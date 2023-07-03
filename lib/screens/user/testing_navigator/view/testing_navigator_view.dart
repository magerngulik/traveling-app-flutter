// ignore_for_file: camel_case_types, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:healing_apps/screens/user/detail_page_testing/view/detail_page_testing.dart';

class TestingNavigatorView extends StatefulWidget {
  const TestingNavigatorView({Key? key}) : super(key: key);

  @override
  State<TestingNavigatorView> createState() => _TestingNavigatorViewState();
}

class _TestingNavigatorViewState extends State<TestingNavigatorView> {
  List<Map> halaman = [
    {
      "title": "DetailPage1",
      "ontap": const DetailPageTesting(),
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Testing Navigator"),
        actions: const [],
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(10.0),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio: 1.0,
          crossAxisCount: 2,
          mainAxisSpacing: 6,
          crossAxisSpacing: 6,
        ),
        itemCount: halaman.length,
        shrinkWrap: true,
        physics: const ScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          var item = halaman[index];
          return InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => item['ontap']),
              );
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.red[400],
                borderRadius: const BorderRadius.all(
                  Radius.circular(32.0),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    item['title'],
                    style: const TextStyle(
                      fontSize: 18.0,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
