import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:handy_beachhack/api/registration.dart';
import 'package:handy_beachhack/view/constants/constants.dart';
import 'package:handy_beachhack/view/widgets/buttons/rounded_rect_primary.dart';
import 'package:handy_beachhack/view/widgets/textfield_custome.dart';

class MobileEntry extends StatefulWidget {
  const MobileEntry({Key? key}) : super(key: key);

  @override
  _MobileEntryState createState() => _MobileEntryState();
}

class _MobileEntryState extends State<MobileEntry> {
  TextEditingController mobileController = TextEditingController();
  TextEditingController countryController = TextEditingController(text: "+91");
  String mobile = "";
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
                    "assets/svg/login-svg.svg",
                    width: size.width - defaultPadding * 4,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    "Sign in/Sign up",
                    style: TextStyle(
                      fontSize: 19,
                      color: primaryPurple,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const Text(
                    "Enter your mobile to continue",
                    style: TextStyle(
                      fontSize: 10,
                      color: primaryPurple,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(
                    height: defaultPadding,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(defaultPadding),
                    child: Row(
                      children: [
                        TextFieldCustom(
                          hintText: "",
                          textEditingController: countryController,
                          width: 70,
                        ),
                        const SizedBox(
                          width: defaultPadding,
                        ),
                        Expanded(
                          child: TextFieldCustom(
                              hintText: "mobile",
                              keyboardType: TextInputType.number,
                              textEditingController: mobileController),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  const SizedBox(
                    height: 70,
                  ),
                  RoundedRectPrimaryButton(
                      loading: isLoading,
                      text: "Continue",
                      onpressed: () async {
                        setState(() {
                          isLoading = true;
                        });
                        int statusCode = await RegisterApi.emailCheck(
                                mobile: mobileController.text,
                                countryCode: countryController.text)
                            .whenComplete(() {
                          setState(() {
                            isLoading = false;
                          });
                        });
                        print("status on mobile : $statusCode");
                        if (statusCode == 200) {
                          // Get.to(OtpPage(
                          //   mobile: mobileController.text,
                          //   countryCode: countryController.text,
                          // ));
                          print("Success");
                        } else {
                          // Get.to(OtpPage());
                        }
                      })
                ]),
          ),
        ),
      ),
    );
  }
}
