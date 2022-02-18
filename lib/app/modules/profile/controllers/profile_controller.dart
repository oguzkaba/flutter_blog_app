import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ProfileController extends GetxController {
  final isLoadingFinish = false.obs;
  final isRequiredPermission = false.obs;
  Position? currentLocation;
  CameraPosition? currentLatLng;
  late GoogleMapController mapController;

  @override
  void onInit() {
    getterLocations();
    super.onInit();
  }

  Future<Position?> getLocation() async {
    print("getLocation start");
    var perm = await Geolocator.checkPermission();
    print("permission checked $perm");
    if (perm == LocationPermission.denied) {
      print("DENIED");
      return null;
    }
    print("LOCATION WAITING");
    return await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high)
        .catchError((e) {
      print("[!] Error permission : $e");
    });
  }

  void permissionOK() {
    getLocation().then((pos) {
      if (pos == null) {
        isRequiredPermission.value = true;
        currentLocation = pos;
        isLoadingFinish.value = false;
        print("OK CURRENT LOCATION  : $pos");
      } else {
        currentLatLng = CameraPosition(
          target: LatLng(pos.latitude, pos.longitude),
          zoom: 14.4746,
        );
        mapController
            .animateCamera(CameraUpdate.newCameraPosition(currentLatLng!));
        isRequiredPermission.value = false;
        isLoadingFinish.value = true;
      }
    });
  }

  void getterLocations() {
    Geolocator.requestPermission().then((request) {
      print("REQUEST : $request");
      if (GetPlatform.isIOS || GetPlatform.isAndroid) {
        if (request == LocationPermission.denied ||
            request == LocationPermission.deniedForever) {
          print("NOT LOCATION PERMISSION");
          return;
        } else {
          print("PERMISSION OK");
          permissionOK();
        }
      }
    });
  }

  @override
  void onClose() {
    super.onClose();
  }
}
