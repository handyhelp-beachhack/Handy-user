import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:handy_beachhack/view/screens/nearby-friends/nearby_friends.dart';
import 'package:handy_beachhack/view/widgets/appbar.dart';

import '../../constants/constants.dart';

class FindFriends extends StatelessWidget {
  const FindFriends({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: appBarCustom(title: "Find friends"),
        body: Column(
          children: [
            SvgPicture.asset(
              "assets/svg/find-friend.svg",
              height: 400,
            ),
            Expanded(
                child: Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: primaryPurple,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20))),
              child: NearByFriends(),
            ))
          ],
        ),
      ),
    );
  }
}
