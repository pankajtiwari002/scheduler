import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:scheduler/Repo/FirestoreMethods.dart';
import 'package:scheduler/Repo/notificationservice/LocalNotificationService.dart';
import 'package:scheduler/model/Schedule.dart';
import 'package:uuid/uuid.dart';

class EditScheduleController extends GetxController {
  DateTime initialDate = DateTime.now();
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();
  Rx<bool> isDate = true.obs;
  Rx<bool> isTime = true.obs;
  TextEditingController titleController = TextEditingController();
  int datetime;
  int id;
  String title;
  int index;

  EditScheduleController({required this.datetime,required this.id,required this.title,required this.index});

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    selectedDate  = DateTime.fromMillisecondsSinceEpoch(datetime);
    selectedTime = TimeOfDay.fromDateTime(selectedDate);
    titleController.text = title;
  }

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
      taskSchedule[index] = schedule.toJson();
      FirestoreMethods().updateData("users", {"taskSchedule": taskSchedule},
          FirebaseAuth.instance.currentUser!.uid);
      Get.back();
    } catch (e) {
      log(e.toString());
    }
  }
}
