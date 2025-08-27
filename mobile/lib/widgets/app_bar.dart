import 'package:flutter/material.dart';

class GradientAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: <Color>[
            Color.fromRGBO(1, 76, 131, 1),
            Color.fromRGBO(48, 181, 250, 1),
          ],
        ),
      ),
    );
  }
}
