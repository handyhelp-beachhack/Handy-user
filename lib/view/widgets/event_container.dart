import 'package:flutter/material.dart';

class EventContainer extends StatelessWidget {
  const EventContainer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Container(
            height: 130,
            width: double.maxFinite,
            decoration: BoxDecoration(),
            child: Image.network(
              "https://i.pinimg.com/originals/e2/35/b1/e235b1d82a4a38f91a4be6ed77ff0418.jpg",
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned(
            bottom: 20,
            right: 10,
            child: Text(
              "Koratty Infopark",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            )),
        Positioned(
            bottom: 4,
            right: 10,
            child: Text(
              "At 2:00 pm IST",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ))
      ],
    );
  }
}
