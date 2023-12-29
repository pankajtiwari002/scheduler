
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scheduler/Repo/FirebaseAuthMethods.dart';
import 'package:scheduler/constants.dart';

import '../Repo/FirestoreMethods.dart';

class LoginController extends GetxController{
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Future<bool> loginUser() async{
    try{
      final form = formKey.currentState;
      if(form!.validate()){
        final userCred = await FirebaseAuthMethods().signInWithEmailAndPassword(emailController.text, passwordController.text);
        if (userCred != null) {
          FirestoreMethods().updateData("users", {"fcm": Constants.fcm},userCred.user!.uid);
        }
        return (userCred != null);
      }
      return false;
    }catch(e){
      log(e.toString());
      return false;
    }
  }
}