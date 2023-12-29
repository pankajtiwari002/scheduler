import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scheduler/Repo/FirestoreMethods.dart';
import 'package:scheduler/constants.dart';
import 'package:scheduler/model/User.dart';

import '../Repo/FirebaseAuthMethods.dart';

class SignUpController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Future<bool> signUpUser() async {
    try {
      final form = formKey.currentState;
      if (form!.validate()) {
        final userCred = await FirebaseAuthMethods().signUpWithEmailAndPassword(
            emailController.text, passwordController.text);
        if (userCred != null) {
          User user = User(
              name: nameController.text,
              email: emailController.text,
              fcm: Constants.fcm!,
              uid: userCred.user!.uid,
              taskSchedule: []
              );
          FirestoreMethods().uploadData("users", user.toJson(),user.uid);
        }
        return (userCred != null);
      }
      return false;
    } catch (e) {
      log(e.toString());
      return false;
    }
  }
}
