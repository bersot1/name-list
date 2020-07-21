import 'package:flutter/material.dart';

class HeaderListBody extends StatelessWidget {
  final int total;

  HeaderListBody({
    @required this.total,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Text(
          "Pessoas da Lista",
          style: TextStyle(
            fontFamily: "Poppins",
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          "Total: ${total}",
          style: TextStyle(
            fontFamily: "Poppins",
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
        )
      ],
    );
  }
}
