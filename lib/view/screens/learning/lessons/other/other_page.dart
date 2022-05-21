import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:handy_beachhack/view/constants/constants.dart';
import 'package:handy_beachhack/view/screens/learning/lessons/numbers/number_page.dart';

class OtherLessons extends StatefulWidget {
  const OtherLessons({Key? key}) : super(key: key);

  @override
  State<OtherLessons> createState() => _OtherLessonsState();
}

class _OtherLessonsState extends State<OtherLessons> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: white,
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(
              'assets/svg/oops-svg.svg',
              height: 200,
            ),
            const SizedBox(
              height: defaultPadding * 2,
            ),
            Text(
              "Sorry! this lecture not available now!.\nwe will be updating soon",
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: defaultPadding,
            ),
            Text(
              "numbers is available now",
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: defaultPadding * 2,
            ),
            InkWell(
              onTap: () {
                Get.to(NumberPage());
              },
              child: Container(
                height: 80,
                width: 250,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Color(0xff32BEA6),
                ),
                child: Text(
                  "Go to numbers lecture",
                  style: TextStyle(
                    color: white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
