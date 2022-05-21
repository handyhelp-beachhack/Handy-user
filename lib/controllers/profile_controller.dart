import 'package:get/get.dart';
import 'package:handy_beachhack/api/profile_api.dart';
import 'package:handy_beachhack/api/user_api.dart';
import 'package:handy_beachhack/controllers/user_model.dart';

class ProfileController extends GetxController {
  List<UserModel> userList = [];
  getJobs() async {
    userList = await ProfileApi.getJobs();
    print("total jobs ${userList.length}");
    update();
  }
}
