import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:handy_beachhack/api/user_api.dart';
import 'package:lottie/lottie.dart';

class NearByFriends extends StatefulWidget {
  const NearByFriends({Key? key}) : super(key: key);

  @override
  State<NearByFriends> createState() => _NearByFriendsState();
}

class _NearByFriendsState extends State<NearByFriends> {
  List<UserSimplify> users = [];
  bool connected = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    UserApi.getNearbyUsers("10").then((value) async {
      await Future.delayed(Duration(seconds: 4));
      setState(() {
        connected = true;
        users = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Column(
        children: [
          const Text(
            "Friends near you",
            style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          connected
              ? Expanded(
                  child: ListView.separated(
                      padding: const EdgeInsets.only(top: 20),
                      separatorBuilder: (_, __) => const SizedBox(
                            height: 30,
                          ),
                      itemCount: users.length,
                      itemBuilder: ((context, index) {
                        return _card(users[index]);
                      })),
                )
              : LottieBuilder.asset(
                  "assets/lotties/wave.json",
                  height: 200,
                  width: 200,
                )
        ],
      ),
    );
  }

  Widget _card(UserSimplify user) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(
          user.profiles.isEmpty
              ? "https://one1onehomeschooling.co.uk/images/avatar3.jpg"
              : user.profiles[0],
        ),
        radius: 50,
      ),
      title: Padding(
        padding: const EdgeInsets.only(right: 30.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              user.name,
              style: const TextStyle(
                fontSize: 18,
                color: Colors.white,
              ),
            ),
            InkWell(
              onTap: () {
                // Get.to(ViewUserProfile(
                //   id: user.id,
                // ));
              },
              child: Container(
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(5))),
                child: const Icon(Icons.add),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
