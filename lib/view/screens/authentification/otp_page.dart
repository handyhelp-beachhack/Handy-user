import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:handy_beachhack/api/registration.dart';
import 'package:handy_beachhack/view/constants/constants.dart';
import 'package:handy_beachhack/view/widgets/buttons/rounded_rect_primary.dart';

import '../../widgets/otp_textfield.dart';

class OtpPage extends StatefulWidget {
  const OtpPage(
      {Key? key,
      required this.mobile,
      required this.countryCode,
      required this.passedOtp})
      : super(key: key);

  @override
  _OtpPageState createState() => _OtpPageState();
  final String mobile;
  final String countryCode;
  final String passedOtp;
}

class _OtpPageState extends State<OtpPage> {
  TextEditingController mobileController = TextEditingController();
  TextEditingController countryController = TextEditingController(text: "+91");
  String token = "";
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: white,
        body: Container(
          width: size.width,
          padding: EdgeInsets.all(defaultPadding),
          child: SingleChildScrollView(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  SvgPicture.asset(
                    "assets/svg/otp-svg.svg",
                    width: size.width - defaultPadding * 4,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    "Otp Verification",
                    style: TextStyle(
                      fontSize: 19,
                      color: primaryPurple,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const Text(
                    "Enter the OTP to continue",
                    style: TextStyle(
                      fontSize: 10,
                      color: primaryPurple,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(
                    height: defaultPadding,
                  ),
                  Align(
                      alignment: Alignment.center,
                      child: OtpTextField(
                        length: 6,
                        keyboardType: TextInputType.number,
                        width: 40,
                        onEntered: (String verificationCode) {
                          token += verificationCode;
                        },
                      )
                      //  OtpTextField(
                      //   numberOfFields: 6,
                      //   borderColor: primaryPurple,
                      //   focusedBorderColor: primaryPurple,
                      //   cursorColor: primaryPurple,
                      //   keyboardType: TextInputType.number,
                      //   //set to true to show as box or false to show as dash
                      //   showFieldAsBox: true,
                      //   //runs when a code is typed in
                      //   onCodeChanged: (String code) {
                      //     //handle validation or checks here
                      //     setState(() {
                      //       token = code;
                      //     });
                      //   },
                      //   //runs when every textfield is filled
                      //   onSubmit: (String verificationCode) {
                      //     token = verificationCode;
                      //   }, // end onSubmit
                      // ),
                      ),
                  const SizedBox(
                    height: 50,
                  ),
                  const SizedBox(
                    height: 70,
                  ),
                  RoundedRectPrimaryButton(
                      text: "Continue",
                      onpressed: () async {
                        int status = await RegisterApi.verificationApi(
                            mobile: widget.mobile,
                            countryCode: widget.countryCode,
                            otp: widget.passedOtp);
                      })
                ]),
          ),
        ),
      ),
    );
  }
}
