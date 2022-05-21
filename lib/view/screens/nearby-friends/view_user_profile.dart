// import 'package:flutter/material.dart';
// import 'package:handy_beachhack/view/screens/profile/profile_page.dart';
// import 'package:handy_beachhack/view/widgets/buttons/rounded_rect_primary.dart';
// import 'package:stayfit/api/user_api.dart';
// import 'package:stayfit/models/user_model.dart';
// import 'package:stayfit/views/constants/constants.dart';
// import 'package:stayfit/views/screens/profile/profile_page.dart';
// import 'package:stayfit/views/wigdets/buttons/rounded_rect.dart';

// class ViewUserProfile extends StatefulWidget {
//   final String id;
//   const ViewUserProfile({Key? key, required this.id}) : super(key: key);

//   @override
//   State<ViewUserProfile> createState() => _ViewUserProfileState();
// }

// class _ViewUserProfileState extends State<ViewUserProfile> {
//   bool loading = false;
//   String buttonText = "send friend request";
//   UserModel? user;
//   @override
//   void initState() {
//     super.initState();
//     print("hhhhhhh");
//     UserApi.getDetailsUser(widget.id).then((value) => setState(() {
//           user = value;
//         }));
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         body: Stack(
//           children: [
//             user != null
//                 ? ProfilePage(userProfile: user!)
//                 : Center(
//                     child: CircularProgressIndicator(),
//                   ),
//             Positioned(
//                 bottom: 60,
//                 child: SizedBox(
//                   width: MediaQuery.of(context).size.width,
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       RoundedRectPrimaryButton(
//                           loading: loading,
//                           text: buttonText,
//                           onpressed: () async {
//                             setState(() {
//                               loading = true;
//                             });
//                             await UserApi.sendFriendRequest(user!.id);
//                             setState(() {
//                               loading = false;
//                               buttonText = "friend request sent";
//                             });
//                           }),
//                       // ElevatedButton(
//                       //     style: ButtonStyle(
//                       //         shape: MaterialStateProperty.all(
//                       //             const RoundedRectangleBorder(
//                       //                 borderRadius:
//                       //                     BorderRadius.all(Radius.circular(10)))),
//                       //         backgroundColor:
//                       //             MaterialStateProperty.all(primaryPurple)),
//                       //     onPressed: () async {

//                       //     },
//                       //     child: Text("Send Friend Request")),
//                     ],
//                   ),
//                 ))
//           ],
//         ),
//       ),
//     );
//   }
// }