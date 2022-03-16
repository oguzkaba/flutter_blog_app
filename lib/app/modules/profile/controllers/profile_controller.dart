// ignore_for_file: unused_import

import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_blog_app/app/data/remote/controller/get_account_controller.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';

class ProfileController extends GetxController {
  //GoogleMap
  final isLoadingFinish = false.obs;
  final isRequiredPermission = false.obs;
  final markers = <Marker>{};
  final dragMarkerPosition = false.obs;
  final latObs = 0.0.obs;
  final longObs = 0.0.obs;

  Position? currentLocation;
  CameraPosition? currentLatLng;
  GoogleMapController? mapController;

  addMark(newLatLng) {
    dragMarkerPosition.value = false;
    markers.clear();
    markers.add(Marker(
        zIndex: 5,
        draggable: true,
        onDragEnd: ((newLatLng) {
          currentLatLng = CameraPosition(target: newLatLng, zoom: 14.4746);
          latObs.value = newLatLng.latitude;
          longObs.value = newLatLng.longitude;
          dragMarkerPosition.value = true;
        }),
        markerId: MarkerId("Location"),
        position: LatLng(newLatLng.latitude, newLatLng.longitude),
        infoWindow: InfoWindow(title: 'Konumunuz')));
    dragMarkerPosition.value = true;
    return markers;
  }

//İmage Picker

  final isSelected = false.obs;
  final ImagePicker _picker = ImagePicker();
  List<XFile>? imageFileList = <XFile>[].obs;

  void openSelectedPicker(BuildContext context, ImageSource source) async {
    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: source,
        //preferredCameraDevice: CameraDevice.front
      );
      Get.back();
      if (pickedFile != null) {
        isSelected.value = true;
        imageFileList?.add(pickedFile);
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
