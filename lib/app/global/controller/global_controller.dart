import 'package:get/get.dart';

class GlobalController extends GetxController{
  final _isVisible = false.obs;
  
  bool get isVisible => _isVisible.value;
  set isVisible(bool value) => _isVisible.value = value;

  }