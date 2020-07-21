import 'package:flutter/material.dart';

class Busy extends StatelessWidget {
  bool busy = false;
  Widget child;

  Busy({
    @required this.busy,
    @required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return busy
        ? Container(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          )
        : child;
  }
}
