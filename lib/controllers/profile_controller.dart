import 'package:bookly/models/user_profile.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../welcome_page.dart';

class ProfileController extends RxController {
  var userProfile = UserProfile("", "").obs;
  var isLoading = false.obs;
  final dio = Dio();
  GetStorage box = GetStorage();

  void retrieveUserProfile() async {
    isLoading.value = true;
    var token = box.read("token");
    var response = await dio.get(
        'https://book-crud-service-6dmqxfovfq-et.a.run.app/api/user',
        options: Options(
            headers: {
              Headers.acceptHeader: 'application/json',
              "Authorization": "Bearer $token"
            }
        )
    );
    Map<String, dynamic> userProfileMap = response.data;
    userProfile.value = UserProfile.fromMap(userProfileMap);
    isLoading.value = false;
  }

  void handleLogout() async {
    var token = box.read("token");
    var response = await dio.delete(
        'https://book-crud-service-6dmqxfovfq-et.a.run.app/api/user/logout',
        options: Options(
            headers: {
              Headers.acceptHeader: 'application/json',
              "Authorization": "Bearer $token"
            }
        )
    );
    if (response.statusCode == 200) {
      box.remove('token');
      Get.offAll(const WelcomePage());
    }
  }

  @override
  void onInit() {
    super.onInit();
    retrieveUserProfile();
  }
}