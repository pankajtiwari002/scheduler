import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:scheduler/Repo/FirestoreMethods.dart';
import 'package:scheduler/Repo/notificationservice/LocalNotificationService.dart';
import 'package:scheduler/model/Schedule.dart';
import 'package:uuid/uuid.dart';

class CreateScheduleController extends GetxController {
  DateTime initialDate = DateTime.now();
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();
  Rx<bool> isDate = false.obs;
  Rx<bool> isTime = false.obs;
  TextEditingController titleController = TextEditingController();

  String formatTimeOfDay(TimeOfDay timeOfDay) {
    final now = DateTime.now();
    final dateTime = DateTime(
        now.year, now.month, now.day, timeOfDay.hour, timeOfDay.minute);

    return DateFormat.jm().format(dateTime); // 'jm' formats as 'h:mm a'
  }

  selectTime(BuildContext context) async {
    TimeOfDay? time;
    time = await showTimePicker(context: context, initialTime: TimeOfDay.now());
    if (time != null) {
      selectedTime = time;
      isTime.value = false;
      isTime.value = true;
    }
    update();
  }

  scheduleEvent() async {
    try {
      DateTime dateTime = DateTime(
        selectedDate.year,
        selectedDate.month,
        selectedDate.day,
        selectedTime.hour,
        selectedTime.minute,
      );

      int id = dateTime.millisecondsSinceEpoch % 1703838480000;

      LocalNotificationService().scheduleNotification(
          id: id,
          title: titleController.text,
          body: "",
          scheduleNotificationTime: dateTime);
      Schedule schedule = Schedule(
          title: titleController.text,
          dateTime: dateTime.millisecondsSinceEpoch,
          id: id);
      final user = await FirestoreMethods()
          .getData("users", FirebaseAuth.instance.currentUser!.uid);
      List<dynamic> taskSchedule = user['taskSchedule'].toList();
      taskSchedule.add(schedule.toJson());
      FirestoreMethods().updateData("users", {"taskSchedule": taskSchedule},
          FirebaseAuth.instance.currentUser!.uid);
      Get.back();
    } catch (e) {
      log(e.toString());
    }
  }
}
