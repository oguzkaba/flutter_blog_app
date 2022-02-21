import 'package:flutter_blog_app/app/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class PrefController extends GetxController {
  final box = GetStorage();
  final token = "".obs;
  final image = "".obs;
  final isLogin = false.obs;

  @override
  Future<void> onInit() async {
    if (box.read('login') != null) {
      await _loadFromPrefs();
      print('İlk gelen token: ${box.read('token')}');
    }
    super.onInit();
  }

  String getShared() {
    return isRemember()
        ? Routes.MAIN
        : Routes.LOGIN; // beni hatırla durumuna göre yönlendirilecek sayfa
  }

  bool isRemember() {
    return box.read('login') ??
        false; 
  }

  //Login remember shared pref begin-----

  _initPrefs() async {
    await GetStorage.init();
  }

  saveToPrefs() async {
    await _initPrefs();
    box.write('login', isLogin.value);
    box.write('token', token.value);
    box.write('image', image.value);
  }

  _loadFromPrefs() async {
    //tum degiskenlere pref deki bilgileri at
    isLogin.value = box.read('login') as bool;
    token.value = box.read('token');
    image.value = box.read('image');
    await _initPrefs();
  }

  deleteFromPrefs() async {
    //tum pref bilgilerini sil
    await _initPrefs();
    box.remove('login');
    box.remove('token');
    box.remove('image');
  }

//Login remember shared pref end-----
}
