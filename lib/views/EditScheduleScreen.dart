import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:scheduler/controller/EditScheduleController.dart';

class EditScheduleScreen extends StatelessWidget {
  late EditScheduleController controller;
  int dateTime;
  int id;
  String title;
  int index;
  EditScheduleScreen(
      {super.key,
      required this.dateTime,
      required this.id,
      required this.title,
      required this.index,
      }) {
    controller = Get.put(
        EditScheduleController(datetime: dateTime, id: id, title: title,index: index));
  }

  DateTime date = DateTime.now();

  _openDateTimePicker(BuildContext context) {
    Get.bottomSheet(
      Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(40),
            topRight: Radius.circular(40),
          ),
          color: Colors.white,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Select Date",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    icon: Icon(Icons.close))
              ],
            ),
            Divider(),
            Container(
              height: 300,
              child: CalendarDatePicker(
                  initialDate: controller.initialDate,
                  firstDate: DateTime.now(),
                  lastDate: DateTime(2101),
                  onDateChanged: (data) {
                    date = data;
                  }),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 18),
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  // controller.isDate.value = false;
                  controller.selectedDate = date;
                  controller.isDate.value = false;
                  controller.isDate.value = true;
                  Get.back();
                },
                child: Text("Select"),
              ),
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          "Schedule Event",
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 18, vertical: 12),
        child: Column(
          children: [
            TextFormField(
              controller: controller.titleController,
              decoration: InputDecoration(
                  label: Text('Title'),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15))),
            ),
            SizedBox(
              height: 15,
            ),
            ListTile(
              onTap: () {
                _openDateTimePicker(context);
              },
              leading: Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color.fromARGB(255, 208, 227, 243)),
                child: Icon(
                  Icons.calendar_month,
                  color: Colors.blue,
                ),
              ),
              title: Obx(() {
                if (controller.isDate.value) {
                  return Text(
                      "${DateFormat('EEEE, MMMM d, yyyy').format(controller.selectedDate)}");
                }
                return Text("Select Date");
              }),
            ),
            SizedBox(
              height: 16,
            ),
            ListTile(
              onTap: () async {
                await controller.selectTime(context);
              },
              leading: Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color.fromARGB(255, 208, 227, 243)),
                child: Icon(
                  Icons.access_time,
                  color: Colors.blue,
                ),
              ),
              title: Obx(() {
                if (controller.isTime.value) {
                  return Text(
                      "${controller.formatTimeOfDay(controller.selectedTime)}");
                }
                return Text("Select Time");
              }),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        margin: EdgeInsets.symmetric(horizontal: 18, vertical: 16),
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () {
            controller.scheduleEvent();
          },
          child: Text("Schedule an Event"),
        ),
      ),
    );
  }
}
