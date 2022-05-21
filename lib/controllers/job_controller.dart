import 'package:get/get.dart';
import 'package:handy_beachhack/api/job_api.dart';
import 'package:handy_beachhack/models/job_model.dart';

class JobController extends GetxController {
  List<JobModel> jobList = [];
  getJobs() async {
    jobList = await JobApi.getJobs();
    print("total jobs ${jobList.length}");
    update();
  }
}
