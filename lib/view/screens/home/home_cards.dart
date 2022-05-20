import 'package:flutter/material.dart';
import 'package:handy_beachhack/view/constants/constants.dart';
import 'package:handy_beachhack/view/screens/home/linear_progess.dart';

class HomeContainerOne extends StatelessWidget {
  const HomeContainerOne({
    Key? key,
    required this.size,
    required this.title,
    required this.assets,
    required this.ontap,
  }) : super(key: key);

  final Size size;
  final String title;
  final String assets;
  final VoidCallback ontap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Container(
        height: (size.width - defaultPadding * 4) / 2,
        width: (size.width - defaultPadding * 4) / 2,
        decoration: BoxDecoration(
          color: primaryPurple,
          borderRadius: BorderRadius.circular(defaultPadding),
        ),
        padding: EdgeInsets.all(defaultPadding),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              title,
              style: TextStyle(
                color: white,
                fontSize: 16,
              ),
            ),
            Image.asset(
              "assets/png/$assets.png",
              height: 70,
            ),
          ],
        ),
      ),
    );
  }
}
