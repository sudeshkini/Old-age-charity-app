import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class User{
  final String email;
  final String uid;
  final String username;
  final String photoUrl;


  const User({
    required this.username,
    required this.email,
    required this.uid,
    required this.photoUrl,

  });
  static User fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return User(
      uid: snapshot["uid"],
      email: snapshot["email"],
      username: snapshot["username"],
      photoUrl: snapshot["photoUrl"],

    );
  }

  Map<String ,dynamic> toJson()=>{
    'uid': uid,
    'email': email,
    'username': username,
    'photoUrl': photoUrl,
  };

}