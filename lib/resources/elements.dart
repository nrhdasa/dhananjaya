import 'package:flutter/material.dart';

import 'theme.dart';

List<BoxShadow> shadows1 = [
  BoxShadow(
    color: lightColorScheme.tertiary.withAlpha(60),
    blurRadius: 0.0,
    spreadRadius: 0.0,
    offset: const Offset(
      0.0,
      0.0,
    ),
  ),
  BoxShadow(
    color: lightColorScheme.tertiary.withAlpha(100),
    blurRadius: 1.0,
    spreadRadius: 0.0,
    offset: const Offset(
      -5.0,
      -2.0,
    ),
  ),
];

class squareButton extends StatelessWidget {
  VoidCallback? onPressed;
  Color bgcolor;
  double size;
  Widget icon;
  Text title;
  squareButton({Key? key, required this.onPressed, required this.bgcolor, required this.size, required this.icon, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(onPressed: onPressed, icon: icon, label: title);
    // return Container(
    //   width: size,
    //   height: size,
    //   decoration: BoxDecoration(
    //     border: Border.all(color: ),
    //     shape: BoxShape.rectangle, color: bgcolor),
    //   child: title,
    // );
  }
}
