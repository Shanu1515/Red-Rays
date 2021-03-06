import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:plasma/Donor/Screen/donate1.dart';
import 'package:plasma/Donor/Screen/feed1.dart';
import 'package:plasma/Donor/Screen/form1.dart';
import 'package:plasma/Donor/Screen/profile1.dart';
import 'package:plasma/Donor/Screen/search1.dart';

import 'package:plasma/global.dart';

class Bottom1 extends StatefulWidget {
  @override
  _BottomState createState() => _BottomState();
}

class _BottomState extends State<Bottom1> {
  int index = 0;
  void tapped(int index1) {
    setState(() {
      index = index1;
    });
  }

  Future read() async {
    FirebaseDatabase.instance
        .reference()
        .child("Donator")
        .child(uid2)
        .once()
        .then((DataSnapshot snapshot) {
      Map<dynamic, dynamic> values;
      values = snapshot.value;

      values.forEach((key, value) {
        //
        FirebaseDatabase.instance
            .reference()
            .child("Donator")
            .child(uid2)
            .child("fullname")
            .once()
            .then((DataSnapshot s) {
          globalname1 = s.value;
        });
      });
      values.forEach((key, value) {
        //
        FirebaseDatabase.instance
            .reference()
            .child("Donator")
            .child(uid2)
            .child("image")
            .once()
            .then((DataSnapshot s) {
          globalimage1 = s.value;
        });
      });
    });
  }

  @override
  void initState() {
    super.initState();
    read();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> widget1 = [
      Feed1(),
      Search1(),
      Form1(),
      Donate1(),
      Profile1(),
    ];

    return Scaffold(
      body: widget1.elementAt(index),
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          canvasColor: Color(0xFF222222),
        ),
        child: BottomNavigationBar(
            showSelectedLabels: true,
            unselectedItemColor: Colors.white70,
            showUnselectedLabels: true,
            elevation: 18,
            type: BottomNavigationBarType.fixed,
            selectedItemColor: Colors.white,
            currentIndex: index,
            onTap: tapped,
            items: [
              BottomNavigationBarItem(
                  icon: Icon(Icons.home), title: Text("Feed")),
              BottomNavigationBarItem(
                  icon: Icon(FontAwesomeIcons.search), title: Text("Search")),
              BottomNavigationBarItem(
                  icon: Icon(FontAwesomeIcons.handsHelping),
                  title: Text("Donate")),
              BottomNavigationBarItem(
                  icon: Icon(FontAwesomeIcons.list), title: Text("Requests")),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person), title: Text("Profile")),
            ]),
      ),
    );
  }
}
