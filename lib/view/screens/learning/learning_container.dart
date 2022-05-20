import 'package:flutter/material.dart';
import 'package:handy_beachhack/view/constants/constants.dart';

class LearningContainer extends StatelessWidget {
  const LearningContainer({
    Key? key,
    this.color = white,
    required this.title,
    required this.image,
    this.decription = "",
    this.opacity = 0.3,
  }) : super(key: key);
  final String title;
  final String image;
  final String decription;
  final Color color;
  final double opacity;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Container(
            height: 130,
            width: double.maxFinite,
            decoration: BoxDecoration(),
            child: Image.network(
              image,
              fit: BoxFit.cover,
            ),
          ),
        ),
        Container(
          height: 130,
          width: double.maxFinite,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: red.withOpacity(opacity)),
        ),
        Positioned(
            bottom: 20,
            right: 10,
            child: Text(
              title,
              style: TextStyle(
                  fontWeight: FontWeight.bold, fontSize: 18, color: color),
            )),
        Positioned(
            bottom: 4,
            right: 10,
            child: Text(
              decription,
              style: TextStyle(
                  fontWeight: FontWeight.bold, fontSize: 15, color: color),
            ))
      ],
    );
  }
}
