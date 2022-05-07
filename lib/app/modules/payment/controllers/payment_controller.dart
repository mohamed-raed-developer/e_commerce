import 'package:flutter/widgets.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class PaymentController extends GetxController {
  int radioContainerIndex = 1;
  bool changeColors = false;
  TextEditingController phoneController = TextEditingController();

  onChangeUser(int? value) {
    radioContainerIndex = value!;
    update();
    changeColors = !changeColors;
    update();
  }

  int radioPaymentIndex = 1;

  onChangePayment(int? value) {
    radioPaymentIndex = value!;
    update();
  }

  var phone = '';
  showPhoneInCard() {
    phone = phoneController.text;
    update();
  }

  var latitude = '';
  var longitude = '';
  var address = 'Your Address';
  bool isLoading = false;

  Future<void> updatePosition() async {
    isLoading = true;
    update();
    Position position = await _determinePosition();
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    Placemark place = placemarks[0];
    address = '${place.country},${place.street}';
    isLoading = false;
    update();
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.requestPermission();

      return await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    return await Geolocator.getCurrentPosition();
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    phoneController.dispose();
  }
}
