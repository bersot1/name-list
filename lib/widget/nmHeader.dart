import 'package:flutter/material.dart';

class NMHeader extends StatelessWidget {
  final String title;
  final double phoneHeigth;

  NMHeader({
    @required this.title,
    @required this.phoneHeigth,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      bottom: 40,
      child: Container(
        height: phoneHeigth * 0.6,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(80),
          ),
          color: Color(0xff4f5b66),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              title,
              style: TextStyle(
                fontFamily: "Poppins",
                fontSize: 30,
                color: Colors.white,
              ),
            )
          ],
        ),
      ),
    );
  }
}
