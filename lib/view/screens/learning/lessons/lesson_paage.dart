import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:handy_beachhack/view/constants/constants.dart';
import 'package:handy_beachhack/view/screens/learning/lessons/lesson_container.dart';
import 'package:handy_beachhack/view/screens/learning/lessons/numbers/number_page.dart';
import 'package:handy_beachhack/view/screens/learning/lessons/other/other_page.dart';
import 'package:handy_beachhack/view/widgets/appbar.dart';

class LessonPage extends StatefulWidget {
  const LessonPage({Key? key}) : super(key: key);

  @override
  State<LessonPage> createState() => _LessonPageState();
}

class _LessonPageState extends State<LessonPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: appBarCustom(title: "your lessons"),
        body: SingleChildScrollView(
          child: Padding(
              padding: EdgeInsets.all(defaultPadding),
              child: Column(children: [
                LessonContainer(
                    title: "Alphabets",
                    decription: "0% completed",
                    image:
                        "https://c0.wallpaperflare.com/preview/746/150/495/computer-concept-education-illustration.jpg",
                    ontap: () {
                      Get.to(OtherLessons());
                    }),
                const SizedBox(
                  height: defaultPadding,
                ),
                LessonContainer(
                    title: "numbers",
                    decription: "10% completed",
                    image:
                        "https://thumbs.dreamstime.com/b/scattered-numbers-wallpaper-background-use-use-design-layouts-content-creation-scattered-numbers-wallpaper-166001346.jpg",
                    ontap: () {
                      Get.to(NumberPage());
                    }),
                const SizedBox(
                  height: defaultPadding,
                ),
                LessonContainer(
                    title: "foods",
                    decription: "0% completed",
                    image:
                        "https://st3.depositphotos.com/9682094/17740/v/1600/depositphotos_177404824-stock-illustration-set-of-vector-cartoon-doodle.jpg",
                    ontap: () {
                      Get.to(OtherLessons());
                    }),
                const SizedBox(
                  height: defaultPadding,
                ),
                LessonContainer(
                    title: "family",
                    decription: "0% completed",
                    image:
                        "https://wallup.net/wp-content/uploads/2019/09/179621-the-croods-animation-adventure-comedy-family-cartoon-movie-748x421.jpg",
                    ontap: () {
                      Get.to(OtherLessons());
                    }),
                const SizedBox(
                  height: defaultPadding,
                ),
                LessonContainer(
                    title: "colors",
                    decription: "0% completed",
                    image:
                        "https://thumbs.dreamstime.com/z/abstract-waves-hand-drawn-wallpaper-background-cartoon-style-rainbow-colors-contrast-159165367.jpg",
                    ontap: () {
                      Get.to(OtherLessons());
                    }),
                const SizedBox(
                  height: defaultPadding,
                ),
                LessonContainer(
                    title: "objects",
                    decription: "0% completed",
                    image:
                        "https://cdn.pixabay.com/photo/2017/02/14/16/19/blue-2066341_960_720.png",
                    ontap: () {
                      Get.to(OtherLessons());
                    }),
                const SizedBox(
                  height: defaultPadding,
                ),
                LessonContainer(
                    title: "actions",
                    decription: "0% completed",
                    image: "https://wallpaperaccess.com/full/2907957.jpg",
                    ontap: () {
                      Get.to(OtherLessons());
                    }),
              ])),
        ),
      ),
    );
  }
}
