import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:handy_beachhack/view/constants/constants.dart';
import 'package:handy_beachhack/view/screens/learning/lessons/numbers/number_page.dart';

class AssessmentPage extends StatefulWidget {
  const AssessmentPage({Key? key}) : super(key: key);

  @override
  State<AssessmentPage> createState() => _AssessmentPageState();
}

class _AssessmentPageState extends State<AssessmentPage> {
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
              "Sorry! Assessment not available now!.\nwe will be updating soon",
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: defaultPadding,
            ),
          ],
        ),
      ),
    ));
  }
}
