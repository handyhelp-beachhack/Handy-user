import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:handy_beachhack/models/lecture_model.dart';
import 'package:handy_beachhack/view/constants/constants.dart';
import 'package:handy_beachhack/view/widgets/appbar.dart';
import 'package:handy_beachhack/view/widgets/buttons/rounded_rect_primary.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class SelectedPage extends StatefulWidget {
  const SelectedPage({Key? key, required this.lecture}) : super(key: key);
  final LectureModel lecture;
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
      initialVideoId: YoutubePlayer.convertUrlToId(widget.lecture.link)!,
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
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: white,
        appBar: appBarCustom(title: widget.lecture.word),
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
            RoundedRectPrimaryButton(
              width: 150,
              text: "next",
              onpressed: () {},
              color: Colors.green,
              textColor: primaryPurple,
            )
          ],
        ),
      ),
    );
  }
}
