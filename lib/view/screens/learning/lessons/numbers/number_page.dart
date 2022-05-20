import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:handy_beachhack/database/isl_db.dart';
import 'package:handy_beachhack/models/lecture_model.dart';
import 'package:handy_beachhack/view/constants/constants.dart';
import 'package:handy_beachhack/view/screens/learning/lessons/lecture_container.dart';
import 'package:handy_beachhack/view/screens/learning/lessons/selected_page.dart';
import 'package:handy_beachhack/view/widgets/appbar.dart';
import 'package:handy_beachhack/view/widgets/buttons/rounded_rect_primary.dart';

class NumberPage extends StatefulWidget {
  const NumberPage({Key? key}) : super(key: key);

  @override
  State<NumberPage> createState() => _NumberPageState();
}

class _NumberPageState extends State<NumberPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: appBarCustom(
          title: "numbers",
        ),
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 80,
              width: 200,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Color(0xff32BEA6),
              ),
              child: Text(
                "Continue",
                style: TextStyle(
                  color: white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        body: Column(
          children: [
            SvgPicture.asset(
              "assets/svg/number-svg.svg",
              height: 300,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    for (int i = 0; i < numbers.length; i++)
                      GestureDetector(
                        onTap: () {
                          Get.to(SelectedPage(
                              lecture: LectureModel.fromMap(numbers[i])));
                        },
                        child: LectureContainer(
                          lecture: LectureModel.fromMap(numbers[i]),
                        ),
                      )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
