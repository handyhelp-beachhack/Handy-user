import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:handy_beachhack/view/constants/constants.dart';
import 'package:handy_beachhack/view/screens/learning/learning_container.dart';
import 'package:handy_beachhack/view/widgets/appbar.dart';

class LearningPage extends StatefulWidget {
  const LearningPage({Key? key}) : super(key: key);

  @override
  State<LearningPage> createState() => _LearningPageState();
}

class _LearningPageState extends State<LearningPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: appBarCustom(title: "learning"),
        body: Container(
          padding: EdgeInsets.all(defaultPadding),
          child: Column(
            children: const [
              LearningContainer(
                  title: "ASL tuorials",
                  decription: "ASL basics to advanced",
                  color: white,
                  opacity: .1,
                  image:
                      "https://c0.wallpaperflare.com/preview/803/320/871/translate-translation-web-service.jpg"),
              const SizedBox(
                height: defaultPadding,
              ),
              LearningContainer(
                  title: "Revision",
                  decription: "quick revision of signs",
                  color: white,
                  opacity: .2,
                  image:
                      "https://c0.wallpaperflare.com/preview/1005/983/706/business-concept-consulting-illustration-thumbnail.jpg"),
              const SizedBox(
                height: defaultPadding,
              ),
              LearningContainer(
                  title: "ASL Assignments",
                  decription: "complete assignments and earn badges",
                  color: white,
                  opacity: .1,
                  image:
                      "https://c0.wallpaperflare.com/preview/724/512/41/checklist-business-businesswoman-notebook.jpg"),
            ],
          ),
        ),
      ),
    );
  }
}
