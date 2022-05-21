import 'package:flutter/material.dart';
import 'package:handy_beachhack/view/constants/constants.dart';
import 'package:handy_beachhack/view/widgets/buttons/rounded_rect_primary.dart';
import 'package:handy_beachhack/view/widgets/toast/toast.dart';

class HandicapTypeWidget extends StatefulWidget {
  final Function(String type) onTap;
  const HandicapTypeWidget({Key? key, required this.onTap}) : super(key: key);

  @override
  State<HandicapTypeWidget> createState() => _HandicapTypeWidgetState();
}

class _HandicapTypeWidgetState extends State<HandicapTypeWidget> {
  int selectedIndex = -1;
  final List<Map<String, String>> types = [
    {"url": "mute.png", "type": "mute"},
    {"url": "deaf.png", "type": "deaf"},
    {"url": "blind.png", "type": "blind"},
  ];
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
            height: 420,
            width: 300,
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(12))),
            child: Material(
                child: Column(
              children: [
                Expanded(
                  child: GridView.count(
                    crossAxisCount: 2,
                    childAspectRatio: 1.2,
                    mainAxisSpacing: defaultPadding,
                    padding: const EdgeInsets.only(top: defaultPadding),
                    children: List.generate(
                      3,
                      (index) => InkWell(
                        onTap: () {
                          setState(() {
                            selectedIndex = index;
                          });
                        },
                        child: CircleAvatar(
                            radius: 30,
                            backgroundColor: selectedIndex == index
                                ? Colors.green
                                : primaryPurple,
                            child: CircleAvatar(
                              radius: 55,
                              backgroundColor: Colors.white,
                              backgroundImage: Image.asset(
                                "assets/png/${types[index]['url']}",
                                height: 20,
                                width: 20,
                                fit: BoxFit.contain,
                              ).image,
                            )),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 30.0),
                  child: RoundedRectPrimaryButton(
                      text: "Finish Setup",
                      onpressed: () {
                        if (selectedIndex >= 0 && selectedIndex < 3) {
                          widget.onTap(types[selectedIndex]["type"]!);
                          Navigator.pop(context);
                        } else {
                          showToast(
                              context: context,
                              title: "Select a handi",
                              description: "",
                              icon: Icons.warning,
                              color: Colors.amber);
                        }
                      }),
                )
              ],
            )))
      ],
    );
  }
}
