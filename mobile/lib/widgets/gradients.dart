import 'package:flutter/cupertino.dart';

class BackgroundGradient extends BoxDecoration {
  BackgroundGradient(this.gradient);
  final Gradient gradient;

  static LinearGradient linearGradient() {
    return LinearGradient(
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
      colors: [
        Color.lerp(Color(0xFFC4F4FF), Color(0xFFFFFFFF), 0.5)!,
        Color.lerp(Color(0xFFC4F4FF), Color(0xFFFFFFFF), 0.7)!,
        Color.lerp(Color(0xFFC4F4FF), Color(0xFFFFFFFF), 0.9)!,
        Color(0xFFFFFFFF),
        Color(0xFFFFFFFF),
        Color(0xFFFFFFFF),
        Color.lerp(Color(0xFFC4F4FF), Color(0xFFFFFFFF), 0.9)!,
        Color.lerp(Color(0xFFC4F4FF), Color(0xFFFFFFFF), 0.7)!,
        Color.lerp(Color(0xFFC4F4FF), Color(0xFFFFFFFF), 0.5)!,
      ],
      // stops: [0.45, 1],
    );
  }
}
