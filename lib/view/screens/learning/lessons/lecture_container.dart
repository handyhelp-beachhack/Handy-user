import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:handy_beachhack/models/lecture_model.dart';
import 'package:handy_beachhack/view/constants/constants.dart';

class LectureContainer extends StatefulWidget {
  const LectureContainer({
    Key? key,
    required this.lecture,
  }) : super(key: key);

  final LectureModel lecture;

  @override
  State<LectureContainer> createState() => _LectureContainerState();
}

class _LectureContainerState extends State<LectureContainer> {
  // int _currentIndex = 5;
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.all(8),
      height: 90,
      margin: EdgeInsets.symmetric(horizontal: defaultPadding, vertical: 8),
      width: double.maxFinite,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: white,
        boxShadow: [
          BoxShadow(color: primaryPurple.withOpacity(.1), blurRadius: 5)
        ],
      ),
      child: Row(
        children: [
          Image.asset(
            widget.lecture.completed
                ? 'assets/png/check.png'
                : 'assets/png/uncheck.png',
            height: 50,
          ),
          const SizedBox(
            width: defaultPadding,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                widget.lecture.word,
                style: TextStyle(
                  color: primaryPurple,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                widget.lecture.completed ? "completed" : "not completed",
                style: TextStyle(
                  color: grey,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
