import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../screens/Add_donar_screen.dart';
import '../screens/donar_details_screen.dart';
import '../screens/hire_grandma_screen.dart';
import '../screens/map_screen.dart';
import '../screens/sell_screen.dart';
import '../screens/donate_screen.dart';
import '../screens/volunteer_screen.dart';

const webScreenSize = 600;

List<Widget> homeScreenItems = [
  MapScreen(),
  DonateScreen(""),
  VolunteerScreen(""),
  JobScreen(""),
  SellScreen(""),



  /*const AddPostScreen(),
  const Text('notifications'),
  ProfileScreen(
    uid: FirebaseAuth.instance.currentUser!.uid,
  ),*/
];
