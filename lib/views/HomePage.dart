import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:scheduler/Repo/FirebaseAuthMethods.dart';
import 'package:scheduler/views/CreateScheduleScreen.dart';
import 'package:scheduler/views/EditScheduleScreen.dart';
import 'package:scheduler/views/authentication/LoginScreen.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          "Scheduler App",
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          TextButton(
              onPressed: () async {
                try {
                  await FirebaseAuthMethods().signOut();
                  Get.offAll(LoginScreen());
                } catch (e) {
                  log(e.toString());
                }
              },
              child: Text(
                "Sign Out",
                style: TextStyle(color: Colors.white),
              ))
        ],
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("users")
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active ||
                snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData) {
                return ListView.builder(
                    itemCount: snapshot.data!['taskSchedule'].length,
                    itemBuilder: ((context, index) {
                      return ListTile(
                        title: Text(
                            snapshot.data!['taskSchedule'][index]['title']),
                        subtitle: Text(
                            "${DateFormat('EEEE, MMMM d, yyyy').format(DateTime.fromMillisecondsSinceEpoch(snapshot.data!['taskSchedule'][index]['dateTime']))} ${DateFormat.jm().format(DateTime.fromMillisecondsSinceEpoch(snapshot.data!['taskSchedule'][index]['dateTime']))}"),
                        trailing: IconButton(
                            onPressed: () {
                              Get.to(() => EditScheduleScreen(
                                  dateTime: snapshot.data!['taskSchedule']
                                      [index]['dateTime'],
                                  id: snapshot.data!['taskSchedule'][index]
                                      ['id'],
                                  title: snapshot.data!['taskSchedule'][index]
                                      ['title'],
                                  index: index,));
                            },
                            icon: Icon(Icons.edit)),
                      );
                    }));
              }
            }
            return Container();
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => CreateScheduleScreen());
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
