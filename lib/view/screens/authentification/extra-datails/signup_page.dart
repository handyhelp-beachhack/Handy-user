import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:handy_beachhack/view/constants/constants.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(backgroundColor: white),
    );
  }
}
