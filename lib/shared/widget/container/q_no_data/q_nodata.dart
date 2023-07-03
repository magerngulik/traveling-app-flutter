import 'package:flutter/material.dart';

class QNoData extends StatelessWidget {
  const QNoData({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 120.0,
            width: 120.0,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  "assets/icon/no-location.png",
                ),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(
                  16.0,
                ),
              ),
            ),
          ),
          const Text(
            "Belum ada destinasi ke negara ini",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          )
        ],
      ),
    );
  }
}
