import 'package:flutter/material.dart';
import 'package:handy_beachhack/view/constants/constants.dart';

class LinearProgressBarCustom extends StatelessWidget {
  const LinearProgressBarCustom({
    Key? key,
    required this.size,
    required this.percent,
    required this.width,
  }) : super(key: key);

  final Size size;
  final double percent;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.centerLeft,
      children: [
        Container(
          height: 4,
          width: width,
          decoration: BoxDecoration(
            color: grey,
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        Container(
          height: 4,
          width: width * percent,
          decoration: BoxDecoration(
            color: white,
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ],
    );
  }
}
