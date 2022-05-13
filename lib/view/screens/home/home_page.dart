import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:handy_beachhack/view/constants/constants.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(backgroundColor: white),
    );
  }
}
