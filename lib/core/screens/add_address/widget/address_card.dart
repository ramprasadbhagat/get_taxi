import 'package:flutter/material.dart';
import 'package:get_taxi/utils/get_size.dart';

class AddressCard extends StatelessWidget {
  const AddressCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: 12 * GetSize.getPixelHeight,
        horizontal: 14 * GetSize.getPixelWidth
      ),
      child: Container(
        child: Column(
          children: [
            Container(
              height: 300,
              color: Colors.red,
            )
          ],
        ),
      ),
    );
  }
}
