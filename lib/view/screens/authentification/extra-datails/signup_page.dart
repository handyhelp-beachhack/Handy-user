import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:handy_beachhack/api/user_api.dart';
import 'package:handy_beachhack/view/constants/constants.dart';
import 'package:handy_beachhack/view/screens/authentification/extra-datails/handicap_type.dart';
import 'package:handy_beachhack/view/widgets/buttons/rounded_rect_primary.dart';
import 'package:handy_beachhack/view/widgets/toast/toast.dart';

import '../../../widgets/textfield_custome.dart';
import '../../eventt-creation/calender_overlay.dart';
import '../../eventt-creation/event_day_container.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  late TextEditingController nameController,
      emergencyNumberController,
      bioTextController;
  String? dob;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    nameController = TextEditingController();
    bioTextController = TextEditingController();

    emergencyNumberController = TextEditingController();
  }

  @override
  void dispose() {
    nameController.dispose();
    emergencyNumberController.dispose();
    super.dispose();
  }

  String? gender;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
          backgroundColor: white,
          body: SingleChildScrollView(
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
                  "Basic Details",
                  style: TextStyle(
                    fontSize: 19,
                    color: primaryPurple,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(
                  height: defaultPadding,
                ),
                Padding(
                  padding: const EdgeInsets.all(defaultPadding),
                  child: Column(
                    children: [
                      TextFieldCustom(
                          hintText: "Name",
                          keyboardType: TextInputType.name,
                          textEditingController: nameController),
                      const SizedBox(
                        height: defaultPadding,
                      ),
                      TextFieldCustom(
                          hintText: "Guardian Number",
                          keyboardType: TextInputType.number,
                          textEditingController: emergencyNumberController),
                      const SizedBox(
                        height: defaultPadding,
                      ),
                      InkWell(
                          onTap: () {
                            late OverlayEntry overlayEntry;
                            overlayEntry = OverlayEntry(
                                builder: (context) => CalenderOverlay(
                                      onDateChanged: (time) {
                                        setState(() {
                                          dob =
                                              time.toString().substring(0, 10);
                                          overlayEntry.remove();
                                        });
                                      },
                                      calenderOverlay: overlayEntry,
                                    ));
                            Overlay.of(context)?.insert(overlayEntry);
                          },
                          child: EventDayContainer(
                              birthdayDateString: dob ?? "DOB")),
                      const SizedBox(
                        height: defaultPadding,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Row(children: [
                            const Text('Male'),
                            Radio<String>(
                              value: "male",
                              groupValue: gender,
                              onChanged: (value) {
                                setState(() {
                                  gender = value;
                                });
                              },
                            ),
                          ]),
                          Row(children: [
                            const Text('Female'),
                            Radio<String>(
                              value: "female",
                              groupValue: gender,
                              onChanged: (value) {
                                setState(() {
                                  gender = value;
                                });
                              },
                            ),
                          ]),
                          Row(children: [
                            const Text('Other'),
                            Radio<String>(
                              value: "other",
                              groupValue: gender,
                              onChanged: (value) {
                                setState(() {
                                  gender = value;
                                });
                              },
                            ),
                          ]),
                        ],
                      ),
                      const SizedBox(
                        height: defaultPadding,
                      ),
                      Form(
                        child: TextFormField(
                          controller: bioTextController,
                          maxLength: 300,
                          maxLines: 5,
                          decoration: const InputDecoration(
                            filled: true,
                            fillColor: white,
                            hintText: "Bio",
                            border: OutlineInputBorder(
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(12))),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: defaultPadding,
                ),
                RoundedRectPrimaryButton(
                    text: "Continue", onpressed: _onPressed),
                const SizedBox(
                  height: defaultPadding,
                ),
              ]))),
    );
  }

  void _onPressed() {
    if (nameController.text.isEmpty) {
      showToast(
          context: context,
          title: "Name Field should not be empty",
          description: "",
          icon: Icons.warning,
          color: Colors.amber);
      return;
    }

    if (emergencyNumberController.text.isEmpty) {
      showToast(
          context: context,
          title: "Guardian number is required",
          description: "",
          icon: Icons.warning,
          color: Colors.amber);
      return;
    }
    if (gender == null) {
      showToast(
          context: context,
          title: "Gender is required",
          description: "",
          icon: Icons.warning,
          color: Colors.amber);
      return;
    }

    if (bioTextController.text.isEmpty) {
      showToast(
          context: context,
          title: "Bio is required",
          description: "",
          icon: Icons.warning,
          color: Colors.amber);
      return;
    }

    if (dob == null) {
      showToast(
          context: context,
          title: "DOB is required",
          description: "",
          icon: Icons.warning,
          color: Colors.amber);
      return;
    }

    showDialog(
        context: context,
        builder: (context) => HandicapTypeWidget(onTap: updateUser));
  }

  void updateUser(String type) {
    UserApi.updateUserDetails(
        nameController.text,
        emergencyNumberController.text,
        dob!,
        type,
        bioTextController.text,
        gender!);
  }
}
