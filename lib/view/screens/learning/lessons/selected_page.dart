import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:handy_beachhack/models/lecture_model.dart';
import 'package:handy_beachhack/view/constants/constants.dart';
import 'package:handy_beachhack/view/screens/home/home_page.dart';
import 'package:handy_beachhack/view/screens/learning/lessons/numbers/number_page.dart';
import 'package:handy_beachhack/view/widgets/appbar.dart';
import 'package:handy_beachhack/view/widgets/buttons/rounded_rect_primary.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class SelectedPage extends StatefulWidget {
  const SelectedPage({Key? key, required this.lectures, required this.index})
      : super(key: key);
  final List<LectureModel> lectures;
  final int index;
  @override
  State<SelectedPage> createState() => _SelectedPageState();
}

class _SelectedPageState extends State<SelectedPage> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId:
          YoutubePlayer.convertUrlToId(widget.lectures[widget.index].link)!,
      flags: YoutubePlayerFlags(
        hideThumbnail: true,
        autoPlay: true,
        // endAt: -1,
        mute: true,
        loop: true,
        hideControls: true,
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: white,
        appBar: appBarCustom(
          title: widget.lectures[widget.index].word,
          prefixWidget: InkWell(
              onTap: () {
                Get.off(HomePage());
              },
              child: Icon(
                Icons.arrow_back,
                color: white,
                size: 22,
              )),
        ),
        body: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Expanded(
              child: SizedBox(
                height: double.maxFinite,
                child: YoutubePlayer(
                  controller: _controller,
                  showVideoProgressIndicator: true,
                ),
              ),
            ),
            InkWell(
              onTap: () {
                print("index ${widget.index}");
                print("lectures ${widget.lectures.length}");
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => SelectedPage(
                          lectures: widget.lectures, index: widget.index + 1)),
                );
                // Get.to();
              },
              child: Container(
                height: 80,
                width: 200,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Color(0xff32BEA6),
                ),
                child: Text(
                  "Next",
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
    );
  }
}
