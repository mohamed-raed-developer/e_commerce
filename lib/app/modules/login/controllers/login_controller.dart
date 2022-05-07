import 'package:e_commerce/app/data/models/facebook_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:logger/logger.dart';

import '../../../routes/app_pages.dart';

class LoginController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();
  var auth = FirebaseAuth.instance;
  var googleSignIn = GoogleSignIn();
  FacebookModel? facebookModel;
  var image = '';
  var name = '';
  var email = '';
  var isSignIn = false;
  final GetStorage authBox = GetStorage();

  bool isVisibility = false;
  bool isCheckBox = false;

  User? get userProfile => auth.currentUser;

  void visibility() {
    isVisibility = !isVisibility;
    update();
  }

  void checkBox() {
    isCheckBox = !isCheckBox;
    update();
  }

  void loginEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      await auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) {
        name = auth.currentUser!.displayName!;
      });
      isSignIn = true;
      authBox.write('auth', isSignIn);
      update();
      Get.offNamed(Routes.BOTTOM_NAV);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Get.snackbar(
          'Erorr',
          'No user found for that email.',
          backgroundColor: Colors.red,
        );
      } else if (e.code == 'wrong-password') {
        Get.snackbar(
          'Erorr',
          'Wrong password provided for that user.',
          backgroundColor: Colors.red,
        );
      }
    }
  }

  void loginWithGoogle() async {
    // var nameSignUp = Get.find<SignupController>().displayName;
    try {
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      name = googleUser!.displayName!;
      image = googleUser.photoUrl!;
      email = googleUser.email;
      GoogleSignInAuthentication googleSignInAuthentication =
          await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        idToken: googleSignInAuthentication.idToken,
        accessToken: googleSignInAuthentication.accessToken,
      );
      await auth.signInWithCredential(credential);
      isSignIn = true;
      authBox.write('auth', isSignIn);
      update();
      Get.offNamed(Routes.BOTTOM_NAV);
    } catch (e) {
      Get.snackbar(
        'Error',
        e.toString(),
        backgroundColor: Colors.red,
      );
    }
  }

  void loginWithFacebook() async {
    final LoginResult loginResult = await FacebookAuth.instance.login();
    if (loginResult.status == LoginStatus.success) {
      final data = await FacebookAuth.instance.getUserData();
      facebookModel = FacebookModel.fromJson(data);
      Logger().e(facebookModel!.name);
      isSignIn = true;
      authBox.write('auth', isSignIn);
      update();
      Get.offNamed(Routes.BOTTOM_NAV);
    }
  }

  void signOut() async {
    try {
      await auth.signOut();
      await googleSignIn.signOut();
      await FacebookAuth.i.logOut();
      name = '';
      image = '';
      isSignIn = false;
      authBox.remove('auth');
      update();
      Get.offNamed(Routes.WELCOME)!;
    } catch (e) {
      Get.snackbar(
        'Error',
        e.toString(),
        backgroundColor: Colors.red,
      );
    }
  }

  @override
  void onInit() {
    super.onInit();
    name = (userProfile != null ? userProfile!.displayName : '')!;
    image = (userProfile != null ? userProfile!.photoURL : '')!;
    email = (userProfile != null ? userProfile!.email : '')!;
    // loginWithGoogle();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
  }
}
